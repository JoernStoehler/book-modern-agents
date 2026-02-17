# Example Prompts For Agents

Example prompts adapted from real agent usage, translated to Java-centric scenarios. Try these or similar prompts to get a feel for what agents can do.

---

> Write a JUnit test for the `DateParser.parse()` method. Cover the happy path and the edge cases you can find by reading the implementation.

> Explain what `TransactionProcessor.java` does. I inherited this codebase and don't understand the retry logic.

> Bug report: the batch job sometimes processes the same record twice.

> Look up the current best practices for Java 21 virtual threads. Create a summary document with the key points and links to official sources.

> Consider my conference talk outline. Anything you'd change? Are there gaps in the argument? Is the structure clear? Ask me anything.

> Continue where the last agent left off. I think it was working on adding validation to the input forms but didn't finish.

> Which reports in the `output/` folder are older than their source data? Regenerate any that are out of date.

> Plan with me how to migrate from `javax.*` to `jakarta.*` in this project. Before proposing changes, research:
> 1. Look up the official migration guide
> 2. Check what dependencies we use that are affected
> Then discuss what needs to change and in what order.

> Refactor: all database access currently uses raw JDBC. Migrate to prepared statements throughout.
> Current state: [list of files and methods that use raw SQL strings]
> Changes needed: [for each method, what the prepared statement version should look like]

> I want to switch from tabs to spaces in the whole project and enforce it going forward.
> Before you start: push back if this plan does not look straightforwardly good to you. Discuss with me the impact on git blame, merge conflicts with open branches, and anything else I might be overlooking.

> Set up a new Maven multi-module project. I need:
> - `core/` with the domain model
> - `service/` with the business logic, depends on core
> - `cli/` with a command-line interface, depends on service
> Wire up the parent POM, make sure `mvn clean install` works.

> Go through every Java file in `com.example.billing` and review for: unused imports, overly complex methods (>30 lines), missing null checks on public API boundaries, and inconsistent naming. Report findings per file.

> Review this project as if you were a new team member. What's confusing? What's undocumented? What conventions seem inconsistent? What would you want to know that isn't written down anywhere?
