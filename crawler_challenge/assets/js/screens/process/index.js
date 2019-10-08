import React, { Component } from "react";

import { MovementCard } from "./movement_card";
import { DetailsCard } from "./details_card";
import { RelatedPartiesCard } from "./related_parties_card";

export default class ProcessScreen extends Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  // Precisar do nome do processo, data de distribuição
  // Passar por props pro component MovementCard um array com os dados de movimento do processo
  // Passar por props pro component DetailsCard os dados de detalhes do processo

  render() {
    return (
      <div className="wrapper">
        <div className="wrapper__card_header">
          <h4 className="wrapper__card_header___title">
            Processo n. 1008126-92.2015.8.26.0132 do TJAL
          </h4>
          <span className="wrapper__card_header___sub_title">
            Distribuído em 09/11/2017
          </span>
        </div>

        <div className="row">
          <div className="col s12 m8 l8 wrapper__movement_card">
            <MovementCard />
          </div>
          <div className="col s12 m4 l4">
            <DetailsCard />
            <RelatedPartiesCard />
          </div>
        </div>
      </div>
    );
  }
}
