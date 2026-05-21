// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "locale_plus",
  platforms: [
    .iOS("13.0")
  ],
  products: [
    .library(name: "locale-plus", targets: ["locale_plus"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "locale_plus",
      dependencies: []
    )
  ]
)
