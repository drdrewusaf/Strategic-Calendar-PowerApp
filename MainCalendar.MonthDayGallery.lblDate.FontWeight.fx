If(
    // Date selected is today
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today() && DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = _dateSelected,
    FontWeight.Bold,
    // Today when it is not selected
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today(),
    FontWeight.Bold,
    FontWeight.Semibold
)
