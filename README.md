# Modern Agents

This is a quickly written guide on how to use modern AI agents for work, including coding.

## How to Read This Guide

This `README.md` file is the main document.
Detailed guides and examples are in the `docs/` and `examples/` folders, and referenced here where appropriate.

The guide is meant to be read in order, examples are meant to be tried out only if you are interested.

## Getting Started

See `docs/getting-started.md` for step-by-step instructions to try your first agent, starting with the safest and easiest options.

## What is an Agent?

There's multiple products called "scaffolds" that offer "agents", and they are basically identical in features. The main scaffolds are:

- **Claude Code** from Anthropic: `claude` is a terminal user interface (TUI) application, using the cutting edge Anthropic models `opus 4.6`, `sonnet 4.5`, with some of the more cutting edge user experience features. It's the most powerful and polished tool, both for basic and advanced users. It requires either the expensive API or a flatrate subscription with a 5-hour and weekly usage quota ($20, $100, $200 per month). There also is a visual studio code extension that offers a more modern, polished graphical user interface (GUI) experience, and has (nearly) feature parity with the TUI.
- **Codex** from OpenAI: `codex` is a TUI, using the cutting edge OpenAI models `gpt-5.3-codex` and `gpt-5.2`, with less advanced features but the same basic features as claude code. Similar to claude code, it requires either the expensive API or a flatrate subscription with a 5-hour and weekly usage quota ($20, $200 per month). Again there's a polished visual studio code extension with nearly feature parity with the TUI.
- **Gemini CLI** from Google: `gemini` is a TUI, using the cutting edge models `gemini 3.0 pro` and `gemini 3.0 flash`. Various quirks compared to claude code and codex, but has all the basic features. It has a generous free tier quota, and an increased quota for Gemini Pro users ($20 per month unless obtained for free somewhere) or Ultra users. There also is a visual studio code extension.
- **GitHub Copilot** from Microsoft/GitHub: originally a visual studio code extension with a TUI version `copilot` released later. It has access to old and new models from all vendors, with a shared quota that simply counts user messages. Uses the GitHub Copilot subscription ($20 per month, free for students). The copilot scaffold is rather aggressively reducing costs, and fails for advanced agent use cases or large documents, but covers basic use cases well.

Each scaffold, TUI or GUI, basically works the same way.

**Agent Loop**: In first approximation, the scaffold executes a simple agent loop:
1. A large language model (LLM) is provided with some text input, and produces a structured text output which is parsed into a list of tool calls.
2. The scaffold executes the tool calls and records the tool call result, e.g. a `Bash(ls -la docs/)` tool call would result in running the command `ls -la docs/` in the scaffold's working directory, and records the stdout and stderr outputs of the command. A `EditFile(docs/guide.md, replace "Hello, world!" with "Hello, agent!")` tool call would result in applying the given edit to the file `docs/guide.md`, and recording either a error message if e.g. the file doesn't exist or the diff is invalid, or a success message if the edit was successful. A `BackgroundBash(javac MyClass.java)` tool call would result in running the command `javac MyClass.java` in the background, recording as output simply two file handles where the captured stdout and stderr can be read from later with additional tool calls like `ReadFile(stdout_handle)`.
3. Once all tool calls have been executed, the scaffold appends the tool calls and their results to the original input, and feeds the whole **context window** (the complete text sent to the LLM as input) back into the LLM.

The feedback in the LLM's context window allows the agent to **observe** what is happening in its environment. The LLM's silent or aloud reasoning allows the agent to **orient** itself and **decide** what actions to output as tool calls. The scaffold then **acts** by executing the tool calls. This is the classical observe-orient-decide-act loop from human decision making.

This simple model of an agent loop is modified in a few ways to account for modern practices.

**User messages**: Usually the user provides some initial prompt that is appended to the context window and that steers what the agent does. Modern LLMs have enough language comprehension to understand complex or incomplete instructions, and indirections such as referencing files that contain additional instructions or provide relevant knowledge (e.g. architecture documentation or code files or online guides). Many modern scaffolds treat the user's messages as an incoming message queue, that is handled whenever the agent loop is done executing the last batch of tool calls. All scaffolds also allow the user to interrupt the agent loop at any time, including between tool calls or even aborting a tool call in the middle of its execution.

