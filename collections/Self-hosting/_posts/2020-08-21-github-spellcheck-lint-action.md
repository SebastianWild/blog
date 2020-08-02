---
title: "Setting up Jekyll Spellcheck & Linting using GitHub Actions"
layout: single
classes: wide
excerpt: >
    Quick guide to setting up a spellcheck & MarkdownLint GitHub Actions ✅
categories:
    - Self-hosting
tags:
    - GitHub
    - GitHub Actions
    - CI/CD
    - Self-hosting
    - Jekyll
---

It's easy to make typos - even if you're proofreading. For VS Code, there are some handy spellcheck extensions - I like to use [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker), but it's good to have an additional check at the pull request step. I might be editing on a device where I do not have an integrated spell checker, for example. This is where the spellcheck action comes into play.

The same goes for maintaining good style when writing Markdown. It's super common to use Linters when writing in an actual programming language, and at least according to my own experience this isn't so common when using a markup language like Markdown. In a traditional programming language, linters are useful to enforce a consistent code style. In the case of Jekyll, it's just a small additional check to ensure that we're writing proper Markdown 😀

## Spellcheck Action

For my GitHub Spellcheck workflow, I am using [Robert Jordan's spellcheck-github-actions](https://github.com/rojopolis/spellcheck-github-actions).

### Source

You can configure your workflows in the `.github/workflows` directory in your repository. They're written in YAML. Let's take a look at the code, then break it down 📝

```yaml
# .github/workflows/check_spelling.yml

name: Spellcheck
on:
  pull_request:
    paths:
    - '**.js'
    - '**.txt'
    - '**.html'
    - '**.md'
jobs:
  spelling:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Check Spelling
      uses: rojopolis/spellcheck-github-actions@v0.5.0
```

The first few lines of the workflow specify its name and the events that trigger it:

```yaml
/// ...
# The name of your workflow. If you omit it, the file name will be used instead.
name: Spellcheck
# The name of the event that triggers the workflow.
# This can be a single event, an array, or other advanced usage (refer to the docs).
# Ex. pull_request, push
on:
  # The spellcheck workflow should trigger when a pull request is opened.
  # After all we want this to be a check/voter on if our PR can be merged.
  pull_request:
    # We restrict the running of the workflow -
    # only run when Markdown files are changed.
    paths:
    - '**.md'
/// ...
```

The next section configures the jobs & steps per job to run. Jobs run in parallel by default, and in this case we only have one.

```yaml
# A workflow can be made up of more than one job, running in parallel by default.
# In our case, we just have a spellcheck job
jobs:
  spelling:
    # The machine the job runs on. In this case, the latest version of ubuntu.
    runs-on: ubuntu-latest
    # The sequence of steps to perform.
    # A step can do anything from running commands to performing actions in your repository.
    steps:
    # Specifies the action to run as as a step.
    # This could be an action defined in your repository, from the marketplace, or even a Docker image.
    # The checkout action checks out our repository so the spellcheck can access it
    - uses: actions/checkout@v2
    # The name setting determines what the GitHub UI shows
    - name: Check Spelling
      # We use rojopolis's spellcheck action, pinned to tag 0.5.0
      uses: rojopolis/spellcheck-github-actions@v0.5.0
```

Note that above, we specify that we want to use the `spellcheck-github-actions` pinned to version `0.5.0`, rather than something like `@master` where you'd potentially get an update down the line that breaks your build. As an aside however, check out [this](https://julienrenaux.fr/2019/12/20/github-actions-security-risk/) really thought-provoking article on using other's actions with your own code (and more importantly, secrets).

However we're not done yet. The next section describes how to configure the spellcheck action.

### Configuration

Under the hood, `spelling-github-actions` uses [PySpelling](https://facelessuser.github.io/pyspelling/), which can be customized using a configuration file - typically called `.spellcheck.yml`. Notice the `.` prefix making it a hidden file. This is convenient as such a configuration file is typically "set and forget". The excellent docs can be found [here](https://facelessuser.github.io/pyspelling/configuration/).

Mine looks like this:

```yaml
matrix:
- name: Markdown
  aspell:
    lang: en
  dictionary:
    wordlists:
    - .wordlist.txt
    encoding: utf-8
  pipeline:
  - pyspelling.filters.markdown:
  - pyspelling.filters.html:
    comments: false
    ignores:
    - code
    - pre
  sources:
  - '**/*.md'
  default_encoding: utf-8
  ```

My configuration file is changed very little over the default that comes with the spellcheck action - pretty much the only thing that I've added is a custom whitelist of words. I've found that PySpelling produces a lot of false positives, especially with acronyms.

Most of the configuration is pretty self-explanatory, what's interesting though is the `pipeline` configuration. With the `pyspelling.filters.markdown` pipeline, the Markdown is converted into HTML. Subsequently the `pyspelling.filters.html` processes the HTML, filters out undesired tags, and then outputs the extracted text from the HTML tags to be spell checked.

The `sources` option allows us to filter what files we want to spellcheck. It's configured to check all Markdown files, no matter how deeply they are nested in subdirectories.

Finally, the `wordlist.txt` is simply a text file containing a list of words that will be ignored during the spellcheck process. Each word is on a new line.

{% include figure image_path="/assets/images/self-hosting/github_spellcheck_error.png" alt="Screenshot of GitHub Actions output when the spellcheck fails." caption="Spellcheck errors are reported in the 'Checks' tab." %}

## Lint Action

Markdown is awesome for being able to create formatted documents using raw text, but it does have some syntax & formatting guidelines. Much like developers have linters to enforce code style practices, Markdown has this as well. For this I make use of Nick Osborn's [github-action-markdown-cli](https://github.com/nosborn/github-action-markdown-cli). In comparison to some of the other workflows this one is quite easy to configure:

```yaml
# .github/workflows/check_spelling.yml

name: Lint
on:
  pull_request:
    paths:
    - '**.md'
jobs:
    markdownlint-cli:
        runs-on: ubuntu-latest
        steps:
        - uses: nosborn/github-action-markdown-cli@v1.1.1
          with:
            files: .
```

And that's it for this one 😀
