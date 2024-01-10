If(
    Weekday(DateValue(lblFullDate_1.Text)) = 1,
    222 - Self.Width,
    DateValue(lblFullDate_1.Text) = DateValue(ThisItem.StartDate),
    228.57 - Self.Width,
    0
)
