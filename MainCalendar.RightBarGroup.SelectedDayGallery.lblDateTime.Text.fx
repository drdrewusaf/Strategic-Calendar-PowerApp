If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) = 0,
    "All Day",
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Days
    ) <= 0,
    Text(
        ThisItem.StartDate,
        ShortDateTime24
    ),
    Text(
        ThisItem.StartDate,
        ShortDate
    ) & " - " & Text(
        ThisItem.EndDate,
        ShortDate
    )
)
