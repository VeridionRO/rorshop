$ ->
  $('#mod_search_searchword').autocomplete
    source: '/search_suggestions'
    delay: 500
    minLength: 2

  MainController = ->
  MainController:: =
    loader: null
    currentLink: null
    types: new Object
    values: new Array
    addLoader: ->
      unless @loader
        @loader = $("<div/>",
          id: "notice"
        ).text("Se incarca")
        loaderImage = $("<img />",
          src: "/assets/spinner-64.gif"
        )
        @loader.append loaderImage
      $("#product_list").html @loader
      return
    toggleDataValue: (link) ->
      type = link.attr("parent")
      value = jQuery.trim(link.text())
      values = controller.values
      controller.types[type] = new Array  unless controller.types[type]
      typeArray = controller.types[type]
      if link.hasClass("filter-value")
        if $.inArray(value, typeArray) is -1
          typeArray.push value
          values.push value
      else if link.hasClass("remove-filter-value")
        controller.types[type] = $.grep(typeArray, (item) ->
          item isnt value
        )
        controller.values = $.grep(values, (item) ->
          item isnt value
        )
      else
        return
      return
    toggleType: (trigger, imageCollapse) ->
      imageCollapse = $(trigger)  unless imageCollapse
      ul = $(trigger).closest(".filter-type").find("ul.level1")
      ul.toggle "slow"
      $(imageCollapse).toggleClass "display collapse"
      return
    toggleDisplayValue: (link) ->
      if link.hasClass("filter-value")
        selectedValue = $(".clone-filter-value").clone(true, true).removeClass("clone-filter-value")
        link.closest(".filter-type").find("h3").after selectedValue
        selectedValue.css "display", "block"
        selectedValue.append $(link).text()
        selectedValue.attr
          parent: $(link).attr("parent")
          val: $(link).attr("val")
        controller.toggleType link, controller.findToggleIcon(link)
        link.parent().remove()
      else if link.hasClass("remove-filter-value")
        restoreLi = $("li.hide").clone(true, true).removeClass("hide")
        restoreLink = restoreLi.find("a")
        typeId = $(link).attr("parent")
        restoreLink.attr
          parent: typeId
          val: $(link).attr("val")
        restoreLink.find("span").append link.text()
        ul = link.closest(".filter-type").find("ul")
        ul.append restoreLi
        controller.toggleType link, controller.findToggleIcon(link)  if controller.types[typeId].length is 0 and not ul.is(":visible")
        link.remove()
      else
        return
      return
    findToggleIcon: (elem) ->
      $(elem).closest(".filter-type").find ".toggle-type"
  controller = new MainController()
  $(document).ready ->
    selector = "a.remove-filter-value, a.filter-value"
    $(selector).click (event) ->
      link = $(event.currentTarget)
      controller.toggleDataValue link
      typeUrlIds = $.param(search: controller.values)
      $.ajax
        url: "/products/index.js"
        beforeSend: (xhr) ->
          controller.addLoader()
          return
        data: typeUrlIds
        success: ->
          # @todo check that this function is available
          history.pushState null, "page 2", "index?" + typeUrlIds
          controller.toggleDisplayValue link
          return
        dataType: "script"
      event.preventDefault()
      return
    $("div.filter-type a.toggle-type").click (event) ->
      controller.toggleType $(event.currentTarget)
      event.preventDefault()
      return
    $("#sort_item").change (event) ->
      $.ajax
        url: "/products/index.js"
        beforeSend: (xhr) ->
          controller.addLoader()
          return
        data: "order=" + $("#sort_item").val()
        success: ->
        dataType: "script"
      return
    return

  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
