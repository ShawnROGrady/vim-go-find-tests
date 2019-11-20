# vim-go-find-tests
vim plugin for [go-find-tests](https://github.com/ShawnROGrady/go-find-tests), a tool which finds tests covering a specified position.

## Overview
This plugin adds the following commands:

1. `:GoFindTests` - Populates quickfix list (similar to `:vimgrep`) with tests covering the block of code under the cursor.
2. `:GoCoveringTests` - Prints the names of the tests covering the position under the cursor.

For full docucumentation see [doc/go-find-tests.txt](https://github.com/ShawnROGrady/vim-go-find-tests/blob/master/doc/go-find-tests.txt)

## Troubleshooting
Please try the following, if the problem persists feel free to open an issue or submit a pull request.
### I'm seeing an error
* Does the error start with "Error determining covering tests"?
    - do the tests pass with `-count=1` and `-race` set?
        - these flags aren't set while determining coverage but they may indicate an underlying problem
    - do the tests have any dependency on the file structure (e.g. loading a file from a relative path)?
        - this may cause issues since for performance reasons this tool first compiles a test binary instead of running `go test` directly
        - if this ends up being the issue please consider opening an issue since the tool should be able to handle this
    - do the tests rely on a connection to some external process (e.g. db, http connections)
        - by default this tool runs each test in a separate go routine for performance reasons, which may cause conflicts when establishing these connections.
        - the `-seq` flag will result in tests being ran sequentially instead

### Unexpected results (no covering tests, specific test not returned)
* do coverage visualization tools (such as `go tool cover`) mark the specified position as covered?
    - often things like brackets an parentheses won't be marked
* do the tests pass with `-count=1` and `-race` set?
    - these flags aren't set while determining coverage but they may indicate an underlying problem

## Project status
This plugin is still in "beta" and shall remain so until the first major release (v1.0.0) of the `go-find-tests` tool. 
