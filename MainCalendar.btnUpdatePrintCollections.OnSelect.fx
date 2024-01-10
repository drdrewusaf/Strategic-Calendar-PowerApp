// This creates a visually better collection for display, but takes a lot of time/resources to finish.  So, it's been relegated to use for a print view.
// It runs when the Print button on MainCalendar is clicked
// Begin ***** Code
// Declare the variable helper
ClearCollect(EventOrderCalcVariables, {
    foundSlot: -1,
    targetWeekColumn: "",
    IS_UNORDERED: 9999,
    DEBUG_VAL: 0,
    DEBUG_VAL2: false
});

// Pull events from the strategic calendar collection, filter down to 1 day prior and 1 day after the current month. Lastly add helper columns for each week
ClearCollect(CalendarItemsPrint,  AddColumns(
    ShowColumns(CalendarItems, 
            "Title", 
            "StartDate", 
            "EndDate", 
            "Location", 
            "Description", 
            "GroupCategory",  
            "ID"
        ),
        "WeekOrder1", First(EventOrderCalcVariables).IS_UNORDERED, 
        "WeekOrder2", First(EventOrderCalcVariables).IS_UNORDERED, 
        "WeekOrder3", First(EventOrderCalcVariables).IS_UNORDERED, 
        "WeekOrder4", First(EventOrderCalcVariables).IS_UNORDERED, 
        "WeekOrder5", First(EventOrderCalcVariables).IS_UNORDERED, 
        "WeekOrder6", First(EventOrderCalcVariables).IS_UNORDERED
    )
);

// Clear the daily items collection
Clear(DailyItems);
Clear(DailyItemsRenamed);

