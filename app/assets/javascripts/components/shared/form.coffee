namespace 'Shared', () ->
  class @Form extends React.Component
    recordName: 'record'
    defaultAttributes: {}
    defaultInputOptions: { type: 'text' }

    constructor: (props) ->
      super

      @state = {
        attributes: merge(@defaultAttributes, @props.record),
        errors: {}
      }

    collectionUrl: () ->
      @props.collectionUrl

    recordUrl: () ->
      "#{@collectionUrl()}/#{@props.record.id}"

    recordAttributes: () ->
      "#{@recordName}": @state.attributes

    handleCancel: (e) =>
      @props.handleCloseForm()

    handleChange: (e) =>
      name = e.target.name
      attributes = @state.attributes
      attributes[name] = e.target.value
      @setState(attributes: attributes)

    handleSubmit: (e) =>
      e.preventDefault()

      if @isNewRecord()
        @createRecord()
      else
        @updateRecord()

    isNewRecord: () ->
      !@props.record.id

    updateRecord: () ->
      $.ajax
        method: 'PATCH'
        url: @recordUrl()
        dataType: 'JSON'
        data: @recordAttributes()
        success: (data) =>
          @props.handleUpdateRecord(@props.record, data)
        error: (args...) => @handleErrors(args...)

    createRecord: () ->
      $.ajax
        method: 'POST'
        url: @collectionUrl()
        dataType: 'JSON'
        data: @recordAttributes()
        success: (data) =>
          @props.handleCreateRecord(data)
        error: (args...) => @handleErrors(args...)

    handleErrors: (jqXHR, textStatus, errorThrown) ->
      if jqXHR.status == 422
        @setState(errors: jqXHR.responseJSON)
      else
        alerts.addMessage(type: 'error', text: 'Something went wrong. Please retry later.')

    renderInput: (name, options = {}) ->
      inputOptions = merge(@defaultInputOptions,
                           { name: name, value: @state.attributes[name], onChange: @handleChange },
                           options)

      error = @state.errors[name]
      validationState = 'error' if error

      React.createElement ReactBootstrap.FormGroup,
        controlId: "#{@recordName}_#{name}"
        validationState: validationState
        React.createElement ReactBootstrap.Col,
          componentClass: ReactBootstrap.ControlLabel
          sm: 2
          name.humanize()
        React.createElement ReactBootstrap.Col,
          sm: 10
          React.createElement ReactBootstrap.FormControl, inputOptions

          if error
            React.createElement ReactBootstrap.HelpBlock, null, error

    renderButton: (text, buttonClass, options = {}) ->
      defaults = { type: 'button', className: "btn btn-#{buttonClass}" }
      React.DOM.button(merge(defaults, options), text)

    formInputs: () ->
      []

    renderForm: () ->
      formContent = @formInputs()
      formContent.concat [@renderButton('Submit', 'hidden', type: 'submit')]

    render: ->
      React.DOM.div null,
        React.createElement ReactBootstrap.Modal,
          show: @state.attributes?
          onHide: @handleClose
          React.createElement ReactBootstrap.ModalHeader,
            closeButton: true
            React.createElement ReactBootstrap.ModalTitle, null, "Edit #{@recordName.humanize()}:"
          React.createElement ReactBootstrap.ModalBody, null,
            React.createElement ReactBootstrap.Form,
              horizontal: true
              onSubmit: @handleSubmit
              @renderForm()...

          React.createElement ReactBootstrap.ModalFooter, null,
            @renderButton('Cancel', 'default', onClick: @handleCancel)
            @renderButton('Save', 'primary', onClick: @handleSubmit)
