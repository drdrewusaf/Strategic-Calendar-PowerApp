// Variable to help the calendar know if the CalendarItemsPrint collection has been updated (false on first start)
Set(_printCalc, false);
// Reset the MoYrSelector dropdowns to reflect the startup month and year
Reset(ddMonth);
Reset(ddYear);
// Select the hidden button "btnUpdateCollections" to gather calendar items for this view
Select(btnUpdateCollections);
