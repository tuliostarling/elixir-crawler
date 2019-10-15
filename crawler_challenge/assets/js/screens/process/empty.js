import React from 'react';

import PropType from 'prop-types';

export const EmptyPage = (props) => {
  const { message } = props;

  return (
    <div className="wrapper__empty_header">
      <h4 className="wrapper__empty_header___title">
        {message == null
          ? "Insira dados no form para aparecer dados!"
          : message}
      </h4>
    </div>
  );
};

EmptyPage.propTypes = {
  error: PropType.object.isRequired
};

EmptyPage.defaultProps = {
  error: ""
};
