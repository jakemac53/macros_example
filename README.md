An package to use as a starting point for trying out Dart macros.

# SDK setup

First, you need to ensure your SDK is sufficiently recent such that it supports
macros. If it isn't new enough, you will get a version solve error when running
`flutter pub get`.

We recommend using the `main` flutter channel, and running `flutter update`
often.

# Running the example

You can run the example with the flutter tool, by passing
`--enable-experiment=macros`. Due to
[#146451](https://github.com/flutter/flutter/issues/146451) only release mode
is supported. So the full command would be:

`flutter run --enable-experiment=macros --release`

You can also run/debug from your IDE using the instructions below.

# Setting up your IDE

## VS Code

You will need to set the `"dart.experimentalMacroSupport": true,` option in your
VS Code settings (it's already set in `.vscode/settings.json` for this project).

To run/debug from VS Code, you will need to add `"--enable-experiment=macros"`
to `toolArgs` in your `.vscode/launch.json` (it's already done for this
project).

To run this example, open `bin/auto_to_string.dart` and press `F5` (or click the
`Run`/`Debug` CodeLens links).

Note that support here is still very early days, so please file issues as you
find them.

## IntelliJ

Use IntelliJ 2024.1 or newer with Dart plugin version 241.16006 or newer.

To run/debug from IntelliJ, you will need to add
`--enable-experiment=macros --release` as "Additional run args" to the
"Run/Debug Configuration" for your app.
