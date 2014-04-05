// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function MainController() {
}

MainController.prototype = {

  loader: null,
  types: new Object,
  values: new Array,

  addLoader: function() {
    if (!this.loader) {
      this.loader = jQuery('<div/>',{
        id: 'notice'
      }).text('Se incarca')
      var loaderImage = jQuery('<img />',{
        src: '/assets/spinner-64.gif'
      })
      this.loader.append(loaderImage);
    };
    jQuery("#product_list").html(this.loader);
  },

  addTypeValue: function(event) {
    var link = event.currentTarget;
    var type = jQuery(link).attr('parent');
    var value = jQuery(link).attr('val');
    var values = controller.values
    if (!controller.types[type]) {
      controller.types[type] = new Array;
    };
    var typeArray = controller.types[type];
    if (jQuery.inArray(value, typeArray) == -1) {
      typeArray.push(value);
      values.push(value);
    };
  }

};

var controller = new MainController();

jQuery(document).ready(function() {
  jQuery("div.filter-type a.level1").click(function (e) {
    controller.addTypeValue(e);
    var typeUrlIds = jQuery.param({'where': controller.values});
    jQuery.ajax({
      url: '/products/index' + '.js',
      beforeSend: function(xhr) {
        controller.addLoader();
      },
      data: typeUrlIds,
      success: function() {
        var stateObj = { foo: "bar" };
        history.pushState(stateObj, "page 2", 'index?' + typeUrlIds);
      },
      dataType: 'script'
    });
    e.preventDefault();
  });
});