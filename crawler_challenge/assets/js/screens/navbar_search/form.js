import React, { Fragment } from 'react';

import PropType from 'prop-types';

import { Button, SelectInput, TextInput } from '../../components';

export const SearchForm = (props) => {
  const { courts, handleChange, handleSubmit } = props;

  return (
    <Fragment>
      <div className="input-field col s12">
        <SelectInput
          class_name="select_court_input"
          options={courts}
          onChange={(evt) => handleChange('court', evt)}
        />
      </div>
      <div className="input-field col s12">
        <TextInput
          placeholder="Número do processo"
          id="first_name"
          type="text"
          class_name="validate text_input"
          onChange={(evt) => handleChange('process_n', evt)}
        />
      </div>

      <Button
        class_name="btn waves-effect waves-light btn nav-wrapper__btn"
        type="submit"
        name="action"
        onClick={() => handleSubmit()}
      >
        Buscar
      </Button>
    </Fragment>
  );
};

SearchForm.propTypes = {
  courts: PropType.arrayOf(
    PropType.shape({
      id: PropType.number.isRequired,
      name: PropType.string.isRequired,
      initials: PropType.string.isRequired,
    }),
  ).isRequired,
  handleChange: PropType.func.isRequired,
  handleSubmit: PropType.func.isRequired,
};
