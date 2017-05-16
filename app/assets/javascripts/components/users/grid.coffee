namespace 'Users', () ->
  @Grid = React.createClass
    getInitialState: ->
      users: []
      user: null

    componentDidMount: ->
      @serverRequest = $.get(@props.collection_url).then (data) => @setState(users: data)

    componentWillUnmount: ->
      @serverRequest.abort()

    editRecord: (user) ->
      @setState(user: user)

    newRecord: () ->
      @setState(user: { email: '', password: '' })

    createRecord: (user) ->
      users = React.addons.update(@state.users, { $push: [user] })
      @replaceState(users: users)
      alerts.addMessage(type: 'success', text: 'Item has been created successfully.', id: "created_#{user.id}")

    deleteRecord: (user) ->
      index = @state.users.indexOf user
      users = React.addons.update(@state.users, { $splice: [[index, 1]] })
      @replaceState(users: users)
      alerts.addMessage(type: 'success', text: 'Item has been deleted successfully.', id: "deleted_#{user.id}")

    updateRecord: (user, data) ->
      index = @state.users.indexOf user
      users = React.addons.update(@state.users, { $splice: [[index, 1, data]] })
      @replaceState(users: users)
      alerts.addMessage(type: 'success', text: 'Item has been updated successfully.', id: "updated_#{user.id}")

    closeForm: () ->
      @setState(user: null)

    render: ->
      React.DOM.div
        className: 'users'
        React.DOM.h2
          className: 'title'
          'Users'
        React.DOM.div
          className: 'well well-sm btn-toolbar'
          React.DOM.div
            className: 'btn-group'
            React.DOM.button
              type: 'button'
              className: 'btn btn-primary'
              onClick: @newRecord,
              'New'
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'ID'
              React.DOM.th null, 'Email'
              React.DOM.th null, 'Created at'
              React.DOM.th null, 'Updated at'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for user in @state.users
              React.createElement(Users.GridRow, key: user.id, user: user, handleDeleteRecord: @deleteRecord, handleEditRecord: @editRecord)

        if @state.user
          React.createElement(Users.Form,
                              record: @state.user,
                              collectionUrl: @props.collection_url,
                              handleCreateRecord: @createRecord,
                              handleUpdateRecord: @updateRecord,
                              handleCloseForm: @closeForm)

