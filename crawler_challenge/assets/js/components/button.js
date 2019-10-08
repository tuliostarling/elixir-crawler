import React from "react";

import PropType from "prop-types";

const Button = props => {
  const { class_name, type, name, children, ...rest } = props;

  return (
    <button className={class_name} type={type} name={name} {...rest}>
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