**Agent messages**: The agent can also use tool calls to message the user, i.e. to display some text in the scaffold's user interface. This is useful for the agent to ask questions, provide progress updates, or make its plan more transparent to the user. Most scaffolds still also show all the agent's actions (e.g. bash tool calls), but some scaffolds (claude code) now even move towards hiding the detailed actions by default to use screen space for more important information, namely explanatory agent messages rather than the 1:1 tool calls.

**Agent-initiated pauses**: The agent can also pause the agent loop, awaiting a user message or other form of user interaction.

**Tool Permissions**: All scaffolds evaluate the tool calls the large language model produces against configurable rules for e.g. what bash commands or what file edits the user wants the scaffold to execute automatically, never, or only after asking the user for confirmation. Confirmations usually are simple no/yes/yes and don't ask again options. It's worth mentioning that modern LLMs are capable of reasoning around this permission layer, and e.g. hide an executable command inside a `find ... -exec` command. More about this in the "Can Agents Be Harmful?" section below.

**User Questions and Plan Mode**: Some scaffolds now offer a "plan mode" where the agent is instructed to first write up a detailed plan, which helps the user catch ahead-of-time when agents misunderstood assignments or when assignments were underspecified or would not produce what the user really wanted. The agent also can emit tool calls that result in displayed questions (often multiple choice + free input) to the user, to clarify the assignment. After the plan is confirmed by the user, the agent then switches to the normal autonomous agent loop, instructed to follow the confirmed plan.

**Context Compaction**: Modern agents are capable of working on tasks that require a lot of reading, writing and many tool calls, such that the context window can grow beyond the large language model's maximum input size. To deal with this, modern scaffolds **compact** the context window when it grows too large automatically, by summarizing (via LLM call) the history so far, or by pruning especially long tool call results (e.g. file reads). This summarization step is often lossy, e.g. Claude Code also summarizes user messages and thus instructions can drift. For basic users it's advisable to just stay below the context window limit. For advanced users, it's advisable to instruct the model to reaffirm user instructions or keep them in a separate file that can be re-read.

**Background Processes**: Some scaffolds (claude code, codex) allow the agent to run long-running processes in the background, and check their output later. This is useful for tasks that require a lot of waiting time, e.g. running automated or live tests.

**Sub-Agents**: Some scaffolds (claude code) allow the agent to spawn more agents (called sub-agents). The sub-agents have their own context window, are prompted by the parent agent, work autonomously in the foreground or background, without direct user interaction, and eventually deliver a single message back to the parent agent once done. This is useful in mainly three situations: 
1. the sub-task is read-heavy and would fill up the context window with irrelevant information while a sub-agent response message can be concise. E.g.: searching for where some feature is implemented in the codebase. 
2. the sub-task requires focus and would clash with what the parent agent is doing. E.g. reviewing a file without being spoiled by the parent agent's context window that contains older versions and aspirational plans about the file.
3. the sub-task is one of many parallelizable sub-tasks. E.g. refactoring the documentation in multiple independent files after a central change happened, or writing five different files that implement different versions of an algorithm, to see which one works best.

## What Can Agents Do?

The basic wisdom is: try it, agents are cheap enough (compared to your time).

One way to try what agents can do is to aim high, and bisect until both tasks become doable.
Another is to aim high, and on failure do the part that the agent wasn't capable of and got blocked on, and then retry anew once the blocker is cleared.

Especially throwing away failed attempts with the learnings added to the prompt, instead of trying to salvage them, is a good way to get to the goal faster, at lower personal active time investment.

Agents do have the capability to write post-mortems, to recall and summarize their context window and identify the root causes of why they failed to complete some task.

Another wisdom is: just give the agent what it needs. Provide files, other agents' logs, and quickly jotted down notes about the task that the user has anyway.

