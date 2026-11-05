import Foundation

struct AppItem: Identifiable, Codable {
    var id: String { bundleIdentifier }
    let name: String
    let bundleIdentifier: String
    let version: String
    let iconURL: String
    let downloadURL: String
    let localizedDescription: String?
    let developerName: String?
    let size: Int64?
}

struct AppStoreSource: Codable {
    let name: String
    let identifier: String
    let apps: [AppItem]
}
