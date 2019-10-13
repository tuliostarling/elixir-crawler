import React from "react";

import PropType from "prop-types";

export const DetailsList = props => {
  const { details } = props;

  const detail_list = Object.entries(details).map(([key, value]) => {
    return (
      <div className="detail_wrapper" key={key}>
        <p className="detail_wrapper__value">
          {value == null ? null : `${key}: `}
          {value == null ? null : value.toString()}
        </p>
      </div>
    );
  });

  return detail_list;
};

DetailsList.propTypes = {
  details: PropType.objectOf(
    PropType.shape({
      id: PropType.number.isRequired,
      process_id: PropType.number.isRequired,
      area: PropType.object.isRequired,
      class: PropType.string.isRequired,
      control: PropType.string.isRequired,
      distribution_date: PropType.string.isRequired,
      judge: PropType.string.isRequired,
      other_subject: PropType.string,
      process_number: PropType.string.isRequired,
      stock_price: PropType.string.isRequired,
      subject: PropType.string.isRequired
    })
  ).isRequired
};
