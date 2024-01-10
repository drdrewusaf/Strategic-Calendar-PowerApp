// If this is a less than 24 hour event, make the color bar appear 3px lower vs 0px
If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) = 0,
    0,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Days
    ) <= 0,
    3,
    0
)
