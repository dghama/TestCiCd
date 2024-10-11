module.exports = {
  root: true,
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/eslint-recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:react-native-a11y/all',
    'plugin:sonarjs/recommended-legacy',
    'prettier'
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: 'tsconfig.json',
    sourceType: 'module',
    ecmaFeatures: {
      jsx: true
    }
  },
  plugins: [
    '@typescript-eslint',
    'react',
    'react-native',
    'react-hooks',
    'import',
    'functional',
    'sonarjs'
  ],
  rules: {
    '@typescript-eslint/semi': 'off',
    semi: 'off',
    'space-before-function-paren': 'off',
    '@typescript-eslint/member-delimiter-style': 'off',
    '@typescript-eslint/space-before-function-paren': 'off',
    '@typescript-eslint/consistent-type-definitions': 'off',
    '@typescript-eslint/strict-boolean-expressions': 'off',
    '@typescript-eslint/no-unused-vars': 'off',
    '@typescript-eslint/indent': 'off',
    'multiline-ternary': 'off',
    'react-hooks/exhaustive-deps': 'off',
    'no-console': 'warn',
    'sonarjs/cognitive-complexity': ['error', 20]
  },
  env: {
    'react-native/react-native': true
  },
  overrides: [
    {
      files: ['**/*.test.*'],
      rules: {
        '@typescript-eslint/no-non-null-assertion': 'off'
      }
    }
  ],
  settings: {
    react: {
      version: 'detect'
    }
  }
};
