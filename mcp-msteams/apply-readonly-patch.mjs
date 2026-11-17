import { readFileSync, writeFileSync } from 'node:fs';

const path = process.argv[2] ?? '/app/src/tools/search-tools.ts';
let source = readFileSync(path, 'utf8');

const replacements = [
  [
    "  markRead: z.boolean().optional().default(false),",
    "  markRead: z.literal(false).optional().default(false),",
  ],
  [
    'Returns unread count and can optionally mark as read.',
    'Returns unread count without changing the read position.',
  ],
  [
    "        type: 'boolean',\n        description: 'If true, marks the conversation as read up to the latest message after fetching (default: false)',",
    "        type: 'boolean',\n        enum: [false],\n        description: 'Read-only deployment: must be false.',",
  ],
];

for (const [before, after] of replacements) {
  if (source.indexOf(before) === -1 || source.indexOf(before) !== source.lastIndexOf(before)) {
    throw new Error(`Expected exactly one upstream match: ${before}`);
  }
  source = source.replace(before, after);
}

writeFileSync(path, source);
