import Foundation
import SwiftData

@Model
final class HistoryEntry {
    @Attribute(.unique) var id: UUID

    var date: Date
    var entry: String
    
    init(id: UUID = UUID(),
         date: Date,
         entry: String) {
        self.id = id

        self.date = date
        self.entry = entry
    }
}
