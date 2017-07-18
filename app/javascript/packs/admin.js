import 'bootstrap-sass/assets/javascripts/bootstrap';
import Rails from 'rails-ujs';
import ReactDOM from 'react-dom';
import App from '../components/app.js';

import '../styles/admin.scss';

document.addEventListener("DOMContentLoaded", function() {
  Rails.start();

  const rootElement = document.getElementById('root');
  if (rootElement) {
    ReactDOM.render(App, rootElement);
  }
});
