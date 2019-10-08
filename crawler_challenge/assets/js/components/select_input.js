import React from "react";

import PropType from "prop-types";

const SelectInput = props => {
  const { class_name, options, ...rest } = props;

  return (
    <select className={class_name} {...rest}>
      {options.map(option => (
        <option key={option.key} value={option.key}>
          {option.name}
        </option>
      ))}
    </select>
  );
};

SelectInput.propTypes = {
  class_name: PropType.string.isRequired,
  options: PropType.arrayOf(
    PropType.shape({
      name: PropType.string.isRequired,
      key: PropType.number.isRequired
    })
  ).isRequired
};

export default SelectInput;
