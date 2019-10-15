import React from 'react';

import PropType from 'prop-types';

const Button = props => {
  const { class_name, type, name, children, loading, ...rest } = props;

  return (
    <button
      className={class_name}
      type={type}
      name={name}
      disabled={loading == false ? '' : 'disabled'}
      {...rest}
    >
      {children}
    </button>
  );
};

Button.propTypes = {
  class_name: PropType.string.isRequired,
  type: PropType.string.isRequired,
  name: PropType.string.isRequired,
  children: PropType.string.isRequired,
  loading: PropType.bool.isRequired,
};

export default Button;
