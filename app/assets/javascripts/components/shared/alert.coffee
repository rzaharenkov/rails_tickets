namespace 'Shared', () ->
  @Alert = React.createClass
    propTypes:
      onClose: React.PropTypes.func,
      timeout: React.PropTypes.number,
      message: React.PropTypes.object.isRequired

    getDefaultProps: ->
      timeout: 5000

    alertClasses:
      error: 'alert-danger'
      alert: 'alert-warning'
      notice: 'alert-info'
      success: 'alert-success'

    componentDidMount: () ->
      @timer = setTimeout(
        @handleClose,
        @props.timeout
      )

    componentWillUnmount: () ->
      clearTimeout(@timer)

    handleClose: () ->
      @props.onClose(@message)

    alertClass: (type) ->
      @alertClasses[type] || @alertClasses.success

    render: () ->
      React.DOM.div
        className: "alert #{@alertClass(@props.message.type)} fade in"
        React.DOM.button
          className: 'close'
          onClick: @handleClose
          '\u00D7'
        @props.message.text
