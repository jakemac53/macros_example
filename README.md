An package to use as a starting point for trying out Dart macros.

# SDK setup

First, you need to ensure your SDK is compatible with this package, and also
that the versions of the various dependencies are lined up. You can use
either a released dev SDK or a local build of the SDK.

## Released dev SDK

To use a released Dev SDK, look at the `pubspec.yaml` file in this repo and
download exactly the version you see set in the environment constraint (which
should also match the ref you see in each of the dependencies). Then run a
`pub get`.

## Local SDK build

To use a local SDK, open up the `pubspec_overrides.yaml` file, uncomment all the
lines in it, and update the paths to point at your local SDK. Make sure you do
a build of your local SDK as well.

In this setup, you may find the APIs have changed and you get some errors. If so
feel free to update things, as well as the SDK versions in the `pubspec.yaml`
file, and send a PR to update. Or, file an issue on this repo.

# Running the example

You can run the example under `bin` normally on the Dart VM, by passing
`--enable-experiment=macros`. So the full command would be:

`dart --enable-experiment=macros bin/auto_to_string.dart`

# Setting up your IDE

## VsCode

You will want to be on the preview channel for the `DartCode` plugin, you can
do this by clicking the following button:

![preview button](https://github.com/jakemac53/macros_example/blob/main/images/preview_button.png)

Reload the plugin and you should be good to go!

Note that support here is still very early days, so please file issues as you
find them.

## Intellij

TODO: Add instructions once available
