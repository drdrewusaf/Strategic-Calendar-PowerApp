// Fill value changes if the gallery item day = today, or if it lies outside of the current month             
If(
    // Date selected is today
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today() && DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = _dateSelected,
    RGBA(
        0,
        0,
        0,
        0
    ),
    // Today when it is not selected
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today(),
    RGBA(
        0,
        0,
        0,
        0
    ),
    // The day is outside the range of the currently selected month
    Abs(Self.Text - ThisItem.Value) > 10,
    RGBA(
        120,
        120,
        120,
        0.2
    ),
    RGBA(
        0,
        0,
        0,
        0
    )
)
