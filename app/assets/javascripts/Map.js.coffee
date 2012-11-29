class window.Map

  constructor: (@lat, @lng, @zoomLevel, @mapCanvas) ->
    mapOptions =
        zoom: zoomLevel
        center: new google.maps.LatLng(lat, lng)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        disableDefaultUI: true

    window.map = new google.maps.Map(mapCanvas[0], mapOptions)

  addMarker: (rsvp) ->

    marker = new google.maps.Marker({
      position: new google.maps.LatLng(rsvp.lat, rsvp.lng),
      title: "#{rsvp.user_name} responded #{rsvp.attending}!",
    })
    marker.setMap(window.map)
    marker

  addInfoWindow: (rsvp, marker) ->
    infowindow = new google.maps.InfoWindow()
    html = """
    <a href="#" class="span4">
              <span class="title">
                  <span>#{rsvp.attend_msg}</span>
              </span>
              <span class="image" style="background:url('#{rsvp.image_url}') no-repeat;"></span>
          </a>
    """
    infowindow.setContent(html)
    infowindow.open(window.map, marker)
    infowindow