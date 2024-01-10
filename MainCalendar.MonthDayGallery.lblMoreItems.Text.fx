// There is only space for 5 18px rows.  So, if there are more than 5 in this day, this label will appear with how many rows are not visible.
If(
    Value(lblDayRows.Text) > 5,
    "▼  " & CountRows(DayItemsGallery.AllItems) - 5 & " more  ▼",
    ""
)
