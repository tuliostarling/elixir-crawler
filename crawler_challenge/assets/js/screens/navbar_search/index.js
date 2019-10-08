import React, { Component } from "react";

import "babel-polyfill";

import { Button, SelectInput, TextInput } from "../../components";

import Api from "../../api"

export default class NavbarSearch extends Component {
  constructor(props) {
    super(props);

    this.state = {
      search_attrs: {
        court: "",
        process_n: ""
      },

      options: [
        { name: "Selecione um tribunal", key: 0 },
        { name: "Tribunal de Justiça do Alagoas (TJAL)", key: 1 }
      ]
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  async handleSubmit() {
    const { search_path } = this.props;
    const { search_attrs } = this.state;

    try {
      await Api.post(search_path, search_attrs);
    } catch (error) {
      console.log(error)
    }
  };

  handleChange(input_name, evt) {
    let { search_attrs } = this.state;
    search_attrs[input_name] = evt.target.value;
    this.setState({ search_attrs });
  }

  render() {
    const { options } = this.state;

    return (
      <header>
        <nav>
          <div className="nav-wrapper">
            <div className="input-field col s12">
              <SelectInput
                class_name="select_court_input"
                options={options}
                onChange={evt => this.handleChange("court", evt)}
              />
            </div>
            <div className="input-field col s12">
              <TextInput
                placeholder="Número do processo"
                id="first_name"
                type="text"
                class_name="validate text_input"
                onChange={evt => this.handleChange("process_n", evt)}
              />
            </div>

            <Button
              class_name="btn waves-effect waves-light btn nav-wrapper__btn"
              type="submit"
              name="action"
              onClick={() => this.handleSubmit()}
            >
              Buscar
            </Button>
          </div>
        </nav>
      </header>
    );
  }
}
