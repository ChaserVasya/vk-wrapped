module.exports = {
    parser: '@typescript-eslint/parser',
    plugins: ['@typescript-eslint'],
    extends: [
        'eslint:recommended'
    ],
    rules: {
        '@typescript-eslint/no-explicit-any': 'error',
        '@typescript-eslint/no-unused-vars': 'error'
    },
    env: {
        node: true,
        es2020: true,
        jest: true
    },
    parserOptions: {
        ecmaVersion: 2020,
        sourceType: 'module'
    },
    overrides: [
        {
            files: ['**/__tests__/**/*.ts', '**/*.test.ts'],
            rules: {
                '@typescript-eslint/no-explicit-any': 'off'
            }
        }
    ]
}; 