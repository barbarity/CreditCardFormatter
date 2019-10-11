# CreditCardFormatter

A library for validating and formatting credit cards written in Swift.

## Features
- [X] Credit card identifier.
- [X] Credit card formatter based on the type of credit card.
- [X] Credit card number validator.
- [X] All major credit card brands available.
- [X] Possibility to add custom validators and formatters.

## Requirements
- iOS 10.0+
- Xcode 10.2+
- Swift 5+

## Installation
#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `CreditCardFormatter` by adding it to your `Podfile`:

```ruby
pod 'CreditCardFormatter', '~> 0.1.0'
```

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/CreditCardFormatter.framework` into your Xcode project.

```
github "barbarity/CreditCardFormatter", "0.1.0"
```

#### Swift Package Manager
Set up your `Package.swift` and add  `CreditCardFormatter` to the dependencies value.

```swift
dependencies: [
    .package(url: "https://github.com/barbarity/CreditCardFormatter.git", from: "0.1.0")
]
```

#### Manually
TBD

## Usage
TBD

## Contribute
- If you **have a feature request** or **found a bug**, open an issue here on Github and follow the instructions.
- If you **would like to contribute**, feel free to open a pull request to this repository.

## License
CreditCardFormatter is released under the MIT License. [See LICENSE](https://github.com/barbarity/CreditCardFormatter/blob/master/LICENSE) for details.