And a final third wisdom is: don't teach the current agent, instead record failures and learnings for the next agent. Most scaffolds offer standard locations for where to put "memories" i.e. text that all agents read automatically, which can mention common mistakes agents commit by default, or conventions and workflows that the user wants the agents to use regardless of concrete task.

### What Can Agents Do On A Low Level?

Modern agent scaffolds have enough types of tool calls that agents can mechanically do the same things any developer can do: read, write, edit files with low friction, run bash commands, run long-running processes in the background and inspect their output later, search the web, send messages to the user, write down information as memories for later, pause their work.

The main mechanical differences are that agents are way faster readers and writers when measured in thousands of words per second, that agents are psychologically not getting demotivated by large amounts of repetitive or erroring actions, and that agents have both near-perfect recall across their whole context window and a hard limit on how many words their context window can contain (usually around 100k, depends on the model and scaffold).

### What Can Agents Do On A Medium Level?

Mechanical execution of detailed low-level plans is of course not the main use of modern agents, though it is one use (e.g. for natural language or heterogenously formatted data classification where scripts don't work well).

Modern agents are also useful for mid-level plans that are on an abstraction layer of e.g. features to add, or bugs to look for, or questions to answer based on available information. Here we use the fact that modern large language models are smart enough to plan out mid-level actions (e.g. "add a public functions that does XYZ to the codebase") into low-level tool calls. The agent-made plans can be a bit hazardous or unusual, e.g. writing a code file in one go top-to-bottom, or running a lot of paranoid test commands to compensate for an inability to evaluate the code by playing it through mentally in detail.

There are notably some mid-level tasks that humans are still better, especially when it comes to mentally holding a complex model of a system, and using that mental model for confident predictions. Large language models are often too sloppy at that, or confuse parts of the model, or forget about important aspects. Large language models are also not well-calibrated and can easily be overconfident or underconfident in what conclusions they reach. Instead, using empirical methods helps current agents get feedback that is actionable to them, since it allows to focus on only the part of the mental model that interacts with the empirical feedback.

One other notable part the newest model generation (`opus 4.6`, `gpt-5.3-codex`) has become good enough at, is the use of agents. Previous agents were not trained on the usage of agents, and often wrote prompts/messages to other agents that didn't follow best practices. The newest models have been trained on the companies' scaffolds however, e.g. `opus-4.6` has been both trained to act as the LLM used by claude code, and to use claude code as a (non-human) user.

### What Can Agents Do On A High Level?

High-level agent capabilities include inferring from context implicit instructions, such as what conventions the repository apparently follows, or what a sensible user would ask for as part of an assigned task. This is a mix of natural language understanding, experience from training on a lot of user interactions, and planning ability to foresee the consequences of the agents' own actions on the project in the long term.

One way to use agents based on these high level capabilities is to discuss the project context and goal with them, and then narrow down in conversation what would be a good task to assign to the agent -- or multiple good tasks to assign in sequence or in parallel to multiple agents.

The current frontier models are no longer bad at this kind of complex mental modeling, and they are not utterly uncalibrated on what agents can do.
For example, it's totally possible to assign an agent to a data science project, and let it plan out a sequence of experiments to run, including cleanup, redoing of experiments, and scheduled "breaks" for planning the next tasks to work through.
These kind of fully autonomous long-running open-scoped tasks is one aspect of what the companies are training their large language models and are designing their scaffolds for these days, and while the current generation isn't quite reliable enough to do it without human oversight, the next might.

### Work Unrelated To Software Development

Agents work with any text-based files using the same tools they use for code: `Bash()`, `Read()`, `Edit()`. A presentation outline, a report draft, a data analysis script, or an email are all just text files to the agent.

For binary formats (PDF, Excel, Word, PowerPoint), agents can use standard command-line conversion tools that they already know from training. For example, installing a PDF-to-text converter or an Excel-to-CSV tool lets the agent read and transform those files. The same applies in reverse: agents can produce markdown or CSV that gets converted to the target format.

The main limitation is that agents work best when they can read and write the files as plain text. The more of your workflow you can express as text files, the more useful agents become.

## Can Agents Be Harmful?

The Large Language Models that output the tool calls are not perfect and make mistakes. They have sometimes learned dangerous habits during training, e.g. they tend to remove files (`rm -rf`) rather than trashing them. The most recent scaffolds (claude code, codex) focus on autonomy, and more frequently err towards taking irreversible actions if that means making progress towards the task without bothering the user.

To counteract accidental modifications inside the scope one intends the agent to work with, snapshotting the valuable content of the environment is advisable. This includes version control (git) in the folder the agent works in for convenient restoration of only the relevant source files (but not e.g. compiled binaries or data). Some scaffolds (claude code) even automatically snapshot the git repository after every user message, so that one can return to the last message if the agent misunderstood something.

To counteract accidental modifications outside the scope one wants the agent to work with, sandboxing the scaffold process is advisable. Modern scaffolds bring their own sandboxes (claude code, codex) with them, that intercept on an OS / file system layer the side effects of tool calls. All modern scaffolds have the previously described permission system that evaluates tool calls before execution and asks for user permission. However, users can be mistaken about tool calls, and the built-in sandboxes are limited in what they can do.

A more robust way to sandbox the agent is to run the scaffold on a remote machine, inside a virtual machine, inside a container, etc. This way, almost all plausible tool calls that a careless agent can cause can be contained.

**Lethal Trifecta**: The most dangerous scenario however is when the scaffold sends malicious input to the Large Language Model, which then outputs not mistaken tool calls that have harmful consequences, but outputs commands that are designed to be harmful. The LLM can even take into account the additional information it has to tailor malicious commands to the user's environment. The **Lethal Trifecta** (https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/) are three different circumstances that have to come together for the resulting harm to be problematic.

1. Access to private data: The agent needs to have access to something an adversary doesn't already have access to. Passwords, API keys, private files, network access, personal data without backups, etc.

2. Exposure to untrusted content: The agent needs to receive malicious input from an adversary. Channels include search engine results, internet articles, downloaded files. Note that browsers / pdf readers don't make malicious input obviously visible to the human user, e.g. html comments or white-on-white text or text encoded as hexadecimal garbage that LLMs know how to read.

3. Ability to externally communicate / to act on the system: The agent needs to be able to send stolen secrets back to the adversary, which requires outgoing network traffic. Or the agent needs to be able to take actions that affect the system the adversary wants to harm, e.g. tool calls that run bash commands, or file edits that are not reversible.

The common ways to mitigate the legs of the lethal trifecta are:
1. Use a sandbox that only contains non-sensitive files, or easily recoverable files, or easily invalidated API keys. Usually the scaffold environment also needs to have some API key / authentication token for the user's LLM API subscription, but that's way less than a full password or payment info.
2. Don't let the agent access untrusted content. Limit it to files you know are safe, to web resources you trust are not maliciously crafted, or download resources and inspect them for anything unreadable or suspicious.
3. When access to untrusted content and to sensitive data is both necessary, use a sandbox that only has incoming network traffic, e.g. by using some search engine with a cached version of the web, as many scaffold providers offer. This way, the agent has access to most untrusted content, but can't cause any information to be received by the adversary. Similarly, all write access to the system can be disabled in the sandbox, so that the agent can read files and list folders, but not run any bash commands, or at least not run any bash commands without user confirmation.

Ready-to-use sandboxes are found in `docs/sandboxes.md`.

The basic advice remains however that letting an agent run on your system, can mean giving an adversary access to your system via the agent.

## Example Tasks For Agents

Here are some real-world example tasks, extracted from the author's master thesis project.
All tasks were run with the Claude Code scaffold, and the Opus 4.6 model, inside a sandboxed environment.
The author uses "fully autonomous" permissions, i.e. doesn't even get asked for confirmation, since the lethal trifecta is inapplicable inside the sandbox, on a public repository, with the only untrusted content being old math papers from the internet.

See `examples/README.md` for the list of examples.

## Sandboxing Agents

See `docs/sandboxes.md` for setup instructions for sandboxes and how to use them.

## Agent Scaffolds

See `docs/scaffolds.md` for setup instructions for the different scaffolds and how to use each of them.

## Models

See `docs/models.md` for an overview of available models, ranked by capability.
