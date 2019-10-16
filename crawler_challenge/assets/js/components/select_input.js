import React from 'react';

import PropType from 'prop-types';

const SelectInput = (props) => {
  const { nameClass, options, ...rest } = props;

  return (
    <select className={nameClass} {...rest} defaultValue="">
      <option value="" disabled>Selecione o tribunal</option>
      {options.map((option) => (
        <option key={option.id} value={option.name}>
          {option.name}
          {' '}
- (
          {option.initials}
)
        </option>
      ))}
    </select>
  );
};

SelectInput.propTypes = {
  nameClass: PropType.string.isRequired,
  options: PropType.arrayOf(
    PropType.shape({
      id: PropType.number.isRequired,
      name: PropType.string.isRequired,
      initials: PropType.string.isRequired,
    }),
  ).isRequired,
};

export default SelectInput;