// Loop through each day
ForAll(MonthDayGalleryProcess.AllItems As GalleryItem,

    // Update the target week
    Patch(EventOrderCalcVariables, First(EventOrderCalcVariables), {
        targetWeekColumn: GalleryItem.lblTargetWeekOrderProcess.Text
    });

    // Add daily items to a collection
    Collect(DailyItems, 
        SortByColumns(
            AddColumns(
                Filter(
                    CalendarItemsPrint,
                    DateDiff(StartDate, EndDate, Hours) > 24 // CAUTION: THIS IS PRONE TO ISSUES WHEN 
			EVENTS SPAN MULTIPLE DAYS, BUT ARE LESS THAN 24 HOURS
                    && Or(
                        StartDate >= DateValue(GalleryItem.lblFullDateProcess.Text)
                        && EndDate <= DateAdd(DateAdd(DateValue(GalleryItem.lblFullDateProcess.Text),
			1, Days) -1, Minutes),
                        DateAdd(DateAdd(DateValue(GalleryItem.lblFullDateProcess.Text), 1, Days), -1,
			Minutes) >= StartDate 
                        && DateValue(GalleryItem.lblFullDateProcess.Text) <= EndDate
                    )
                    && Or(
                        Checkbox1_0.Value = true && Checkbox1_0.Text = GroupCategory,
                        Checkbox1_1.Value = true && Checkbox1_1.Text = GroupCategory,
                        Checkbox1_2.Value = true && Checkbox1_2.Text = GroupCategory,
                        Checkbox1_3.Value = true && Checkbox1_3.Text = GroupCategory,
                        Checkbox1_4.Value = true && Checkbox1_4.Text = GroupCategory,
                        Checkbox1_5.Value = true && Checkbox1_5.Text = GroupCategory,
                        Checkbox1_6.Value = true && Checkbox1_6.Text = GroupCategory,
                        Checkbox1_7.Value = true && Checkbox1_7.Text = GroupCategory,
                        Checkbox1_8.Value = true && Checkbox1_8.Text = GroupCategory,
                        Checkbox1_9.Value = true && Checkbox1_9.Text = GroupCategory,
                        Checkbox1_10.Value = true && Checkbox1_10.Text = GroupCategory,
                        Checkbox1_11.Value = true && Checkbox1_11.Text = GroupCategory,
                        Checkbox1_12.Value = true && Checkbox1_12.Text = GroupCategory,
                        Checkbox1_13.Value = true && Checkbox1_13.Text = GroupCategory
                    )
                ),
                "age", DateDiff(StartDate, DateValue(GalleryItem.lblFullDateProcess.Text)),
                "eventLength", DateDiff(StartDate, EndDate),
                "extendsThru", DateDiff(StartDate, EndDate) - DateDiff(StartDate,
				DateValue(GalleryItem.lblFullDateProcess.Text)) >= 1
            ), 
            GalleryItem.lblTargetWeekOrderProcess.Text, Ascending,
            "age", Descending,
            "eventLength", Descending,
            "extendsThru", Descending,
            "Title", Ascending
        )
    );

    // Rename the appropriate column to a singular name for easier coding
    Collect(
        DailyItemsRenamed,
        Switch(
            GalleryItem.lblTargetWeekOrderProcess.Text,
            "WeekOrder1",
            RenameColumns(
                DailyItems,
                "WeekOrder1",
                "ActiveWeekOrder"
            ),
            "WeekOrder2",
            RenameColumns(
                DailyItems,
                "WeekOrder2",
                "ActiveWeekOrder"
            ),
            "WeekOrder3",
            RenameColumns(
                DailyItems,
                "WeekOrder3",
                "ActiveWeekOrder"
            ),
            "WeekOrder4",
            RenameColumns(
                DailyItems,
                "WeekOrder4",
                "ActiveWeekOrder"
            ),
            "WeekOrder5",
            RenameColumns(
                DailyItems,
                "WeekOrder5",
                "ActiveWeekOrder"
            ),
            "WeekOrder6",
            RenameColumns(
                DailyItems,
                "WeekOrder6",
                "ActiveWeekOrder"
            )
        )
    );

    // Clear the daily items collection
    RemoveIf(DailyItems, true);

    // Loop through all local daily events that are not ordered, give them an order
    ForAll(
        Filter(DailyItemsRenamed, ActiveWeekOrder = First(EventOrderCalcVariables).IS_UNORDERED) As 
	ThisItem,

        // Reset found slot variable
        Patch(EventOrderCalcVariables, First(EventOrderCalcVariables), {foundSlot: -1});

        // Populate taken slots
        Collect(TakenSlots, 
            ShowColumns(
                Filter(DailyItemsRenamed, ActiveWeekOrder <> 9999),
                "ActiveWeekOrder"
            )
        );

        // Build a sequential list of values
        Collect(
            AvailableSlots, 
            RenameColumns(
                Sequence( CountRows(TakenSlots) + 1 ),
                "Value", 
                "Index"
            )
        );

        // Find an unused slot
        ForAll(
            AvailableSlots,

            // Check if we already found a slot (so we can skip this section)
            If (First(EventOrderCalcVariables).foundSlot = -1,

                // Check if this slot is not taken already
                If (CountRows(Filter(TakenSlots, ActiveWeekOrder = Index)) = 0, 

                    // Store the found slot
                    Patch(EventOrderCalcVariables, First(EventOrderCalcVariables), {foundSlot: Index});

                    // Update the active record with the new slot
                    Patch(DailyItemsRenamed, ThisItem, {ActiveWeekOrder: Index});

                    // Update the main records with the new slot
                    Switch(
                        GalleryItem.lblTargetWeekOrderProcess.Text,
                        "WeekOrder1",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder1: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        ),
                        "WeekOrder2",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder2: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        ),
                        "WeekOrder3",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder3: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        ),
                        "WeekOrder4",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder4: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        ),
                        "WeekOrder5",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder5: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        ),
                        "WeekOrder6",
                        Patch(
                            CalendarItemsPrint, 
                            LookUp(CalendarItemsPrint, ID = ThisItem.ID), 
                            {WeekOrder6: LookUp(DailyItemsRenamed, ID = ThisItem.ID, ActiveWeekOrder)}
                        )
                    );  
                )
            );
        );
        
        RemoveIf(TakenSlots, true);
        RemoveIf(AvailableSlots, true);
    );

    //todo: debug remove
    Patch(EventOrderCalcVariables, First(EventOrderCalcVariables), {DEBUG_VAL:
	Last(SortByColumns(DailyItemsRenamed, "ActiveWeekOrder")).ActiveWeekOrder});

    // Loop through numbers 1-n (n being the max slot value for today) to fill in any blank rows
    ForAll(
        Sequence(
            // Grabs the max slot value for today
            Last(SortByColumns(DailyItemsRenamed, "ActiveWeekOrder")).ActiveWeekOrder
        ) As thisSlot,
        // Check if a record does not exist
        If (CountRows(Filter(DailyItemsRenamed, ActiveWeekOrder = thisSlot.Value)) = 0,
            // Create a new record at the proper row
            Patch(
                CalendarItemsPrint, 
                Defaults(CalendarItemsPrint),
                Patch(
                    {GroupCategory: "_FILLER", StartDate: 
			DateValue(GalleryItem.lblFullDateProcess.Text), EndDate: 
			DateValue(GalleryItem.lblFullDateProcess.Text)+0.1},
                    Switch(
                        GalleryItem.lblTargetWeekOrderProcess.Text,
                        "WeekOrder1",
                        {WeekOrder1: thisSlot.Value},
                        "WeekOrder2",
                        {WeekOrder2: thisSlot.Value},
                        "WeekOrder3",
                        {WeekOrder3: thisSlot.Value},
                        "WeekOrder4",
                        {WeekOrder4: thisSlot.Value},
                        "WeekOrder5",
                        {WeekOrder5: thisSlot.Value},
                        "WeekOrder6",
                        {WeekOrder6: thisSlot.Value}
                    )
                );
            );
        );      
    );

    // Remove items from the daily collection
    RemoveIf(DailyItemsRenamed, true);
);

