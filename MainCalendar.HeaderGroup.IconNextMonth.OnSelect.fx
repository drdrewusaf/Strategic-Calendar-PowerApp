// Changes month view to next month
Set(
    _firstDayOfMonth,
    DateAdd(
        _firstDayOfMonth,
        1,
        Months
    )
);
Set(
    _firstDayInView,
    DateAdd(
        _firstDayOfMonth,
        -(Weekday(_firstDayOfMonth) - 2 + 1),
        Days
    )
);
Set(
    _lastDayInView,
    DateAdd(
        _firstDayInView,
        41,
        Days
    )
);
/*collects calendar events for all days in current month view. Updates _maxDate to prevent duplicate data collection if user returns to this month view*/
Set(
    _lastDayOfMonth,
    DateAdd(
        DateAdd(
            _firstDayOfMonth,
            1,
            Months
        ),
        -1,
        Days
    )
);
Set(
    _dateSelected,
    _firstDayOfMonth
);
// Update the collection for the month
Select(btnUpdateCollections);
