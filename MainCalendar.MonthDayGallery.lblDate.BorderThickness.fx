If(
    // Date selected is today
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today() && DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = _dateSelected,
    2,
    // Today when it is not selected
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today(),
    2,
    1
)
