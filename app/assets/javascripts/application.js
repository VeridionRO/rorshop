// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//=require jquery-fileupload/basic
//= require_tree .

function MainController() {
}

MainController.prototype = {

  loader: null,
  currentLink: null,
  types: new Object,
  values: new Array,

  addLoader: function() {
    if (!this.loader) {
      this.loader = jQuery('<div/>', {
        id: 'notice'
      }).text('Se incarca');
      var loaderImage = jQuery('<img />', {
        src: '/assets/spinner-64.gif'
      });
      this.loader.append(loaderImage);
    }
    jQuery('#product_list').html(this.loader);
  },

  toggleDataValue: function(link) {
    var type = link.attr('parent');
    var value = link.attr('val');
    var values = controller.values;
    if (!controller.types[type]) {
      controller.types[type] = new Array;
    }
    var typeArray = controller.types[type];
    if (link.hasClass('filter-value')) {
      if (jQuery.inArray(value, typeArray) == -1) {
        typeArray.push(value);
        values.push(value);
      }
    } else if (link.hasClass('remove-filter-value')) {
      controller.types[type] = jQuery.grep(typeArray, function(item) {
        return item != value;
      });
      controller.values = jQuery.grep(values, function(item) {
        return item != value;
      });
    } else return;
  },

  toggleType: function(trigger, imageCollapse) {
    if (!imageCollapse) imageCollapse = jQuery(trigger);
    var ul = jQuery(trigger).closest('.filter-type').find('ul.level1');
    ul.toggle('slow');
    jQuery(imageCollapse).toggleClass('display collapse');
  },

  toggleDisplayValue: function(link) {
    if (link.hasClass('filter-value')) {
      var selectedValue = jQuery('.clone-filter-value').
        clone(true, true).
        removeClass('clone-filter-value');
      link.closest('.filter-type').find('h3').after(selectedValue);
      selectedValue.css('display', 'block');
      selectedValue.append(jQuery(link).text());
      selectedValue.attr({
        parent: jQuery(link).attr('parent'),
        val: jQuery(link).attr('val')
      });
      controller.toggleType(link, controller.findToggleIcon(link));
      link.parent().remove();
    }else if (link.hasClass('remove-filter-value')) {
      var restoreLi = jQuery('li.hide').
        clone(true, true).
        removeClass('hide');
      var restoreLink = restoreLi.find('a');
      var typeId = jQuery(link).attr('parent');
      restoreLink.attr({
        parent: typeId,
        val: jQuery(link).attr('val')
      });
      restoreLink.find('span').append(link.text());
      var ul = link.closest('.filter-type').find('ul');
      ul.append(restoreLi);
      if (controller.types[typeId].length === 0 && !ul.is(':visible')) {
        controller.toggleType(link, controller.findToggleIcon(link));
      }
      link.remove();
    }else return;
  },

  findToggleIcon: function(elem) {
    return jQuery(elem).closest('.filter-type').find('.toggle-type');
  }

};

var controller = new MainController();

jQuery(document).ready(function() {
  var selector = 'a.remove-filter-value, a.filter-value';
  jQuery(selector).click(function(event) {
    var link = jQuery(event.currentTarget);
    controller.toggleDataValue(link);
    var typeUrlIds = jQuery.param({'where': controller.values});
    jQuery.ajax({
      url: '/products/index.js',
      beforeSend: function(xhr) {
        controller.addLoader();
      },
      data: typeUrlIds,
      success: function() {
        // @todo check that this function is available
        history.pushState(null, 'page 2', 'index?' + typeUrlIds);
        controller.toggleDisplayValue(link);
      },
      dataType: 'script'
    });
    event.preventDefault();
  });

  jQuery('div.filter-type a.toggle-type').click(function(event) {
    controller.toggleType(jQuery(event.currentTarget));
    event.preventDefault();
  });

  jQuery('#sort_item').change(function(event) {
    jQuery.ajax({
      url: '/products/index.js',
      beforeSend: function(xhr) {
        controller.addLoader();
      },
      data: 'order=' + jQuery('#sort_item').val(),
      success: function() {},
      dataType: 'script'
    });
  });
});
