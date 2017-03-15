namespace 'Users', () ->
  @Form = React.createClass
    getInitialState: ->
      attributes: merge({ password: '' }, @props.user)
      errors: {}

    handleCancel: ->
      @props.handleCloseForm()

    handleChange: (e) ->
      name = e.target.name
      attributes = @state.attributes
      attributes[name] = e.target.value
      @setState(attributes: attributes)

    handleSubmit: (e) ->
      e.preventDefault()

      if @isNewRecord()
        @createRecord()
      else
        @updateRecord()

    isNewRecord: () ->
      !@props.user.id

    updateRecord: () ->
      $.ajax
        method: 'PATCH'
        url: "/admin/users/#{ @props.user.id }"
        dataType: 'JSON'
        data: { user: @state.attributes }
        success: (data) =>
          @props.handleUpdateRecord(@props.user, data)
        error: (args...) => @handleErrors(args...)

    createRecord: () ->
      $.ajax
        method: 'POST'
        url: "/admin/users"
        dataType: 'JSON'
        data: { user: @state.attributes }
        success: (data) =>
          @props.handleCreateRecord(data)
        error: (args...) => @handleErrors(args...)

    handleErrors: (jqXHR, textStatus, errorThrown) ->
      if jqXHR.status == 422
        @setState(errors: jqXHR.responseJSON)
      else
        # TODO: handle 500

    renderControlGroup: (name, inputType) ->
      error = @state.errors[name]
      validationState = 'error' if error

      React.createElement ReactBootstrap.FormGroup,
        controlId: "user_#{name}"
        validationState: validationState
        React.createElement ReactBootstrap.Col,
          componentClass: ReactBootstrap.ControlLabel
          sm: 2
          name.humanize()
        React.createElement ReactBootstrap.Col,
          sm: 10
          React.createElement ReactBootstrap.FormControl,
            type: inputType
            name: name
            value: @state.attributes[name]
            onChange: @handleChange
            autoComplete: 'off'

          if error
            React.createElement ReactBootstrap.HelpBlock, null, error

    renderButton: (text, buttonClass, options = {}) ->
      defaults = { type: 'button', className: "btn btn-#{buttonClass}" }
      React.DOM.button(merge(defaults, options), text)

    render: ->
      React.DOM.div null,
        React.createElement ReactBootstrap.Modal,
          show: @state.attributes?
          onHide: @handleClose
          React.createElement ReactBootstrap.ModalHeader,
            closeButton: true
            React.createElement ReactBootstrap.ModalTitle, null, 'Edit User:'
          React.createElement ReactBootstrap.ModalBody, null,
            React.createElement ReactBootstrap.Form,
              horizontal: true
              onSubmit: @handleSubmit

              @renderControlGroup('email', 'text')
              @renderControlGroup('password', 'password')
              @renderButton('Submit', 'hidden', type: 'submit')

          React.createElement ReactBootstrap.ModalFooter, null,
            @renderButton('Cancel', 'default', onClick: @handleCancel)
            @renderButton('Save', 'primary', onClick: @handleSubmit)
