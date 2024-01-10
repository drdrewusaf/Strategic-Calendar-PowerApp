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
