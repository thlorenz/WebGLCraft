coffeeify = require 'coffeeify'
browserify = require 'browserify'
shim = require 'browserify-shim'
fs = require 'fs'
path = require 'path'

bfy = shim(browserify(), {
  jquery:              path : './public/jquery/jquery-1.7.1.js',   exports : '$'
  'jquery-hotkeys':    path : './public/lib/jquery.hotkeys.js',    exports : null,          depends: { jquery: '$' }
  'jquery-mousewheel': path : './public/lib/jquery.mousewheel.js', exports : null,          depends: { jquery: '$' }
  detector:            path : './public/lib/Detector.js',          exports : 'Detector'
  'improved-noise':    path : './public/lib/ImprovedNoise.js',     exports : 'ImprovedNoise'
  'three':             path : './public/lib/Three.js',             exports : 'THREE'
})

bfy.transform(coffeeify)

bfy
  .require(require.resolve('./public/main'), entry: true)
  .bundle({ debug: true })
  .pipe(fs.createWriteStream  path.join(__dirname, 'public', 'bundle.js'))