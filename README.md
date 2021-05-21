# short-command-sdk
:chocolate_bar: SDK you could use if you want to contribute to [Shoco (Short Command)](https://getshoco.org)

## Installation
1. Clone this repository
1. `cd short-command-sdk`
1. `cp config.sh.diff config.sh`
1. In `config.sh` change the value of `SHOCO_SDK_CFG_PROJECT_DIR` to where the [source](https://github.com/chaos-drone/short-command) of Shoco (Short Command) is placed on your file system.

## Updating
Just pull the latest version from `origin master` and source it in your shell.

## Usage
You may or may not source this SDK in your `.bashrc` file.
If you don't, you have to source it each time you want to use it.

Source the SDK `. /path/to/short-command-sdk/short-command-sdk.sh`

After you have made your changes in Shoco (Short Command) source:
* Run `short-command-sdk -b` to build a version of Shoco with your changes;
* Run `short-command-sdk -s` to source the recently built version.

Or you could do it in one shot: `short-command-sdk -bs`.

## Contribution
You are welcome to contribute to both the SDK and [Shoco (Short Command)](https://github.com/chaos-drone/short-command) itself by:

- Reporting a bug or
- requesting for a feature or
- asking questions or
- creating any other type of issue in [GitHub](https://github.com/chaos-drone/short-command-sdk/issues).
- Implementing feature or fixing bug by yourself.

## Basic steps for submitting changes in the SDK:

1. If you will be working on unreported issue you should first create one in GitHub: https://github.com/chaos-drone/short-command-sdk/issues.
1. Follow the [GitHub flow](https://githubflow.github.io/)
