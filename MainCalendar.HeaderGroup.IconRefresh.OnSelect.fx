ClearCollect(
    CalendarItems,
    ShowColumns(
        // This should be the only other place to update your source
        Filter(
            '** ** Strategic Calendar',
            'Start Date' >= DateAdd(
                _firstDayInView,
                -1,
                Days
            ) || 'End Date' <= DateAdd(
                _lastDayInView,
                1,
                Days
            )
        ),
        "Title",
        "StartDate",
        "EndDate",
        "Location",
        "Description",
        "GroupCategory",
        "Length",
        "ID"
    )
);
