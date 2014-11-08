# The bundle

bundleInit = () ->

  server = {
    url: 'ws://localhost:8085/'
  }

  content = $ '.content'
  log_data = $ '.log-data'
  indicator = $ '.indicator'
  ctrl_input = $ '.ctrl-input'
  ctrl_send = $ '.ctrl-send'

  websocket = false

  if content.data 'binded'
    return

  if typeof(WebSocket) == 'undefined'
    alert 'Your browser does\'t support WebSocket.'
    return

  content
    .removeClass 'loading'
    .addClass 'ready'
    .data 'binded', true

  delegate = () ->
    content.on.apply content, arguments
    return

  connect = () ->
    websocket = new WebSocket server.url
    websocket.onopen = onopen
    websocket.onclose = onclose
    websocket.onmessage = onmessage
    websocket.onerror = onerror
    return

  disconnect = () ->
    websocket.close()
    onclose()

  onopen = () ->
    log 'Connected to ' + server.url, 'info'
    content
      .removeClass 'ready'
      .addClass 'connected'
    ctrl_input.focus()
    send 'Hello, world!'
    return

  onclose = () ->
    log 'Disconnected', 'info'
    content
      .removeClass 'connected'
      .addClass 'ready'
    websocket = false
    return
    return

  onerror = (event) ->
    log 'Connection error. Have you run `node app.js` ?', 'error'
    return

  onmessage = (event) ->
    log event.data, 'received'

  send = (message) ->
    websocket.send message
    $ '<div class="sending"><div>'
      .appendTo indicator
      .delay 3000
      .queue () ->
        $(this).remove()
    log message, 'sent'

  log = (message, type) ->
    new_log = $ '<li><span class="text"></span></li>'
    new_log.children().text message
    if typeof(type) == 'string'
      new_log.addClass type
    log_data.prepend new_log


  delegate 'click.connect', '.ctrl-connect', () ->
    connect()
  delegate 'click.disconnect', '.ctrl-disconnect', () ->
    disconnect()
  delegate 'click.send', '.ctrl-send', () ->
    send(ctrl_input.val())
  delegate 'keyup.send', '.ctrl-input', (event) ->
    if event.keyCode == 13
      ctrl_send.trigger 'click.send'
      ctrl_input.select()




$(document).ready ()->
  bundleInit()