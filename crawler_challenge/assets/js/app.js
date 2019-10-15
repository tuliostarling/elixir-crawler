// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import M from 'materialize-css';
import css from '../css/app.scss';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html';
import 'react-phoenix';

import 'materialize-loader';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import ProcessProvider from './screens/Provider';

M.AutoInit();

document.addEventListener('DOMContentLoaded', () => {
  const formSelect = document.querySelectorAll('.select_court_input');

  M.FormSelect.init(formSelect, {});
});

window.Components = {
  ProcessProvider,
};
