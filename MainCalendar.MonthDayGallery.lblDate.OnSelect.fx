// When the user clicks on a day, it sets the _dateSelected variable to the clicked day
// It must remain as the front-most object in MonthDayGallery so users can click the entire square for the day
Set(
    _dateSelected,
    DateAdd(
        _firstDayInView,
        ThisItem.Value,
        Days
    )
) 
