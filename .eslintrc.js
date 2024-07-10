module.exports = {
  root: true,
  extends: [
    '@react-native',
    'plugin:sonarjs/recommended',
    'standard-with-typescript'
  ],
  plugins: ['@typescript-eslint', 'sonarjs'],
  parser: '@typescript-eslint/parser',
  parserOptions: { project: './tsconfig.json' },
  rules: {
    '@typescript-eslint/semi': 'off',
    semi: 'off',
    'space-before-function-paren': 'off',
    '@typescript-eslint/member-delimiter-style': 'off',
    '@typescript-eslint/space-before-function-paren': 'off',
    '@typescript-eslint/consistent-type-definitions': 'off',
    '@typescript-eslint/strict-boolean-expressions': 'off',
    '@typescript-eslint/indent': 'off',
    'multiline-ternary': 'off',
    'react-hooks/exhaustive-deps': 'off',
    'no-console': 'warn',
    'sonarjs/cognitive-complexity': ['error', 20]
  },
  env: { 'jest/globals': true, node: true }
};
