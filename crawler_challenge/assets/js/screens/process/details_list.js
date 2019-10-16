import React from 'react';

import PropType from 'prop-types';

export const DetailsList = (props) => {
  const { details } = props;

  console.log(details)

  return (
    <div className="detail_wrapper">
      <p className="detail_wrapper__value">
        {details.class == null ? null : `Classe: ${details.class}`}
      </p>
      <p className="detail_wrapper__value">
        {details.area == null ? null : `Área: ${details.area}`}
      </p>
      <p className="detail_wrapper__value">
        {details.subject == null ? null : `Assunto: ${details.subject}`}
      </p>
      <p className="detail_wrapper__value">
        {details.distribution_date == null
          ? null
          : `Data de distribuição: ${details.distribution_date}`}
      </p>
      <p className="detail_wrapper__value">
        {details.judge == null ? null : `Juiz: ${details.judge}`}
      </p>
      <p className="detail_wrapper__value">
        {details.stock_price == null
          ? null
          : `Valor da ação: ${details.stock_price}`}
      </p>
    </div>
  );
};

DetailsList.propTypes = {
  details: PropType.objectOf(
    PropType.shape({
      id: PropType.number.isRequired,
      process_id: PropType.number.isRequired,
      area: PropType.string.isRequired,
      class: PropType.string.isRequired,
      control: PropType.string,
      distribution_date: PropType.string.isRequired,
      judge: PropType.string,
      other_subject: PropType.string,
      process_number: PropType.string.isRequired,
      stock_price: PropType.string.isRequired,
      subject: PropType.string.isRequired
    })
  ).isRequired
};

DetailsList.defaultProps = {
  control: null,
  judge: null,
  other_subject: null
};
