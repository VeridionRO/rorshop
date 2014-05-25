jQuery ->
  jQuery('#mod_search_searchword').autocomplete
    source: '/search_suggestions'
    delay: 500

  MainController = ->
  MainController:: =
    loader: null
    currentLink: null
    types: new Object
    values: new Array
    addLoader: ->
      unless @loader
        @loader = jQuery("<div/>",
          id: "notice"
        ).text("Se incarca")
        loaderImage = jQuery("<img />",
          src: "/assets/spinner-64.gif"
        )
        @loader.append loaderImage
      jQuery("#product_list").html @loader
      return
    toggleDataValue: (link) ->
      type = link.attr("parent")
      value = link.attr("val")
      values = controller.values
      controller.types[type] = new Array  unless controller.types[type]
      typeArray = controller.types[type]
      if link.hasClass("filter-value")
        if jQuery.inArray(value, typeArray) is -1
          typeArray.push value
          values.push value
      else if link.hasClass("remove-filter-value")
        controller.types[type] = jQuery.grep(typeArray, (item) ->
          item isnt value
        )
        controller.values = jQuery.grep(values, (item) ->
          item isnt value
        )
      else
        return
      return
    toggleType: (trigger, imageCollapse) ->
      imageCollapse = jQuery(trigger)  unless imageCollapse
      ul = jQuery(trigger).closest(".filter-type").find("ul.level1")
      ul.toggle "slow"
      jQuery(imageCollapse).toggleClass "display collapse"
      return
    toggleDisplayValue: (link) ->
      if link.hasClass("filter-value")
        selectedValue = jQuery(".clone-filter-value").clone(true, true).removeClass("clone-filter-value")
        link.closest(".filter-type").find("h3").after selectedValue
        selectedValue.css "display", "block"
        selectedValue.append jQuery(link).text()
        selectedValue.attr
          parent: jQuery(link).attr("parent")
          val: jQuery(link).attr("val")
        controller.toggleType link, controller.findToggleIcon(link)
        link.parent().remove()
      else if link.hasClass("remove-filter-value")
        restoreLi = jQuery("li.hide").clone(true, true).removeClass("hide")
        restoreLink = restoreLi.find("a")
        typeId = jQuery(link).attr("parent")
        restoreLink.attr
          parent: typeId
          val: jQuery(link).attr("val")
        restoreLink.find("span").append link.text()
        ul = link.closest(".filter-type").find("ul")
        ul.append restoreLi
        controller.toggleType link, controller.findToggleIcon(link)  if controller.types[typeId].length is 0 and not ul.is(":visible")
        link.remove()
      else
        return
      return
    findToggleIcon: (elem) ->
      jQuery(elem).closest(".filter-type").find ".toggle-type"
  controller = new MainController()
  jQuery(document).ready ->
    selector = "a.remove-filter-value, a.filter-value"
    jQuery(selector).click (event) ->
      link = jQuery(event.currentTarget)
      controller.toggleDataValue link
      typeUrlIds = jQuery.param(where: controller.values)
      jQuery.ajax
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
    jQuery("div.filter-type a.toggle-type").click (event) ->
      controller.toggleType jQuery(event.currentTarget)
      event.preventDefault()
      return
    jQuery("#sort_item").change (event) ->
      jQuery.ajax
        url: "/products/index.js"
        beforeSend: (xhr) ->
          controller.addLoader()
          return
        data: "order=" + jQuery("#sort_item").val()
        success: ->
        dataType: "script"
      return
    return