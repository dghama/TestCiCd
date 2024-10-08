/**
 * @format
 */
import React from 'react';
import { render } from '@testing-library/react-native';
import App from '../App';

describe('App', () => {
  it('renders correctly', () => {
    const { getByText } = render(<App />);

    expect(getByText('Step One -')).toBeTruthy();
    expect(getByText('See Your Changes -')).toBeTruthy();
    expect(getByText('Debug -')).toBeTruthy();
    expect(getByText('Learn More -')).toBeTruthy();
  });
});
