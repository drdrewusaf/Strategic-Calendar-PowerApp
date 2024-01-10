If(
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = _dateSelected,
    RGBA(
        255,
        255,
        255,
        1
    ),
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today(),
    RGBA(
        47,
        41,
        43,
        1
    ),
    lblMonthSelected.Color
)
