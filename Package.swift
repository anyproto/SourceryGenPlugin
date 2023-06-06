// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "SourceryGenPlugin",
  products: [
    .plugin(name: "SourceryGenPlugin", targets: ["SourceryGenPlugin"])
  ],
  dependencies: [],
  targets: [
    .plugin(
      name: "SourceryGenPlugin",
      capability: .buildTool(),
      dependencies: ["sourcery"]
    ),
    .binaryTarget(
      name: "sourcery",
      url: "https://github.com/anyproto/SourceryGenPlugin/releases/download/1.9.2/sourcery-1.9.2.artifactbundle.zip",
      checksum: "f176e608354386fc8622f343ffd4ebed09cf8f0ba175052904f86c2c988c6fab"
    )
  ]
)
