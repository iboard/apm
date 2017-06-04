#
# Generate a random color. Optionally with a random opacity
#
@randomColor= (transparent=false) ->
  rgb = []
  rgb.push Math.round( Math.random()*255 ) for col in ['r','g','b']
  if transparent
    "rgba(#{rgb[0]},#{rgb[1]},#{rgb[2]},#{Math.random()})"
  else
    "rgb(#{rgb[0]},#{rgb[1]},#{rgb[2]})"

