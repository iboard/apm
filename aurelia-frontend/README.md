# APM - The Agile Project Manager
(c) by Andreas Altendorfer <andreas@altendorfer.at>, see `LICENSE.md`

This is an alternative client for the APM to due testing the core API
from the point of view of a developer of an independent client.

The main development happens in path `../elixir`.

## Environment

  * [Jasmine]
  * [Coffeescript]


APM comes with a _Cakefile_ to watch your source- and spec-files in
`src/coffee` and `spec/units`. Once you fetched the repository from
Github, cd into the project's root and start

    cake assets:watch

Then

  * open `spec/suite.html` in your brower to run the tests.
  * open `public/index.html` in your brower to run the application.

If the command `cake` is not found on your machine. Install it by
using

  `npm install cake -g`

# THE AGILE PROJECT MANAGER

## index.html

Demonstrate current state of APM

## Class ApmApplication

See file `src/app/apm_application.coffee`. The class is supposed to run 
the APM"Main" thread.

    app = new ApmApplication( "main-canvas") 
    // css-id of your main div-tag where the application will live.


[Jasmine]:       http://jasmine.github.io/
[Coffeescript]:  http://coffeescript.org/
