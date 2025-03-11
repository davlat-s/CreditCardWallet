import Foundation
import SwiftData

@Model
final class HistoryEntry {
    var date: Date
    var entry: String
    
    init(date: Date, entry: String) {
        self.date = date
        self.entry = entry
    }
}
