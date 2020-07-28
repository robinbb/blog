---
title: "Test-Driven Development of Dev Environments"
date: "2020-07-27"
draft: false
---

This post shows how to create a `direnv`-based dev environment using
test-driven development.

<!--more-->

First, [install `direnv`](https://direnv.net/#basic-installation) if it is not
already installed.

This will be the only prerequisite that we expect developers to have.

Next, we create the `.envrc` file in the root of the repository:

```shell
# .envrc

# Tests

set -e
exit 1
```

If `direnv` is correctly installed and configured (did you remember to
[configure the hook](https://direnv.net/docs/hook.html)?), then upon creation
of this file, you will get an error message:

```
direnv: error /home/robinbb/repos/robinbb/robinbb.github.io/.envrc is blocked. Run `direnv allow` to approve its content
```

This is a normal part of the direnv flow.

Before anything else, verify that `.envrc` is a valid Bash script which fails:

```shell
$ bash .envrc

$ echo $?
1
```

Recall the "red, green, refactor" mantra of test-driven development. With TDD,
it is important to start with a failing test. We have that, now. We are "red".

Since we are creating a test for a development environment, we want a test that
passes only when the correct prerequisite programs are installed.

I want to use [Hugo](https://gohugo.io) in the development environment. When
correctly configured, `hugo version` should return success. The new `.envrc` file is:

```shell
# .envrc

# Tests

set -e

hugo version
```

I ignore the error from direnv, and run:

```shell
$ bash .envrc
.envrc: line 7: hugo: command not found
```

So, `hugo` is not installed (or not on my `PATH`).

Here is the part of the test driven development where we make the test go green.

I am going to use Nix to satisfy the dependencies. I create a `default.nix` file in the root of the repo:

```nix
{ pkgs ? import <nixpkgs> {}
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    hugo
  ];
}
```

Then, I add a `use nix` line to `.envrc`. This is taking advantage of a
direnv-supplied Bash function that knows what to do with a `default.nix` file. The new `.envrc` is:

```shell
# .envrc

# Config

use nix

# Tests

set -e

hugo version
```

Now, upon my first shell prompt after saving the new `.envrc` file, I get:

```shell
direnv: loading ~/repos/robinbb/robinbb.github.io/.envrc
Hugo Static Site Generator v0.64.0/extended linux/amd64 BuildDate: unknown
direnv: export +AR +AS +CC +CONFIG_SHELL +CXX +HOST_PATH +IN_NIX_SHELL +LD +NIX_BINTOOLS +NIX_BINTOOLS_WRAPPER_x86_64_unknown_linux_gnu_TARGET_HOST +NIX_BUILD_CORES +NIX_BUILD_TOP +NIX_CC +NIX_CC_WRAPPER_x86_64_unknown_linux_gnu_TARGET_HOST +NIX_ENFORCE_NO_NATIVE +NIX_HARDENING_ENABLE +NIX_INDENT_MAKE +NIX_LDFLAGS +NIX_STORE +NM +OBJCOPY +OBJDUMP +RANLIB +READELF +SIZE +SOURCE_DATE_EPOCH +STRINGS +STRIP +TEMP +TEMPDIR +TMP +TMPDIR +buildInputs +builder +configureFlags +depsBuildBuild +depsBuildBuildPropagated +depsBuildTarget +depsBuildTargetPropagated +depsHostHost +depsHostHostPropagated +depsTargetTarget +depsTargetTargetPropagated +doCheck +doInstallCheck +name +nativeBuildInputs +nobuildPhase +out +outputs +patches +phases +propagatedBuildInputs +propagatedNativeBuildInputs +shell +shellHook +stdenv +strictDeps +system ~PATH
```

Seeing this at the prompt may be worrisome to developers, so I would like to
quiet the message from `hugo version`. I also would like to ensure that the
version ("v0.64.0") is the correct one. I can achieve both of these with
`grep`. 

The final `.envrc`, that both produces the dev environment and tests the dev environment, is:

```shell
# .envrc

# Config

use nix --pure

# Tests

set -euo pipefail

# Ensure `grep` is present.

command -v grep > /dev/null

HUGO_VERSION="v0.64.0"
hugo version | grep "Hugo Static Site Generator $HUGO_VERSION" >/dev/null
```
