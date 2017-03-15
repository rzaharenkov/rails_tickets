#= require ./shared
#= require ./users

@AdminDashboard = React.createClass
  render: () ->
    React.createElement(Users.Grid, collection_url: @props.users_url)
