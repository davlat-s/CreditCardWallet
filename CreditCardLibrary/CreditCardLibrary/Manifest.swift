import Foundation

struct RGBColor: Codable {
    let r: Int
    let g: Int
    let b: Int
}

struct Manifest: Codable {
    let cards: [CardEntry]
    let exportDate: String
    let exportType: String
    let exportVersion: Int
}

struct CardEntry: Codable, Identifiable {
    let id: String
    let safeName: String
    let cardFolder: String
    let primaryAccountSuffix: String
    let organizationName: String
    let description: String
    let longDescription: String
    let expiryDate: String
    let paymentType: String

    let contactWebsite: String
    let contactNumber: String

    let backgroundColor: RGBColor
    let foregroundColor: RGBColor
    let labelColor: RGBColor

    let backgroundFilenameOriginal: String
    let backgroundFilename400: String
    let backgroundFilename200: String
    let backgroundFilename75: String
    let iconFilename2x: String

    let pkpassFileName: String
}
