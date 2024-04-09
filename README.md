An package to use as a starting point for trying out Dart macros.

# SDK setup

First, you need to ensure your SDK is sufficiently recent such that it supports
macros. If it isn't new enough, you will get a version solve error when running
`dart pub get`.

You can use either a very recently released dev SDK or a local build of the SDK.

## Hacking on package:_macros

As long as you don't change any version numbers, you can hack on the `_macros`
package in the SDK, do normal builds, and use that custom build SDK just as  you
normally would.

## Hacking on package:macros

If you need to alter the published `macros` package, you will want to add a
dependency override on it, to point at `pkg/macros` in your local SDK checkout.

The easiest way to do this is uncommenting the lines in the
`pubspec_overrides.yaml` file, and updating the path to point to your SDK
checkout

# Running the example

You can run the example under `bin` normally on the Dart VM, by passing
`--enable-experiment=macros`. So the full command would be:

`dart --enable-experiment=macros bin/auto_to_string.dart`

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

## Intellij

Use IntelliJ 2024.1 or newer with Dart plugin version 241.16006 or newer.

To run/debug from IntelliJ, you will need to add
`--enable-experiment=macros --release` as "Additional run args" to the
"Run/Debug Configuration" for your app.
