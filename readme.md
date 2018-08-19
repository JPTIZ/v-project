𝛎-project
=========

𝛎-project is a project creation tool based on templates.

Because it runs custom shell-scripts depending on project parameters, 𝛎-project
can be used together with tools such as
[cargo](https://github.com/rust-lang/cargo) or
[poetry](https://github.com/sdispater/poetry).

Usage
-----

From 𝛎-project usage:

```text
Usage: v-project <type> <name> [kinds]
   or: v-project [--help,-h]
   or: v-project [--version,-V]

Where:
    type    Type of project (e.g. tex, py, rs). Used to fetch template.
    name    Project name.

    kinds   List of project subtypes.
            Ex: --beamer for slides when type is tex,
                --lib for libraries when type is c or c++)
```

In order to make 𝛎-project work, you need an environment variable
`VPROJECT_TEMPLATES` defining what is the templates directory.

The `type` argument will choose which template will be used.

Templates **must** contain:
    - A [files directory](/examples/tex/files/) containing the structure of the
      new project. It'll be basically copied to a new directory whose name is
      the one passed as argument to `name`.

Templates **may** contain:
    - Shell-script files for each possible subtype (`kinds` argument). These script
      files must define a `pre-commands` and a `post-commands` function. The
      basic execution flow is listed below. By default, it always tries to call
      `default` kind shell-script.
    - Any other file that may be useful for subtype shell-scripts.

How it works
------------

When called, 𝛎-project:
    1. For each subtype argument, runs it's shell-script's `pre-commands` function;
    2. Copies `${VPROJECT_TEMPLATES}/${TYPE}/files/` directory into the new
       `name` directory with `--interactive` (so you can apply to already
       created projects);
    3. For each subtype argument, runs it's shell-script's `post-commands` function.

Examples
--------

In [examples directory](/examples/) there is a LaTeX example. Assuming
`VPROJECT_TEMPLATES` is the `examples/` directory, if you run:

```bash
$ v-project tex testdir
```

It'll generate a `testdir` as follows:

```
$ tree testdir
testdir
├── configs
│   ├── packages.tex
│   ├── project.tex
│   └── user-commands.tex
└── main.tex

1 directory, 4 files
```

If you run with `--beamer`, [beamer.sh](/exampels/tex/beamer.sh)'s
`post-commands` will run, appending `user-commands.text` with:

```tex
\newcommand{\hcenter}[1]{%
    \hspace*{\fill}
    #1
    \hspace*{\fill}
}

\newcommand{\autotitle}{\secname{} --- \subsecname}
\newcommand{\innertitle}[1]{\textbf{\large {#1}}}
```

TODOs
-----

Check issues.
