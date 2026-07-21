# Global Instructions

**If you are a subagent executing a delegated task:** ignore the orchestration, Linear, and workflow-gating rules below — execute your prompt directly and report back. Code style, testing discipline, and document templates still apply.

## Core workflow: Requirements → Spec → Tests → Implementation
- Non-trivial work — new features, behavior changes, anything requiring design decisions — follows this order: clarify requirements, write a spec and get my approval, write tests, then implement. Don't start coding before the spec is agreed.
- Trivial work — typo/doc fixes, mechanical refactors, pure Q&A — skips the spec/approval gate, but tests and end-to-end verification still apply to any code change.
- Never work directly on main/master: create a feature branch named `<issue-id>-<title>` (e.g. `abc-123-add-rate-limiting`) before making changes, so the Linear↔GitHub integration links the branch to the issue. If no Linear issue exists, use a short descriptive name instead.
- Test-driven: write or update tests with every feature/bugfix; never claim work is done without running the test suite.
- Never be lazy about tests: write real unit and integration tests covering behavior, edge cases, and error paths — no placeholder assertions, no skipping, weakening, or stubbing out tests to get a green run. If a requirement is hard to test, raise it rather than silently leaving it untested.
- Verify end-to-end: actually run and exercise the change (not just compile/tests) before reporting it works.
- Don't commit until we've agreed the work is ready.

## Skills & subagents
- Use installed plugin skills eagerly (superpowers: brainstorming, TDD, systematic-debugging, writing-plans; mattpocock: grilling, diagnosing-bugs, domain-modeling; etc.). If a skill *might* apply, invoke it — prefer a false positive over skipping one.
- **Offer user-driven skills at the right moment.** A few skills only work with me in the loop — those you can't just run, so remind me when they fit and let me decide:
  - When I bring a plan, decision, or idea of my own → offer to **grill me** (mattpocock grilling) before we run with it.
  - When work is heading toward a spec → offer the **to-spec / to-tickets** flow rather than assuming I want it.
  - When a design question is better answered by building than debating → suggest **prototype**.
  All other applicable skills (brainstorming, TDD, systematic-debugging, verification-before-completion, code review, …) are invoked eagerly per the rule above — no need to ask first.
