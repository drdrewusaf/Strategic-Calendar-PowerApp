// If this is a less than 24 hour event, make the color bar 5px vs the normal 176px
If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) = 0,
    176,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Days
    ) <= 0,
    5,
    176
)
