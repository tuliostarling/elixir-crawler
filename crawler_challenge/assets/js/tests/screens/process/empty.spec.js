import { EmptyPage } from '../../../screens/process/empty';

describe('<EmptyScreen />', () => {
  it('should renders error message', () => {
    const component = shallow(<EmptyPage message="error" />);

    expect(component.text()).toEqual('error');
  });

  it('should renders form text', () => {
    const component = shallow(<EmptyPage message={null} />);

    expect(component.text()).toEqual(
      'Insira dados no form para aparecer dados!'
    );
  });
});
