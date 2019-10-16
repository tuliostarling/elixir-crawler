import React, { Component } from 'react';

import 'babel-polyfill';

import { SearchForm } from './form';
import ProcessContext from '../Context';

export default class NavbarSearch extends Component {
  static contextType = ProcessContext;

  render() {
    const { context } = this;

    return (
      <header>
        <nav>
          <div className="nav-wrapper">
            <SearchForm
              courts={context.state.courts}
              handleChange={context.handleChange}
              handleSubmit={context.handleSubmit}
              loading={context.state.loading}
            />
          </div>
        </nav>
      </header>
    );
  }
}
