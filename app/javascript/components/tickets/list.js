import React from 'react'
import { connect } from 'react-redux'

import { fetchTickets } from '../../actions/tickets'
import { select } from 'redux-crud-store/es'

class List extends React.Component {
  componentWillMount() {
    const { tickets, dispatch } = this.props
    if (tickets.needsFetch) {
      dispatch(tickets.fetch)
    }
  }

  componentWillReceiveProps(nextProps) {
    const { tickets } = nextProps
    const { dispatch } = this.props
    if (tickets.needsFetch) {
      dispatch(tickets.fetch)
    }
  }

  render() {
    const { tickets } = this.props
    if (tickets.isLoading) {
      return  <div id="tickets">
                <p>loading...</p>
              </div>
    } else {
      return  <div id="tickets">
                <ul>
                  { tickets.data.map(ticket => <li key={ticket.id}>{ticket.title}</li>) }
                </ul>
              </div>
    }
  }
}

function mapStateToProps(state, ownProps) {
  return { tickets: select(fetchTickets({ page: 1 }), state.models) }
}

export default connect(mapStateToProps)(List)
