# The global application object
application = null

# The Application
class @ApmApplication
  @initialized = false

  # eg: <div id="timeline-display">
  # usage: new TimelineApplication("timeline-display")
  constructor: (css_id) ->
    @css_id      = css_id
    application  = this.setup()
  setup: ->
    console.log "Initializing application"
    @initialized = true
    this


  # Public API
  


