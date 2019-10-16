import { SearchForm } from '../../../screens/navbar_search/form';
import { Button, SelectInput, TextInput } from '../../../components';

describe('<SearchForm />', () => {
  it('Should render children components', () => {
    const handleSubmit = jest.fn();
    const handleChange = jest.fn();
    const component = shallow(
      <SearchForm
        courts={[]}
        handleSubmit={handleSubmit}
        handleChange={handleChange}
        loading={false}
      />
    );
    expect(component.find(Button)).toHaveLength(1);
    expect(component.find(TextInput)).toHaveLength(1);
    expect(component.find(SelectInput)).toHaveLength(1);
  });
});
