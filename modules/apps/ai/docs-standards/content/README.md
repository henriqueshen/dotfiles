# Documentation standards

This directory holds the writing guides, one exemplar per document type, a banlist of writing patterns, and a readiness checklist. Read this file before writing or reviewing any document, then read the guide and the exemplar for the document type at hand, and match the exemplar's structure, register, sentence shape, and length. Check every response and artifact against `banlist.md` before sending it.

## Guides

| File | Use it for |
|---|---|
| `guides/django-writing-documentation.rst` | How a documentation set is organised (tutorials, topic guides, reference, how-to guides) and Django's prose rules. Read first. |
| `guides/mdn-writing-style-guide.md` | Any prose question Django's guide does not answer: voice, grammar, headings, code examples, page structure. |

## Exemplars by document type

| Document type | Exemplar | What to match |
|---|---|---|
| Area design document (`docs/<group>/<area>/README.md`) | `exemplars/architecture/sqlite-architecture.md` | A short introduction, one section per component, short direct sentences, links to the source that implements each part. Roughly 1,300 words. |
| Area design document for a layered system | `exemplars/architecture/cockroachdb-architecture-overview.md` | Design goals, a high-level overview, a table of layers, then one page per layer. Written for serious users, not only maintainers. |
| Topic guide (explanation) | `exemplars/topic-guide/django-database-transactions.rst` | Concepts explained in order of need, examples inline, links to reference instead of repeating it. |
| How-to guide and runbook | `exemplars/how-to/django-custom-management-commands.rst` | A result-oriented recipe that assumes familiarity, with one worked example carried through. Runbooks add preconditions, expected results per step, verification, rollback, and escalation. |
| Reference page (`api/`) | `exemplars/reference/postgresql-create-index.md` | Synopsis, description, parameters, notes, examples, compatibility, see also. Complete on one page. |
| Reference page for a client-facing API | `exemplars/reference/mdn-array-prototype-map.md` | Syntax, parameters, return value, description, examples, specifications. |
| Product and integration guides | Stripe's guides, for example <https://docs.stripe.com/payments/accept-a-payment>. Read online, not vendored. | One task per page, the code the reader needs beside the explanation, nothing the reader does not need for that task. |

Working specs do not use an exemplar. They use the `/to-spec` template and are held to "enough for `/to-tickets` to cut slices from, and nothing else."

## Other files

| File | Use it for |
|---|---|
| `banlist.md` | Words, constructions, and formatting habits that mark text as machine-written, including the ones specific to Claude models. Every response and artifact is checked against it. |
| `readiness-checklist.md` | The checks applied to a built system before it ships. |
| `LICENSES.md` | Source, licence, and retrieval date for every vendored file. |

## Licensing

Every vendored file keeps its original licence, recorded in `LICENSES.md`. The exemplars are here to be read and imitated in register and structure, not copied into project documents.
