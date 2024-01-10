If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) = 0,
    16,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Days
    ) <= 0,
    12,
    16
)
