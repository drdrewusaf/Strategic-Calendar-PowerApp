// This gallery sits between lblDate and DayItemsGallery to display anything that has "Holiday" in the "GroupCategory" column
// It is not setup to be filterable with the checkboxes
Filter(
    CalendarItems,
    Or(
        StartDate >= DateValue(lblFullDate.Text) && EndDate <= DateAdd(
            DateAdd(
                DateValue(lblFullDate.Text),
                1,
                Days
            ) - 1,
            Minutes
        ),
        DateAdd(
            DateAdd(
                DateValue(lblFullDate.Text),
                1,
                Days
            ),
            -1,
            Minutes
        ) >= StartDate && DateValue(lblFullDate.Text) <= EndDate
    ) && GroupCategory = "Holiday"
)
