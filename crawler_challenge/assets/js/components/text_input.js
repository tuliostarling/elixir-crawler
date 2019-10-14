import React from 'react';

import PropType from 'prop-types';

const TextInput = (props) => {
  const {
    class_name, type, id, placeholder, ...rest
  } = props;

  return (
    <input
      className={class_name}
      type={type}
      id={id}
      placeholder={placeholder}
      {...rest}
    />
  );
};

TextInput.propTypes = {
  class_name: PropType.string.isRequired,
  type: PropType.string.isRequired,
  id: PropType.string.isRequired,
  placeholder: PropType.string.isRequired,
};

export default TextInput;
