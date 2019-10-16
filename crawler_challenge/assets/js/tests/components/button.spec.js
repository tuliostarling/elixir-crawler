import React from 'react';
import { shallow } from 'enzyme';

import Button from '../../components/button';

describe('<Button />', () => {
  it('Should fire callback function onClick', () => {
    const mockHandleClick = jest.fn();
    const component = shallow(
      <Button
        nameClass="foo"
        type="submit"
        name="button"
        loading={false}
        onClick={mockHandleClick}
      >
        Buscar
      </Button>,
    );

    const button = component.find('button');
    button.simulate('click');
    expect(mockHandleClick).toHaveBeenCalled();
  });

  it('Should render the button with custom text', () => {
    const component = shallow(
      <Button nameClass="foo" type="submit" name="button" loading={false}>
        Buscar
      </Button>,
    );

    const button = component.find('button');
    expect(button).toHaveLength(1);
    expect(button.prop('type')).toEqual('submit');
    expect(button.text()).toEqual('Buscar');
  });
});
