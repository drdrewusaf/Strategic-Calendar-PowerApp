//  Invert the checkbox values in checkVals
UpdateIf(
    checkVals,
    Value = true,
    {Value: false},
    Value = false,
    {Value: true}
)
