@element_has_class= (element, klass) ->
  class_string = $("##{element}").attr("class")
  classes = class_string.split(" ")
  for k in classes
    return true if k == klass
  false

@random_css_suffix= (prefix) ->
  r = Math.random() * 10000;
  "#{prefix}#{Math.round(r)}"
