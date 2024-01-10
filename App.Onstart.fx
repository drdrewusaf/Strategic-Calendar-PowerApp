// App.OnStart 
// Reset the calendar view and select today
Set(
    _dateSelected,
    Today()
);
Set(	
    _firstDayOfMonth,
    DateAdd(
        Today(),
        1 - Day(Today()),
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
// Make MainCalendar visible
Set(
    _calendarVisible,
    true
);
//Hide the month/year selector
Set(
    _moYrSelector,
    false
);

// Setup a collection of default checkbox values used to filter items shown on the calendar
// This "Name" column matches the checkbox.Text attributes and the data in the "GroupCategory" column in the SharePoint/CalendarItems lists
ClearCollect(
    checkVals,
    {
        CheckBox: "check0Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check1Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check2Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check3Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check4Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check5Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check6Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check7Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check8Val",
        Name: "** **",
        Value: true
    },
    {
        CheckBox: "check9Val",
        Name: "Inspections",
        Value: true
    },
    {
        CheckBox: "check10Val",
        Name: "**",
        Value: true
    },
    {
        CheckBox: "check11Val",
        Name: "Non-** **",
        Value: true
    },
    {
        CheckBox: "check12Val",
        Name: "Audits",
        Value: false
    },
    {
        CheckBox: "check13Val",
        Name: "** ** TDY",
        Value: true
    }
);
// Setup a collection of colors and images for checkboxes and items (categories), and background images shown on the calendar
ClearCollect(
    colors,
    {
        GroupCategory: "** **",
        Color: "Gold",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "DarkRed",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "Sienna",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "Olive",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "DodgerBlue",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "Orange",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "LightSteelBlue",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "Green",
        Image: '** **'
    },
    {
        GroupCategory: "** **",
        Color: "DeepPink",
        Image: '** **'
    },
    {
        GroupCategory: "Inspections",
        Color: "Khaki",
        Image: '** **'
    },
    {
        GroupCategory: "**",
        Color: "MediumOrchid",
        Image: '**'
    },
    {
        GroupCategory: "Non-** **",
        Color: "LightSlateGray",
        Image: '** **'
    },
    {
        GroupCategory: "** ** TDY",
        Color: "OrangeRed",
        Image: '** **'
    },
    {
        GroupCategory: "Audits",
        Color: "Black",
        Image: '** **'
    },
    {
        GroupCategory: "Holiday",
        Color: "BurlyWood",
        Image: '** **'
    }
);
// Setup collection of months for the month year selector month dropdown
ForAll(
    Sequence(12),
    Collect(
        colMonths,
        {
            Mont**o: Text(Value),
            Mont**ame: Last(
                FirstN(
                    Calendar.MonthsLong(),
                    Value
                )
            ).Value
        }
    )
);
// Setup collection of years for the month year selector year dropdown
Set(
    _currYear,
    Year(Today())-10
);
ForAll(
    Sequence(20, _currYear) As years,
    Collect(
        colYears,
        {
            Year:  years.Value
        }
    )
);
