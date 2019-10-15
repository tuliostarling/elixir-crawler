import React, { Component, Fragment } from 'react';

import PropType from 'prop-types';

import { MovementCard } from './movement_card';
import { DetailsCard } from './details_card';
import { RelatedPartiesCard } from './related_parties_card';
import { EmptyPage } from './empty';
import ProcessContext from '../Context';

export default class ProcessScreen extends Component {
  static contextType = ProcessContext;

  render_card(context) {
    const { state } = context;

    return (
      <Fragment>
        <div className="wrapper__card_header">
          <h4 className="wrapper__card_header___title">
            Processo n. {state.process.process_number} do{' '}
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
      </Fragment>
    );
  }

  render_empty_or_card() {
    const { context } = this;

    if (
      context.state.process != undefined &&
      context.state.error_message == null
    ) {
      return this.render_card(context);
    }

    return <EmptyPage message={context.state.error_message} />;
  }

  render() {
    return (
      <Fragment>
        <div className="wrapper">{this.render_empty_or_card()}</div>
      </Fragment>
    );
  }
}

ProcessScreen.propTypes = {
  process: PropType.objectOf(
    PropType.shape({
      id: PropType.number.isRequired,
      court_id: PropType.object.isRequired,
      process_number: PropType.string.isRequired,
      details: PropType.arrayOf(
        PropType.shape({
          id: PropType.number.isRequired,
          process_id: PropType.number.isRequired,
          area: PropType.string.isRequired,
          class: PropType.string.isRequired,
          control: PropType.string.isRequired,
          distribution_date: PropType.string.isRequired,
          judge: PropType.string.isRequired,
          other_subject: PropType.string,
          process_number: PropType.string.isRequired,
          stock_price: PropType.string.isRequired,
          subject: PropType.string.isRequired
        }),
      ).isRequired,
      movements: PropType.arrayOf(
        PropType.shape({
          id: PropType.number.isRequired,
          process_id: PropType.number.isRequired,
          movement: PropType.string.isRequired,
          movement_date: PropType.string.isRequired
        }),
      ).isRequired,
      parties: PropType.arrayOf(
        PropType.shape({
          id: PropType.number.isRequired,
          process_id: PropType.number.isRequired,
          name: PropType.string.isRequired,
          partie: PropType.string.isRequired,
          person_name_position: PropType.string.isRequired,
          position: PropType.string.isRequired
        }),
      ).isRequired,
    }),
  ),
};

ProcessScreen.defaultProps = {
  process: null,
};
