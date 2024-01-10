If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) <= 0,
    ThisItem.Title,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) < 1440,
    Text(
        ThisItem.StartDate,
        "hhmm"
    ) & " " & ThisItem.Title,
    Weekday(DateValue(lblFullDate_#.Text)) = 1 && DateValue(ThisItem.EndDate) <>
	DateValue(lblFullDate_#.Text),
    ThisItem.Title,
    Day(ThisItem.StartDate) <> Value(lblDate_#.Text),
    "",
    ThisItem.Title
)
