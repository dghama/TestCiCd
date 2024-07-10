const { defaults: tsjPreset } = require('ts-jest/presets');

module.exports = {
  setupFiles: [
    './jest.setup.js',
    './node_modules/react-native-gesture-handler/jestSetup.js'
  ],
  preset: 'react-native',
  transformIgnorePatterns: [
    'node_modules/(?!(@react-.*|.*react-native.*|.*react-native-*|sync-storage*)/)'
  ],
  // An array of glob patterns indicating a set of files for which coverage information should be collected
  collectCoverage: true,
  collectCoverageFrom: ['<rootDir>/**/*.{ts,js,jsx,tsx}'],
  // An array of regexp pattern strings used to skip coverage collection
  coveragePathIgnorePatterns: ['<rootDir>/android/', '<rootDir>/ios/'],
  // An array of Regex patterns indicating files that should be ignored from tests
  testPathIgnorePatterns: ['node_modules', 'android', 'ios'],

  // A list of reporter names that Jest uses when writing coverage reports
  coverageReporters: ['json', 'lcov', 'text']
};
