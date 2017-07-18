import React from 'react';
import { Provider } from 'react-redux';

import store from '../store';

import TicketsList from './tickets/list';

const App = () => (
  <div>
    <TicketsList />
  </div>
);

export default (
  <Provider store={store}>
    <App />
  </Provider>
);
