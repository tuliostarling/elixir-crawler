import React, { Component } from "react";

import { Button, SelectInput, TextInput } from "../../components";

export default class NavbarSearch extends Component {
  constructor(props) {
    super(props);

    this.state = {
      options: [{ name: "Tribunal de Justiça do Alagoas (TJAL)", key: 1 }]
    };
  }

  // Fazer o form funcionar junto com a requisição pro backend

  render() {
    const { options } = this.state;

    return (
      <header>
        <nav>
          <div className="nav-wrapper">
            <div className="input-field col s12">
              <SelectInput class_name="select_court_input" options={options} />
            </div>
            <div className="input-field col s12">
              <TextInput
                placeholder="Número do processo"
                id="first_name"
                type="text"
                class_name="validate text_input"
              />
            </div>

            <Button
              class_name="btn waves-effect waves-light btn nav-wrapper__btn"
              type="submit"
              name="action"
            >
              Buscar
            </Button>
          </div>
        </nav>
      </header>
    );
  }
}
