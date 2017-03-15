namespace 'Users', () ->
  @GridRow = React.createClass
    handleEdit: (e) ->
      e.preventDefault()
      @props.handleEditRecord @props.user

    handleDelete: (e) ->
      e.preventDefault()
      # yeah... jQuery doesn't have a $.delete shortcut method
      $.ajax
        method: 'DELETE'
        url: "/admin/users/#{ @props.user.id }"
        dataType: 'JSON'
        success: (data) =>
          @props.handleDeleteRecord @props.user

    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.user.id
        React.DOM.td null, @props.user.email
        React.DOM.td null, formatDate(@props.user.created_at)
        React.DOM.td null, formatDate(@props.user.updated_at)
        React.DOM.td
          className: 'actions'
          React.DOM.a
            className: 'btn btn-default'
            onClick: @handleEdit
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            onClick: @handleDelete
            'Delete'
