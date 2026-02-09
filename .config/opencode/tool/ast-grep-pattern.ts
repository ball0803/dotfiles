import { tool } from '@opencode-ai/plugin';

export const ast_grep_pattern = tool({
  description: 'Create and test ast-grep patterns for code analysis',
  args: {
    pattern_type: tool.schema
      .enum(['regex', 'semantic', 'struct'])
      .describe('Type of pattern (regex, semantic, struct)')
      .default('regex'),
    target: tool.schema.string().describe('What to match (e.g., function, class, variable)').optional(),
    language: tool.schema.string().describe('Programming language').optional(),
    example_code: tool.schema.string().describe('Example code to test the pattern against').optional(),
  },
  async execute(args) {
    let patternInfo = '';

    switch (args.pattern_type) {
      case 'regex':
        patternInfo = createRegexPattern(args.target);
        break;
      case 'semantic':
        patternInfo = createSemanticPattern(args.target, args.language);
        break;
      case 'struct':
        patternInfo = createStructPattern(args.target, args.language);
        break;
    }

    if (args.example_code) {
      patternInfo += '\\n\\n---\\n\\nTesting pattern against example code:\\n\\n```\\n' + args.example_code + '\\n```';
    }

    return patternInfo;
  },
});

function createRegexPattern(target?: string): string {
  if (target) {
    return `### Regex Pattern for "${target}"\\n\\n\`\`\`\\n${target}\\n\`\`\`\\n\\n**Usage:**\\n\`\`\`bash\\nast-grep -n '${target}' your_file.ts\\n\`\`\`\\n\\n**Description:** Simple regex pattern matching any occurrence of "${target}"`;
  }
  return '### Regex Pattern\\n\\nRegex patterns use standard regular expressions for matching code.';
}

function createSemanticPattern(target?: string, language?: string): string {
  const langInfo = language ? ` for ${language}` : '';
  const targetInfo = target ? ` for "${target}"` : '';

  return `### Semantic Pattern${langInfo}${targetInfo}\\n\\n\`\`\`\\n${target || 'your_pattern'}\\n\`\`\`\\n\\n**Usage:**\\n\`\`\`bash\\nast-grep -n --lang ${language || 'typescript'} '${target || 'your_pattern'}' your_file.ts\\n\`\`\`\\n\\n**Description:** Semantic patterns understand the AST structure and can match based on syntax rules.`;
}

function createStructPattern(target?: string, language?: string): string {
  const langInfo = language ? ` for ${language}` : '';

  return `### Struct Pattern${langInfo}\\n\\n\`\`\`\\n${target || 'your_struct_pattern'}\\n\`\`\`\\n\\n**Usage:**\\n\`\`\`bash\\nast-grep -n --lang ${language || 'typescript'} '${target || 'your_struct_pattern'}' your_file.ts\\n\`\`\`\\n\\n**Description:** Struct patterns allow matching specific AST node structures with placeholders.`;
}
