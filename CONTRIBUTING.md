# Contributing

A short set of conventions for page authors and reviewers of the `dagstack/logger` documentation site.

## Language

- Page prose is written in **English** (source). The Russian translation lives under `site/i18n/ru/` and follows the source structure.
- Identifier names, config keys, constant values, and the contents of fenced blocks stay in **English** in every locale.
- Avoid jargon and anglicisms where a plain English equivalent reads better. Keep technical terms of art unchanged: "payload", "fallback", "binding", "wire format", "snapshot", "sink", "trace context".
- `rules` in `context7.json` — **English** (LLM-first).

## Code-example tabs

The only allowed pattern is `<Tabs>` + `<TabItem>` with regular fenced code inside:

```mdx
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs groupId="lang" queryString="lang">
  <TabItem value="python" label="Python">
    ```python
    # ...
    ```
  </TabItem>
  <TabItem value="typescript" label="TypeScript">
    Prose-only description until the binding ships.
  </TabItem>
  <TabItem value="go" label="Go">
    Prose-only description until the binding ships.
  </TabItem>
</Tabs>
```

Mandatory rules:

- `groupId="lang"` on every block — language selection is synced site-wide.
- `queryString="lang"` — selection is reflected in the URL (`?lang=go`).
- Tab order: **Python → TypeScript → Go**.
- `value=` is strictly `python`, `typescript`, `go` (lowercase, no abbreviations).
- Every fenced block declares a language explicitly (`python`, `ts`, `go`, `bash`, `yaml`, `json`).

**Forbidden**:

- Custom JSX wrappers around code (`<CodeExample>`, `<MultiCode>`). The context7 parser does not understand them — snippets lose their language.
- `<Tabs>` inside `<details>` or admonitions (`:::note`, `:::tip`).
- A fenced block with no language or language `text`.
- **Code blocks for unimplemented APIs.** TypeScript and Go bindings are on the roadmap; their tabs use prose only until v0.1.0 of each binding ships. Inventing snippets pollutes context7 indexing.

## API existence — anti-hallucination

Every Python code snippet must reference a real export from [`dagstack/logger-python`](https://github.com/dagstack/logger-python) `__init__.py`. Before adding a snippet:

1. Read `src/dagstack/logger/__init__.py` to confirm the symbol is exported.
2. Read the implementing module to confirm the signature.
3. If the symbol does not exist yet, either implement it first or wrap the prose in a `:::caution Phase 1 status:::` admonition with a tracking-issue link.

The Python tab is the canonical, working example. The TypeScript and Go tabs describe planned shape in prose only; when the bindings ship, those tabs receive proper code.

## Page structure

- Frontmatter with `title`, `description`, `slug`, optionally `sidebar_position`.
- One H1 (generated from `title`).
- H2 — one operation / concept per heading.
- **Prose → `<Tabs>`**, not `<Tabs>` → prose. API description before the code block.
- Snippets are self-contained (each runs independently of its neighbors).
- Realistic names (`order-service`, `acme-corp`, not `foo`).

## Privacy: what does NOT go into the public repo

The names of internal systems and integrations that must not appear in public documentation are tracked in a **local** `.scrub-patterns` file (gitignored, maintained by core contributors). Before every push, run:

```bash
make validate
```

The command validates `context7.json` and runs the scrub check. If `.scrub-patterns` is not present (e.g., you are an external contributor), the check is silently skipped — but an internal reviewer will run it before merge.

The general rule is to **use generic domains in examples** (`order-service`, `payment-processor`, `code-search RAG application`). Avoid mentioning specific products, customers, or internal services.

## Local checks before a PR

```bash
make build           # build the site, make sure there are no errors
make validate        # validate context7.json + scrub-check
```

A passing `npm run build` (zero broken-link warnings) is the minimum gate. The build also catches MDX syntax errors and missing imports.

## CI (build gate)

Every PR and push to `main` triggers `.gitea/workflows/docs.yml`:

1. `context7.json` validation.
2. `npm ci` + `npm run build` in `site/` — full site build that fails on broken links and MDX errors.
3. Mirror to GitHub via `.gitea/workflows/mirror.yml` and deploy to GitHub Pages via `.gitea/workflows/deploy-pages.yml` after merge to `main`.

The workflows run on the `dagstack-runner` tag.

## Translation workflow

Russian (`ru`) translations live under `site/i18n/ru/`:

1. After updating an English page, regenerate the i18n templates:
   ```bash
   cd site
   npm run write-translations -- --locale ru
   ```
2. Translate the new strings in `site/i18n/ru/docusaurus-plugin-content-docs/current/`.
3. Run `npm run build` and verify both locales render correctly.

The translation discipline matches the [dagstack writing-style guide](../../.dagstack/skills/dagstack-doc-writing): identifiers stay English, prose translates by meaning rather than transliterated English. Code snippets are not translated — comments inside public-API examples stay in English.

## Commit messages

- Conventional Commits: `feat(docs): ...`, `fix(docs): ...`, `chore(docs): ...`.
- First line — English imperative.
- No `Co-Authored-By Claude`, no "🤖 Generated with ...", no AI attribution.

## Identity

```bash
git config user.name "Evgenii Demchenko"
git config user.email "demchenkoev@gmail.com"
```

For `dagstack/*` repositories the email is gmail (public identity).
