exports.compareByProperty = (propertyName) ->
  (a, b) ->
    aval = a[propertyName]
    bval = b[propertyName]
    if aval < bval
      -1
    else if aval > bval
      1
    else 0