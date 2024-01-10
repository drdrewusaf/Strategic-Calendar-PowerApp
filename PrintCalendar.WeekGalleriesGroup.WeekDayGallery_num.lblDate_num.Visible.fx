// This item is in a row containing no days of the visible month. It is in the row after the row where the last day of the month occurs
!(DateAdd(
    _firstDayInView,
    ThisItem.Value,
    Days
) - Weekday(
    DateAdd(
        _firstDayInView,
        ThisItem.Value,
        Days
    )
) - 7 > _lastDayOfMonth)

.WeekGalleriesGroup.WeekDayGallery_#.lblFullDate_#.Text
DateAdd(
    _firstDayInView,
    ThisItem.Value,
    Days
)
