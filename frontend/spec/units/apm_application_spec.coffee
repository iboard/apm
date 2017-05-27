describe "APM Application", ->

  app = null

  beforeEach ->
    app = new ApmApplication('apm-main')
    # spyOn  app, 'initializeCanvas'

  it "is initialized", ->
    expect( app.initialized ).toBe(true)

  it "has a main-section", ->
    expect( app.css_id ).toEqual("apm-main")

  

