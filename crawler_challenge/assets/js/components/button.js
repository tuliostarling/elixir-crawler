import React from "react";

import PropType from "prop-types";

const Button = props => {
  const { class_name, type, name, children } = props;

  return (
    <button className={class_name} type={type} name={name}>
      {children}
    </button>
  );
};

Button.propTypes = {
  class_name: PropType.string.isRequired,
  type: PropType.string.isRequired,
  name: PropType.string.isRequired,
  children: PropType.string.isRequired
};

export default Button;
