# Fiqh

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbenjamincassidy%2FFiqh%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/benjamincassidy/Fiqh)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbenjamincassidy%2FFiqh%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/benjamincassidy/Fiqh)

Fiqh is a collection of useful macros for Swift.

## Macros

- `@Describe`: This macro generates a `var description: String` property on a class which returns a string
of all the properties on the class and creates an extension for the class that implements `CustomStringConvertible`.

## Trusting Macros in Xcode

Xcode requires developers to manually trust third-party macros before they can be used. This can be done in a few
way:

1. Trust the macro manually in Xcode when it shows an alert dialog with the option to trust the macro.
2. Skip the trust check for macros: `defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES`.
3. Pass the `-skipMacroValidation` flag to `xcodebuild`.

## License

This library is released under the MIT license. See [LICENSE](https://github.com/benjamincassidy/Fiqh/blob/main/LICENSE) for details.

## Copyright

© 2023 benjamin cassidy
