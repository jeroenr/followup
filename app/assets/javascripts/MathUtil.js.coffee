class window.MathUtil
  @DEG_TO_RAD_DIVISOR = 57.2957795

  @square: (x) -> x * x

  @toRadians: (degrees) ->
    degrees / @DEG_TO_RAD_DIVISOR