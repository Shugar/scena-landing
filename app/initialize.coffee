$(document).ready ->

  window.sr = ScrollReveal()
    .reveal( '.firstSection', { delay: 100, distance: '150px', scale: 0.9 } )
    .reveal( '.secondSection', { delay: 400, distance: '150px', scale: 0.9 } )
    .reveal( '.thirdSection', { delay: 400, distance: '150px', scale: 0.9 } )
    .reveal( '.fourthSection', { delay: 400, distance: '150px', scale: 0.9 } )
    .reveal( '.formSection', { delay: 400, distance: '150px', scale: 0.9 } )
    .reveal( '.mapSection', { delay: 400, distance: '150px', scale: 0.9 } )
    .reveal( '.footer', { delay: 400, distance: '150px', scale: 0.9 } )


  init_map = ->

    if $('#map-canvas').length > 0

      myLatlng = new (google.maps.LatLng)(56.05071,37.5325353)

      styles = [ { stylers: [ { saturation: '-100' } ] } ]

      mapOptions =
        zoom: 15
        center: myLatlng
        disableDefaultUI: true
        scrollwheel: false
        styles: styles
      map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)

      myIcon = '../images/svg/marker.svg'

      marker = new (google.maps.Marker)(
        position: myLatlng
        icon: myIcon
        map: map)

      newLocation = (newLat, newLng) ->
        map.setCenter
          lat: newLat
          lng: newLng
          myLatlng = new (google.maps.LatLng)(newLat, newLng)


  google.maps.event.addDomListener window, 'load', init_map
  google.maps.event.addDomListener document, 'ready', init_map

  $('.modal-close').click ->
    $('.modal').fadeOut();
    $('body').removeClass('body-fixed');

  $('.firstSection-button').click ->
    $('.modal').fadeIn();
    $('body').addClass('body-fixed');

  $('.formSection-button').click ->
    $('.modal').fadeIn();
    $('body').addClass('body-fixed');

  Parse.initialize('WD4SCqCV1MsggPivlA2FvNuwHym2lIWxNhpAmQxu', 'bgN3ACqo9x6mmfPdtaKUoSvBVw5PFSeMucjiNx8H');

  $('.modal .modal-button').click (e) ->
    e.preventDefault()

    a = $('.modal #name').val()
    c = $('.modal #phone').val()

    if $('.modal #name').val().length > 0 & $('.modal #phone').val().length > 0

      Parse.Cloud.run 'sendmail', {
        target: 'shugar348@gmail.com'
        originator: 'shugar348@gmail.com'
        subject: 'Заявка на запись'
        text: "Имя: #{a}\n\nТелефон: #{c}"
      },

      success: (success) ->
        sweetAlert("Спасибо!"," Скоро ответим.","success")
        $('.modal').fadeOut();
        $('body').removeClass('body-fixed')

      error: (error) ->
        sweetAlert("Что-то пошло не так. Попробуйте снова.","","error")

    else
      sweetAlert("Вы не заполнили обязательные поля","","error")