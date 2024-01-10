If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) <= 0,
    0,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) < 1440,
    0,
    DateValue(lblFullDate_1.Text) = DateValue(ThisItem.EndDate),
    10,
    0
)
