# Changelog

## [0.4.1](https://github.com/elelem-sh/shell/compare/v0.4.0...v0.4.1) (2026-11-24)


### Bug Fixes

* install the command as elelem-shell and leave elelem to the core gem ([5f60579](https://github.com/elelem-sh/shell/commit/5f6057954bd3dc7581fca28c76f5c04379d71d33))

## [0.4.0](https://github.com/elelem-sh/shell/compare/v0.3.0...v0.4.0) (2026-11-24)


### ⚠ BREAKING CHANGES

* require elelem 0.17 and drop the ask and help subcommands from the specs

### Bug Fixes

* require elelem 0.17 and drop the ask and help subcommands from the specs ([5dc2927](https://github.com/elelem-sh/shell/commit/5dc2927b77ff7bf67ca4c4c175813099c821c797))

## [0.3.0](https://github.com/elelem-sh/shell/compare/v0.2.1...v0.3.0) (2026-11-20)


### Features

* detect the openai provider when OPENAI_API_KEY_COMMAND is set ([783dcd2](https://github.com/elelem-sh/shell/commit/783dcd2c1f5eb7a0b451dc48740586ee85c26cd7))


### Bug Fixes

* require elelem-openai 0.5 for OPENAI_API_KEY_COMMAND ([08e56b7](https://github.com/elelem-sh/shell/commit/08e56b77ef7dbcdd7f58b69cb33335df9c10ef23))

## [0.2.1](https://github.com/elelem-sh/shell/compare/v0.2.0...v0.2.1) (2026-11-17)


### Bug Fixes

* detect a hosted provider only when its model is set too, and treat a blank ELELEM_GGUF_MODEL as unset ([3676ffa](https://github.com/elelem-sh/shell/commit/3676ffa00477fcb21105c2d6b7c8b584350f4a3c))

## [0.2.0](https://github.com/elelem-sh/shell/compare/v0.1.0...v0.2.0) (2026-11-17)


### Features

* default to the provider whose standard API key is set, then a local llama model, then ollama, then demo ([d99680f](https://github.com/elelem-sh/shell/commit/d99680fff2b1f4a7efff62543b50d9aaf2e1ffdb))

## 0.1.0 (2026-11-16)


### Features

* elelem-shell command runs elelem with every bundled plugin loaded ([ec6af32](https://github.com/elelem-sh/shell/commit/ec6af32d00072079ada8d2f39bfdfd24e83f126f))
* elelem-shell installs elelem with tools, mcp, skills and the pure-Ruby providers ([a3da3ed](https://github.com/elelem-sh/shell/commit/a3da3ed389d76dd42f94bf7a45d1155167247318))


### Bug Fixes

* require elelem 0.14 and the latest released tools and anthropic ([780631b](https://github.com/elelem-sh/shell/commit/780631b8f1a7e9aeb0415cc8a5b5f3701c00455d))
