import React from 'react';
import { shallow } from 'enzyme';

import { TextInput } from '../../components';

describe('<TextInput />', () => {
  it('should renders text input with label (default type)', () => {
    const component = shallow(
      <TextInput nameClass="foo" type="text" id="bar" placeholder="Processo" />,
    );
    const input = component.find('input');
    expect(input).toHaveLength(1);
    expect(input.prop('type')).toEqual('text');
    expect(input.prop('placeholder')).toEqual('Processo');
    expect(input.prop('id')).toEqual('bar');
  });
});
