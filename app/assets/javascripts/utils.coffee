@namespace = (name, definition) ->
  @[name] ||= {}
  definition.apply(@[name])

@formatDate = (date) ->
  new Date(date).toString()

@tap = (o, fn) -> fn(o); o

@merge = (xs...) ->
  if xs?.length > 0
    tap {}, (m) -> m[k] = v for k, v of x for x in xs
