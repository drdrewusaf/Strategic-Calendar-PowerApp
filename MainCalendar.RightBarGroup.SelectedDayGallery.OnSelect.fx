// Set varItem to the the selected item, and navigate to the CalendarItemDetails screen
Set(
    varItem,
    ThisItem
);
Navigate(
    CalendarItemDetails,
    ScreenTransition.Cover
);
