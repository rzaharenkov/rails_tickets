namespace 'Shared', () ->
  @AlertsList = React.createClass
    propTypes:
      messages: React.PropTypes.array.isRequired
      onMessageRemoved: React.PropTypes.func

    getInitialState: ->
      messages: @props.messages

    componentDidMount: ->
      window.alerts = @;

    addMessage: (message) ->
      messages = React.addons.update(@state.messages, { $push: [message] })
      @replaceState(messages: messages)

    removeMessage: (message) ->
      index = @state.messages.indexOf(message)
      messages = React.addons.update(@state.messages, { $splice: [[index, 1]] })
      @replaceState(messages: messages)

    messageId: (message) ->
      message.id || "#{new Date().getTime()}-#{Math.floor((1 + Math.random()) * 0x10000)}"

    render: () ->
      alerts = @state.messages.map (message) =>
        React.createElement(Shared.Alert,
                            key: @messageId(message),
                            message: message,
                            onClose: () => @removeMessage(message))

      React.DOM.div
        className: 'alerts-list'
        React.createElement(React.addons.CSSTransitionGroup,
                            transitionName: 'alerts',
                            transitionEnter: false,
                            transitionLeaveTimeout: 500,
                            alerts)
