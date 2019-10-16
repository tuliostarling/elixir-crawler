import React, { Component } from "react";

import { MovementCard } from "./movement_card";
import { DetailsCard } from "./details_card";
import { RelatedPartiesCard } from "./related_parties_card";
import { EmptyPage } from "./empty";
import ProcessContext from "../Context";

export default class ProcessScreen extends Component {
  static contextType = ProcessContext;

  renderCard(context) {
    const { state } = context;

    return (
      <>
        <div className="wrapper__card_header">
          <h4 className="wrapper__card_header___title">
            Processo n. {state.process.process_number} do{" "}
            {state.courts[0].initials}
          </h4>
          <span className="wrapper__card_header___sub_title">
            Distribuído em {state.process.details[0].distribution_date}
          </span>
        </div>

        <div className="row">
          <div className="col s12 m8 l8 wrapper__movement_card">
            <MovementCard movements={state.process.movements} />
          </div>
          <div className="col s12 m4 l4">
            <DetailsCard details={state.process.details} />
            <RelatedPartiesCard parties={state.process.parties} />
          </div>
        </div>
      </>
    );
  }

  renderEmptyOrCard() {
    const { context } = this;

    if (
      context.state.process != undefined &&
      context.state.error_message == null
    ) {
      return this.renderCard(context);
    }

    return <EmptyPage message={context.state.error_message} />;
  }

  render() {
    return (
      <>
        <div className="wrapper">{this.renderEmptyOrCard()}</div>
      </>
    );
  }
}
