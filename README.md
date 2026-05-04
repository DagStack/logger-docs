# dagstack/logger documentation

Documentation site for [`dagstack/logger`](https://github.com/dagstack/logger-spec) — an OpenTelemetry-compatible structured-logging contract for the dagstack ecosystem.

The site is built with [Docusaurus 3.x](https://docusaurus.io/) and serves [logger.dagstack.dev](https://logger.dagstack.dev). The repository is also indexed by [context7](https://context7.com/) via the root `context7.json`, so AI assistants can answer questions about the logger contract with up-to-date guidance.

## Layout

```
.
├── context7.json            # context7 indexing config (root, never inside site/)
├── README.md
├── CONTRIBUTING.md          # writing conventions, commit identity, pre-PR checks
├── LICENSE                  # Apache-2.0
├── Makefile                 # dev / build / validate targets
├── .gitea/workflows/        # Gitea Actions: docs build, mirror to GitHub, deploy to Pages
└── site/                    # Docusaurus project
    ├── docs/
    │   ├── intro.mdx
    │   ├── concepts/        # severity, sinks, context, operations, redaction, scoped-overrides, wire-formats, ai-agents
    │   ├── guides/          # configure, testing, custom-sink
    │   ├── reference/       # log-record, severity-table, errors
    │   ├── spec/            # overview + ADR synopses
    │   └── api/             # python, typescript, go — all three real surfaces
    ├── src/                 # custom React, CSS
    └── static/img/          # favicons
```

## Local development

```bash
cd site
npm install
npm run start        # dev server on :3000
npm run build        # production build → site/build/
```

The same shortcuts live at the repo root via `make`:

```bash
make install         # cd site && npm install
make dev             # cd site && npm run start
make build           # cd site && npm run build
make validate        # validate context7.json + scrub-check
```

Node.js ≥ 20 is required (Docusaurus 3.x baseline).

## i18n

Two locales are configured: `en` (default, source) and `ru` (translation). The English content is the source of truth; Russian translations live under `site/i18n/ru/` and follow the source structure. See `CONTRIBUTING.md` for the translation workflow.

## context7 indexing

`context7.json` lives at the repo root. It indexes `site/docs/` and the root `README.md`, excluding build artifacts and configuration files. The `rules` array summarises install instructions, severity model, the Sink protocol, context propagation, redaction, scoped overrides, wire formats, the AI-agent extension pack, configuration, and per-language casing.

## Related repositories

- [`dagstack/logger-spec`](https://github.com/dagstack/logger-spec) — the normative ADR (v1.0).
- [`dagstack/logger-python`](https://github.com/dagstack/logger-python) — Python binding, on PyPI as [`dagstack-logger`](https://pypi.org/project/dagstack-logger/) (Phase 1, v0.1.x).
- [`dagstack/logger-typescript`](https://github.com/dagstack/logger-typescript) — TypeScript / Node.js binding, on npmjs.org as [`@dagstack/logger`](https://www.npmjs.com/package/@dagstack/logger) (Phase 1, v0.1.x).
- [`dagstack/logger-go`](https://github.com/dagstack/logger-go) — Go binding, importable as `go.dagstack.dev/logger` (Phase 1, v0.1.x).
- [`dagstack/config-docs`](https://github.com/dagstack/config-docs) — sister docs site for `dagstack/config`.

## License

Apache-2.0 — see [LICENSE](./LICENSE).
