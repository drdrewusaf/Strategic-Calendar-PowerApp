// This gallery contains the main event items and is filtered by the checkboxes when their text attribute matches the "GroupCategory" column
// Sorted by Title, StartDate, and event length
Sort(
    Sort(
        Sort(
            // Filter to items only happening in this day regardless of the lenght of the item/event
            Filter(
                CalendarItems,
                // We check if StartDate is >= to the full date AND the EndDate is <= the full date + 1 day - 1 minute (2359 same day)
                Or(
                    StartDate >= DateValue(lblFullDate.Text) && EndDate <= DateAdd(
                        DateAdd(
                            DateValue(lblFullDate.Text),
                            1,
                            Days
                        ) - 1,
                        Minutes
                    ),
                    // OR if the full date + 1 day - 1 minute >= StartDate AND the full date is <= EndDate
                    DateAdd(
                        DateAdd(
                            DateValue(lblFullDate.Text),
                            1,
                            Days
                        ),
                        -1,
                        Minutes
                    ) >= StartDate && DateValue(lblFullDate.Text) <= EndDate
                ) 
	// AND OR the value of a checkbox is true AND the text attribute matches the data in the 
	"GroupCategory" column
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
            Title
        ),
        StartDate
    ),
    DateDiff(
        StartDate,
        EndDate
    ),
    Descending
)