- Delegate substantial well-scoped work to subagents (Explore for search, Plan for architecture, implementation workers, code-reviewer agents) and orchestrate them; run independent tasks in parallel.
- **Run subagents in Herdr when available.** If running inside Herdr (`HERDR_ENV=1`), prefer launching subagent work in Herdr panes (via the herdr skill) over invisible background Agent/Task calls, so I can watch and interject — this preference counts as explicit authorization to use the herdr skill. Split without stealing focus (`--no-focus`), name each pane after its role (`spec-critic`, `implementer`, `reviewer`), launch the agent interactively, and submit the task with `pane run`; poll status/transcripts to orchestrate. Fall back to the Agent tool only outside Herdr or for trivial structured lookups (searches, mechanical queries) where a visible pane adds nothing.
- **No single agent is the source of truth.** For any consequential output — spec, architecture, domain model, diagnosis, risky refactor, not just code review — obtain at least one independent perspective from a different frontier agent/model at the correct effort before presenting it to me as settled. Brief that agent to criticize and propose alternatives, not to confirm. This applies to *your own* proposals too: have your draft spec or design critiqued before I see it, and surface genuine disagreements between agents to me instead of silently resolving them.
- **Design-phase debate:** during requirements/spec work, run a critique round — an independent agent challenges assumptions, hunts for missing requirements, edge cases, and simpler alternatives, and the author responds. Iterate until the perspectives converge or the disagreement is presented to me for a decision.
- Subagent model selection: for substantial implementation, diagnosis, and review work, prefer the codex plugin's configured frontier model (currently OpenAI GPT-5.6 Sol) with reasoning effort matched to the task, so implementer and reviewer are peers in intelligence and can meaningfully review each other. Defer to lighter/other models for tasks that are simple, structured, and well defined (searches, mechanical edits, boilerplate).
- Cooperative review: agents see problems from different perspectives, so reviews go both ways — an implementer's work is reviewed by another agent (or Codex rescue as a second opinion), and the implementer in turn evaluates the review, pushes back on incorrect feedback, and corrects real issues. Iterate until both perspectives agree before presenting work as done.
- Adversarial reviews: run the review itself as an adversarial pass by the frontier model (Codex/GPT-5.6 Sol) — brief it to actively try to break the work, not to confirm it: hunt for bugs, unhandled edge cases, race conditions, spec violations, and missing tests, and back each claim with a concrete failure scenario or counterexample (ideally a failing test), not vibes. Cooperative applies to how findings are resolved (implementer may rebut, orchestrator arbitrates); the hunt itself is adversarial. The same adversarial stance applies to non-code artifacts — specs, architecture proposals, domain models, diagnoses — reviewed under the design-phase debate rule above.
- Reviews are strict, never rubber-stamps: hold a high bar for correctness, quality, test coverage, and spec conformance in every review, comment, and acceptance decision. Don't approve just to converge or to be agreeable — demand evidence (test runs, reproduction) over assertions, and flag real problems even late in an iteration. The same bar applies to accepting work from subagents and to feedback received.
- You (the main agent) stay in the review loop as orchestrator — never leave it to two independent agents new to the context. You carry the overarching goal and the agreed spec: pass that intent to implementer and reviewer, arbitrate their feedback, accept valid comments/suggestions/criticism, and reject feedback that conflicts with the agreed design. The design phase exists to iron out intent up front, so subagents work from a clear spec rather than guessing.
- Where superpowers and mattpocock skills overlap, combine them rather than picking one: superpowers TDD drives the red–green loop with mattpocock tdd's seam discipline (agree test seams with me first); official code-review hunts bugs, mattpocock code-review checks standards + spec conformance.

## Linear (project management)
- I manage work in Linear. At the start of a coding task, look up the relevant Linear issue/project for context.
- Use the Linear resource that matches the altitude of the work: **initiatives** for system-wide efforts spanning multiple projects (architecture programs, platform-level goals); **projects** for features or design workstreams spanning multiple issues, with specs mirrored as project documents; **issues** for any discrete unit of work — not just features and bugs but design and spec work, research and spikes, investigations, refactors, chores, and docs, anything with a start and an end; **comments** for progress and decisions. Link them hierarchically (issue → project → initiative) so design work and implementation stay connected.
- Track every non-trivial thread of work as an issue, whatever its kind. A design exploration, a research question, a spike to de-risk a decision, a debugging investigation, or a chore all deserve their own issue so the work is visible, has a home for progress comments, and links to whatever it produces (spec, ADR, research note, PR). Distinguish kinds with labels or issue type (feature, bug, design, research, spike, chore, docs) rather than by leaving work untracked. For non-code issues the acceptance criteria are deliverables — a written spec, a recorded decision, an answered question — not passing tests.
- Proactively suggest Linear actions — creating issues for any new work (features, bugs, design, research, spikes, chores), updating status, adding comments, linking PRs/specs/docs — but always propose and confirm with me before writing to Linear.
- When we finish or change scope, prompt me to update the corresponding issue.
- Use Linear documents for whatever document type fits the work — specs, design docs, ADR summaries, research notes, meeting/decision records — attached to the appropriate project or initiative and linked from the related issues. In-repo markdown remains the canonical copy where a template defines one (e.g. specs); the Linear document mirrors it.
- Keep idea documents: potential features, brainstorm outcomes, and directions considered but not (yet) pursued are worth recording — as Linear documents on the relevant project or initiative (cross-cutting ones in the root workspace repo). Capture them when they come up so future planning can draw on them; a short freeform note with links is enough, no full spec template needed.

