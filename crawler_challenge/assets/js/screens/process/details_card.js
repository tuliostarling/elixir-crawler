import React from 'react';

import PropType from 'prop-types';

import { DetailsList } from './details_list';

export const DetailsCard = (props) => {
  const { details } = props;

  return (
    <div className="card">
      <div className="card-content details_content">
        <span className="card-title">Detalhes do processo</span>
        {details.map((detail) => (
          <DetailsList key={detail.id} details={detail} />
        ))}
      </div>
    </div>
  );
};

DetailsCard.propTypes = {
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
      subject: PropType.string.isRequired,
    }),
  ).isRequired,
};
