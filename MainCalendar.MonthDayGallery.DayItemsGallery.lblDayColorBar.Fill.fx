// Depending on the data in the "GroupCategory" column, change the color based on the colors table from App.OnStart - all colors faded by 50%
ColorFade(
    ColorValue(
        First(
            Filter(
                colors,
                ThisItem.GroupCategory exactin GroupCategory
            )
        ).Color
    ),
    .5
)
