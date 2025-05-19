import Foundation
import Combine

// Manages opening a .walletpkg: unzips, decodes manifest.json, publishes cards and metadata.
class DocumentManager: ObservableObject {
  @Published var cards: [CardEntry] = []
  @Published var exportDate: String = ""
  @Published var exportType: String = ""
  @Published var exportVersion: Int = 0
  @Published var packageURL: URL?

  // Loads the package at the given URL
  func loadPackage(at url: URL) {
    let fm = FileManager.default
    // 1. Create a unique temp folder
    let tempDir = fm.temporaryDirectory
      .appendingPathComponent(UUID().uuidString)
    try? fm.createDirectory(at: tempDir,
                            withIntermediateDirectories: true)

    // 2. Unzip into that temp folder
    let unzip = Process()
    unzip.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
    unzip.arguments     = [url.path, "-d", tempDir.path]
    do {
      try unzip.run()
      unzip.waitUntilExit()
    } catch {
      print("Failed to unzip package:", error)
      return
    }

    // 3. Locate and decode manifest.json
    // If unzip yields a single top-level directory, look inside it; otherwise use tempDir
    let entries = (try? fm.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)) ?? []
    let containerURL: URL
    if entries.count == 1, entries[0].hasDirectoryPath {
        containerURL = entries[0]
    } else {
        containerURL = tempDir
    }
    DispatchQueue.main.async {
        self.packageURL = containerURL
    }
    let manifestURL = containerURL.appendingPathComponent("manifest.json")
    guard let data = try? Data(contentsOf: manifestURL) else {
        print("Couldn’t read manifest.json at", manifestURL.path)
        return
    }
    do {
      let decoded = try JSONDecoder().decode(Manifest.self, from: data)
      DispatchQueue.main.async {
        self.cards = decoded.cards
        self.exportDate = decoded.exportDate
        self.exportType = decoded.exportType
        self.exportVersion = decoded.exportVersion
      }
    } catch {
      print("Failed to decode manifest:", error)
    }
  }
}
