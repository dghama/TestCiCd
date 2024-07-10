import React from 'react';
import { render } from '@testing-library/react-native';
import Section from '../SectionComponent'; // Update this path based on your file structure

describe('Section', () => {
  it('renders correctly with title and children', () => {
    const { getByText } = render(
      <Section title="Test Title">Test Children</Section>
    );

    expect(getByText('Test Title')).toBeTruthy();
    expect(getByText('Test Children')).toBeTruthy();
  });

  it('applies correct styles based on color scheme', () => {
    const { getByText } = render(
      <Section title="Test Title">Test Children</Section>
    );

    // Add assertions for styles based on color scheme
    expect(getByText('Test Title').props.style).toMatchObject([
      { fontSize: 24, fontWeight: '600' },
      { color: '#000' }
    ]);
  });
});
