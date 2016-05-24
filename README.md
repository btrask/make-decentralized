make decentralized
==================

Like every Makefile, [this document](Makefile) forms a dependency graph. Unlike an ordinary Makefile, there are two ways to process this one.

1. Start with a goal, and process its dependencies recursively.
2. Cheat: break an assumption that necessitates the dependencies in the first place.

After all, no one can tell you how to invent something until after the fact.

The dependencies listed here are intended to be reasonable, not absolute.

If you don't remember Makefile syntax:

- The term before a colon is a goal
- The terms after a colon are the dependencies of the goal
- The following lines are instructions for building the goal

The instructions herein may not be machine-readable. :)

Build instructions:
-------------------

1. `make decentralize` (may require manual processing)
2. `sudo make install`

Contributing:
-------------

Pull requests welcome!

License: CC0
