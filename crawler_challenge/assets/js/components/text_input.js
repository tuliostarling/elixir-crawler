import React from 'react';

import PropType from 'prop-types';

const TextInput = (props) => {
  const {
    nameClass, type, id, placeholder, ...rest
  } = props;

  return (
    <input
      className={nameClass}
      type={type}
      id={id}
      placeholder={placeholder}
      minLength="25"
      maxLength="25"
      {...rest}
    />
  );
};

TextInput.propTypes = {
  nameClass: PropType.string.isRequired,
  type: PropType.string.isRequired,
  id: PropType.string.isRequired,
  placeholder: PropType.string.isRequired,
};

export default TextInput;
