# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.5.0] - 2022-09-08
### Added
- Support for embedded liqid tags in the url field. ([#3](https://github.com/erikw/jekyll-glossary_tooltip/issues/3])

## [1.4.0] - 2021-08-18
### Changed
* Bump local ruby to 3.1.0

## [1.3.1] - 2021-08-18
### Added
- GitHub workflow to publish to GitHub Packages.

## [1.3.1] - 2021-08-18
### Fixed
- gemspec dependency range stynax.

## [1.3.0] - 2021-08-07
### Changed
- Open the souce link from a tooltip in a new tab.

## [1.2.0] - 2021-08-06
### Added
- Bottom arrow to the tooltip.
- Tooltip hover animation from invisible to visible.

### Changed
- Restyle the glossary term bottom border style and color.

## [1.1.0] - 2021-08-06
### Added
- Optional `display:` argument to set a different term display name, rather than using the term name as defined in the glossary file. Usage: `{% glossary term_name, display: Different Name To Display %}`.

## [1.0.0] - 2021-08-05
- No changes from `v0.1.0` but just bumping to final first major release version!

## [0.1.0] - 2021-08-05
- First release version. The plugin is fully working but I suspect that there might be a few point releases just to nail the release process. Once this is working, there will soon be an 1.0.0 release!
