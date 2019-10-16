import React from 'react';

import PropType from 'prop-types';

const Button = (props) => {
  const {
    nameClass, type, name, children, loading, ...rest
  } = props;

  return (
    <button
      className={nameClass}
      type={type}
      name={name}
      disabled={loading === false ? '' : 'disabled'}
      {...rest}
    >
      {children}
    </button>
  );
};

Button.propTypes = {
  nameClass: PropType.string.isRequired,
  type: PropType.string.isRequired,
  name: PropType.string.isRequired,
  children: PropType.string.isRequired,
  loading: PropType.bool.isRequired,
};

export default Button;