// This collection stores how many rows there are in each day for template height calculations later
Clear(DayRowCounts);
ForAll(
    WeekDayGallery_1.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_1.Text),
            Day: DateValue(lblFullDate_1.Text), 
            Rows: lblDayRows_1.Text }
    )
);
ForAll(
    WeekDayGallery_2.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_2.Text),
            Day: DateValue(lblFullDate_2.Text), 
            Rows: lblDayRows_2.Text }
    )
);
ForAll(
    WeekDayGallery_3.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_3.Text),
            Day: DateValue(lblFullDate_3.Text), 
            Rows: lblDayRows_3.Text }
    )
);
ForAll(
    WeekDayGallery_4.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_4.Text),
            Day: DateValue(lblFullDate_4.Text), 
            Rows: lblDayRows_4.Text }
    )
);
ForAll(
    WeekDayGallery_5.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_5.Text),
            Day: DateValue(lblFullDate_5.Text), 
            Rows: lblDayRows_5.Text }
    )
);
ForAll(
    WeekDayGallery_6.AllItems, Collect(
        DayRowCounts, 
        {   Week: Value(lblWeekNum_6.Text),
            Day: DateValue(lblFullDate_6.Text), 
            Rows: lblDayRows_6.Text }
    )
);

// With each day's rows collected, find the highest number for the week
ClearCollect(
    MaxRows,
    DropColumns(
        AddColumns(
            GroupBy(DayRowCounts,"Week","GroupedItems"),
        "Maximum",Max(GroupedItems, Rows)
        ),
    "GroupedItems"
    )
);

// Get the total maximum rows, then set the _heightVar to show a warning to users if there are more rows than space on the screen
Set(
    _maxRowsTotal, 
    Sum(MaxRows, Maximum)
);

// Each row is 18 pixels tall, there is a hard-coded 35 pixel space between each week (35px*6wks=210px), total space available is 837px
Set(_heightVar, 
    If(
        (_maxRowsTotal*18)+210 > 837, true, 
           False
    )
);
