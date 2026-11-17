# Changelog

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
