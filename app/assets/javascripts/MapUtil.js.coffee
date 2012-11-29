#= require MathUtil

class window.MapUtil
  @MEAN_RADIUS_EARTH_IN_KM = 6371
  @ZOOM_FACTOR = 1.6446

  # Haversine formula to calculate the great-circle distance between two points, i.e. the shortest distance over the earths surface
  @haversine: (maxLat, minLat, maxLng, minLng) ->
    dLat = maxLat - minLat
    dLng = maxLng - minLng
    a = MathUtil.square(Math.sin(dLat/2)) + Math.cos(minLat) * Math.cos(maxLat) * MathUtil.square(Math.sin(dLng/2))
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    @MEAN_RADIUS_EARTH_IN_KM * c

  @zoom: (mapCanvas, maxLat, minLat, maxLng, minLng) ->
    zoom = if minLat is maxLat and minLng is maxLng then 11 else MapUtil.optimalZoomLevel(mapCanvas, maxLat, minLat, maxLng, minLng)

  @optimalZoomLevel: (mapCanvas, maxLat, minLat, maxLng, minLng) ->
    # min of height and width of element which contains the map
    minMapDimension = Math.min.apply @, [mapCanvas.width(),mapCanvas.height()]

    [maxLat, minLat, maxLng, minLng] = [maxLat, minLat, maxLng, minLng].map (l) -> MathUtil.toRadians(l)
    greatCircleDistance = MapUtil.haversine(maxLat, minLat, maxLng, minLng)
    Math.floor(8 - Math.log(@ZOOM_FACTOR * greatCircleDistance / Math.sqrt(2 * MathUtil.square(minMapDimension))) / Math.log (2))