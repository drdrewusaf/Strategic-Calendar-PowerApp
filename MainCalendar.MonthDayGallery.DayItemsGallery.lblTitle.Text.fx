// For items that are of zero length, assume they are All-Day events and only display the title
// For items that are less than 24 hours in length, display the start time and title
// Otherwise, display only the title (multi-day events)
If(
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Minutes
    ) = 0,
    ThisItem.Title,
    DateDiff(
        ThisItem.StartDate,
        ThisItem.EndDate,
        Days
    ) <= 0,
    Text(
        ThisItem.StartDate,
        "hhmm"
    ) & " " & ThisItem.Title,
    ThisItem.Title
)
