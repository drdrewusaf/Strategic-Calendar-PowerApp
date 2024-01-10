Filter(
    CalendarItems,
    Or(
        StartDate >= _dateSelected && EndDate <= DateAdd(
            DateAdd(
                _dateSelected,
                1,
                Days
            ),
            -1,
            Minutes
        ),
        DateAdd(
            DateAdd(
                _dateSelected,
                1,
                Days
            ),
            -1,
            Minutes
        ) >= StartDate && _dateSelected <= EndDate
    ) && GroupCategory = "Holiday"
)
