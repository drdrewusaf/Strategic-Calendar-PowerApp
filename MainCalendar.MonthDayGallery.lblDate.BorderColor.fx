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
        51,
        102,
        1
    ),
	// Today when it is not selected
    DateAdd(
        _firstDayInView,
        ThisItem.Value
    ) = Today(),
    RGBA(
        0,
        51,
        102,
        1
    ),
    RGBA(
        202,
        202,
        202,
        1
    )
)
