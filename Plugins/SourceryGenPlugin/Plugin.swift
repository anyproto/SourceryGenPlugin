import Foundation
import PackagePlugin

@main
struct SourceryGenPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
    let fileManager = FileManager.default

    let configurations: [Path] = [context.package.directory, target.directory]
      .map { $0.appending("sourcery.yml") }
      .filter { fileManager.fileExists(atPath: $0.string) }

    guard validate(configurations: configurations, target: target) else {
      return []
    }

    fileManager.forceClean(directory: context.pluginWorkDirectory)

    return try configurations.map { configuration in
      try .swiftgen(using: configuration, context: context, target: target)
    }
  }
}

// MARK: - Helpers

private extension SourceryGenPlugin {
  /// Validate the given list of configurations
  func validate(configurations: [Path], target: Target) -> Bool {
    guard !configurations.isEmpty else {
      Diagnostics.error("""
      No SourceryGen configurations found for target \(target.name). If you would like to generate sources for this \
      target include a `sourcery.yml` in the target's source directory, or include a shared `sourcery.yml` at the \
      package's root.
      """)
      return false
    }

    return true
  }
}

private extension Command {
  static func swiftgen(using configuration: Path, context: PluginContext, target: Target) throws -> Command {
    .prebuildCommand(
      displayName: "SourceryGen BuildTool Plugin",
      executable: try context.tool(named: "sourcery").path,
      arguments: [
        "--config",
        configuration,
        "--cacheBasePath",
        context.pluginWorkDirectory.string
      ],
      environment: [
          "DERIVED_SOURCES_DIR": context.pluginWorkDirectory,
      ],
      outputFilesDirectory: context.pluginWorkDirectory
    )
  }
}

private extension FileManager {
  /// Re-create the given directory
  func forceClean(directory: Path) {
    try? removeItem(atPath: directory.string)
    try? createDirectory(atPath: directory.string, withIntermediateDirectories: false)
  }
}
