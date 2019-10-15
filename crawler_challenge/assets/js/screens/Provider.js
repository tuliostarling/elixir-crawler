import React, { Component } from 'react';
import ProcessContext from './Context';

import NavbarSearch from '../screens/navbar_search'
import ProcessScreen from '../screens/process'

import Api from '../api';

export default class ProcessProvider extends Component {
  state = {
    ...this.props,
    process: null,
    loading: false,
    error_message: null,

    search_attrs: {
      court: '',
      process_n: ''
    }
  };

  handleSubmit = async () => {
    const { search_attrs } = this.state;
    this.setState({ loading: true });

    try {
      const result = await Api.post('/search', search_attrs);
      this.setState({
        process: result.data,
        loading: false,
        error_message: null
      });
    } catch (error) {
      this.setState({ loading: false, error_message: error.message });
    }
  }

  handleChange = (input_name, evt) => {
    let { search_attrs } = this.state;
    search_attrs[input_name] = evt.target.value;

    this.setState({ search_attrs });
  }

  render() {
    return (
      <ProcessContext.Provider
        value={{
          state: this.state,
          handleSubmit: this.handleSubmit,
          handleChange: this.handleChange,
        }}
      >
        <NavbarSearch />
        <ProcessScreen />
      </ProcessContext.Provider>
    );
  }
}
