$ ->
  $('#add-values').click (event) ->
    $.ajax
      url: '/admin/type_values_controller/create'
      type: 'POST'
      beforeSend: (xhr) ->
        return
      data: {
        type_value: {
          type_id: $('#type_id').val(),
          value: $('#type_value_type_value').val()
        }
      }
      success: ->
        return
      dataType: 'script'
    event.preventDefault()
    return