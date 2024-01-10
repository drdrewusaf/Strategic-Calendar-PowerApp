// We are using a local collection here because delegation to SharePoint (SP) may be above the 2000 item limit, and it's much faster to run filter calculations locally rather than via delegation on SP
ClearCollect(CalendarItems,
    ShowColumns(
        
        //This is the title of the SP source list
        Filter('** ** Strategic Calendar',
            
            // We collect items that end or start in the current view (plus or minus one day) 
            'Start Date' >= DateAdd(_firstDayInView,-1,Days) 
            || 'End Date' <= DateAdd(_lastDayInView, 1, Days)), 
            
            // These are the columns we are chosing to collect from the SP source. The column names collected/used/set here are used throughout the app.
            "Title", 
            "StartDate", 
            "EndDate", 
            "Location", 
            "Description", 
            "GroupCategory",  
            "ID"
        )
);

// Pre-run the PrintCalendar collection calculations by selecting the hidden "btnUpdatePrintCollections" button, then let the calendar know it's been run
If(
    _printCalc = false, 
    Select(btnUpdatePrintCollections)
);
Set(_printCalc, true);
