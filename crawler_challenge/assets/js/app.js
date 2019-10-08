// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import "react-phoenix";

import "materialize-loader";
import M from "materialize-css";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import NavbarSearch from "./screens/navbar_search";
import ProcessScreen from "./screens/process";

M.AutoInit();

document.addEventListener("DOMContentLoaded", function() {
  const formSelect = document.querySelectorAll(".select_court_input");

  M.FormSelect.init(formSelect, {});
});

window.Components = {
  NavbarSearch,
  ProcessScreen
};