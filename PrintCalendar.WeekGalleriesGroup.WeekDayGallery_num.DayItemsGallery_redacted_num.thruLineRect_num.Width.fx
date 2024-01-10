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
    Or(
        DateValue(lblFullDate_1.Text) = DateValue(ThisItem.StartDate),
        Weekday(DateValue(lblFullDate_1.Text)) = 1
    ),
    228.57 - (Len(lblTitle_3.Text)*8),
    DateValue(lblFullDate_1.Text) = DateValue(ThisItem.EndDate),
    222,
    Day(ThisItem.StartDate) <> Value(lblDate_1.Text),
    228.57,
    228.57
)
