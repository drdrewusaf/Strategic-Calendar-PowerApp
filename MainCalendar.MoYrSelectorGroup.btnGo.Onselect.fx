// Get the values for each dropdown and concatenate them into a datevalue for setting the view
Set(
    _firstDayOfMonth,
    DateValue(Concatenate(ddMonth.SelectedText.Value, " ", ddYear.SelectedText.Value))
);
// Set the calendar view to the selected mo/yr
Set(
    _firstDayInView,
    DateAdd(
        _firstDayOfMonth,
        -(Weekday(_firstDayOfMonth) - 2 + 1),
        Days
    )
);
Set(
    _lastDayInView,
    DateAdd(
        _firstDayInView,
        41,
        Days
    )
);
Set(
    _lastDayOfMonth,
    DateAdd(
        DateAdd(
            _firstDayOfMonth,
            1,
            Months
        ),
        -1,
        Days
    )
);
Set(
    _dateSelected,
    _firstDayOfMonth
);
// Hide the MoYrSelectorGroup controls
Set(
    _moYrSelector,
    false
);
// Update the collection for the newly selected mo/yr
Select(btnUpdateCollections); 
