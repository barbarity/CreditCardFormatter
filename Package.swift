// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "CreditCardFormatter",
    products: [
        .library(name: "CreditCardFormatter", targets: ["CreditCardFormatter"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CreditCardFormatter",
            dependencies: []),
        .testTarget(
            name: "CreditCardFormatterTests",
            dependencies: ["CreditCardFormatter"]),
    ]
)