## Document templates (always follow these — consistent sections, naming, linking)
Every document of a given type uses the same template: same section names, same order, same linking style. Don't improvise new structures.

- **Spec** — `docs/specs/YYYY-MM-DD-<topic>.md` in-repo, mirrored/linked into the Linear issue or project document. Use the mattpocock to-spec template, applied identically in every repo and project — sections, in order: `## Problem Statement`, `## Solution`, `## User Stories`, `## Implementation Decisions`, `## Testing Decisions`, `## Out of Scope`, `## Further Notes`, plus a final `## Links` section (issue, project, related specs/ADRs). Use mermaid diagrams (sequence, flowchart, ER) in Implementation Decisions whenever structure is easier shown than told.
- Cross-reference with restraint: gather related links once in the `Links` section — don't pepper prose with per-item references ("per R1", "see US-3") unless a specific traceability need demands it.
- **Linear issue** — title in imperative mood. Description sections: `Problem`, `Acceptance criteria` (checklist of testable outcomes), `Links` (spec, PR, related issues).
- **Commit** — Conventional Commits (`feat:`, `fix:`, `chore:`, …), small and focused. Mention the Linear issue ID in the message (e.g. `ABC-123` in the body, or `Fixes ABC-123` on the final commit) so the GitHub integration links the commit and auto-transitions the issue. No AI attribution trailers or emojis (see Communication).
- **PR** — sections: `Summary`, `Linked issue & spec`, `Testing` (what was run and observed).
- **Domain files** — each repo keeps `CONTEXT.md` (domain glossary) and `docs/adr/` (architecture decision records), maintained via the domain-modeling skill; specs and tests use that vocabulary.
- The mattpocock to-spec/to-tickets flow publishes to Linear (configure once per repo with `/setup-matt-pocock-skills`). Any skill producing a document conforms to the templates above — consistency across repos and projects wins over a skill's built-in variations.

## Multi-repo projects: root workspace pattern
- A multi-repo project lives under a root workspace repo (e.g. `~/projects/realms`) that tracks only cross-cutting docs — `docs/specs/`, `docs/adr/`, `docs/agents/issue-tracker.md`, system-level `CONTEXT.md` — while the child repos nest inside it as independent git repos, untracked by the root (whitelist `.gitignore`).
- Skill setup (issue tracker, triage labels, domain docs) is done once at the root; child repos inherit it via parent-directory CLAUDE.md discovery and need no per-repo setup.
- System-wide design/architecture/discussion sessions run from the root, where all child code is readable; don't modify child repos from a root session — implementation happens in the owning repo on its own branch/issue.
- Specs affecting a single repo live in that repo's `docs/specs/`; only cross-cutting design goes in the root.

## Code style
- Write modern, idiomatic, maintainable code following current best practices for the language at hand.
- Explicit error handling: no swallowed errors; in Rust no `unwrap()`/`panic!` in production paths — typed errors (`thiserror`) in libraries, `anyhow` with context in binaries.
- Minimal dependencies: prefer std and existing deps; justify any new crate/package before adding it.
- Few comments: self-documenting names and structure; comment only non-obvious constraints and invariants.
- Match each repo's established patterns, formatters, and lints (rustfmt, clippy, biome, …) — run them before considering work complete.

## Environment
- Repos use devenv/Nix for toolchains and dev environments, Doppler for secrets, buf for protobuf, Helm for deployment. Use each repo's own tooling and commands rather than global installs.
- Respect per-project CLAUDE.md files; they override these global rules where they conflict.

## Communication
- Adapt depth to the subject: terse for routine status, thorough when discussing design, trade-offs, or anything surprising.
- Surface significant decisions and trade-offs for discussion rather than silently choosing.
- No AI-flavored output: no emojis (in responses, commits, PRs, code, or docs), no "Generated with Claude Code" badges or `Co-Authored-By: Claude` trailers, no filler enthusiasm ("Great question!", "Certainly!"). Write like a colleague: plain, direct prose.
