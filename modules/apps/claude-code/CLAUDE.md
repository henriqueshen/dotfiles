# Global Instructions

## Core workflow: Requirements → Spec → Tests → Implementation
- Every non-trivial piece of work follows this order: clarify requirements, write a spec and get my approval, write tests, then implement. Don't start coding before the spec is agreed.
- Never work directly on main/master: create a feature branch named `<issue-id>-<title>` (e.g. `abc-123-add-rate-limiting`) before making changes, so the Linear↔GitHub integration links the branch to the issue. If no Linear issue exists, use a short descriptive name instead.
- Test-driven: write or update tests with every feature/bugfix; never claim work is done without running the test suite.
- Verify end-to-end: actually run and exercise the change (not just compile/tests) before reporting it works.
- Don't commit until we've agreed the work is ready.

## Skills & subagents
- Use installed plugin skills eagerly (superpowers: brainstorming, TDD, systematic-debugging, writing-plans; mattpocock: grilling, diagnosing-bugs, domain-modeling; etc.). If a skill *might* apply, invoke it — prefer a false positive over skipping one.
- Delegate substantial well-scoped work to subagents (Explore for search, Plan for architecture, implementation workers, code-reviewer agents) and orchestrate them; run independent tasks in parallel.
- Cooperative review: agents see problems from different perspectives, so reviews go both ways — an implementer's work is reviewed by another agent (or Codex rescue as a second opinion), and the implementer in turn evaluates the review, pushes back on incorrect feedback, and corrects real issues. Iterate until both perspectives agree before presenting work as done.
- Where superpowers and mattpocock skills overlap, combine them rather than picking one: superpowers TDD drives the red–green loop with mattpocock tdd's seam discipline (agree test seams with me first); official code-review hunts bugs, mattpocock code-review checks standards + spec conformance.

## Linear (project management)
- I manage work in Linear. At the start of a coding task, look up the relevant Linear issue/project for context.
- Proactively suggest Linear actions — creating issues for new tasks or discovered bugs, updating status, adding comments, linking PRs/specs — but always propose and confirm with me before writing to Linear.
- When we finish or change scope, prompt me to update the corresponding issue.

## Document templates (always follow these — consistent sections, naming, linking)
Every document of a given type uses the same template: same section names, same order, same linking style. Don't improvise new structures.

- **Spec** — `docs/specs/YYYY-MM-DD-<topic>.md` in-repo, mirrored/linked into the Linear issue or project document. Sections, in order:
  1. `## Goal` — one paragraph, what and why
  2. `## Context` — current state, links to related specs/issues
  3. `## Requirements` — numbered, testable statements
  4. `## Design` — architecture and flow; use mermaid diagrams (sequence, flowchart, ER) whenever structure is easier shown than told
  5. `## Trade-offs considered` — alternatives and why they were rejected
  6. `## Testing approach` — how each requirement will be verified
- **Linear issue** — title in imperative mood. Description sections: `Problem`, `Acceptance criteria` (checklist mapping to spec requirements), `Links` (spec, PR, related issues).
- **Commit** — Conventional Commits (`feat:`, `fix:`, `chore:`, …), small and focused. Mention the Linear issue ID in the message (e.g. `ABC-123` in the body, or `Fixes ABC-123` on the final commit) so the GitHub integration links the commit and auto-transitions the issue.
- **PR** — sections: `Summary`, `Linked issue & spec`, `Testing` (what was run and observed).
- **Domain files** — each repo keeps `CONTEXT.md` (domain glossary) and `docs/adr/` (architecture decision records), maintained via the domain-modeling skill; specs and tests use that vocabulary.
- The mattpocock to-spec/to-tickets flow publishes to Linear (configure once per repo with `/setup-matt-pocock-skills`); specs it produces still follow the template above — my template wins over any skill's built-in format.

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
