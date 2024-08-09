import Foundation
import Observation

@Observable class ModelData {
    // Lists
    var creditCardList: [CreditCard] = load(filename: "creditcards.json")
    var businessCardList: [CreditCard] {return creditCardList.filter{$0.isBusiness && !$0.isClosed}}
    var personalCardList: [CreditCard] {return creditCardList.filter{!$0.isBusiness && !$0.isClosed}}
    var openCardList: [CreditCard] {return creditCardList.filter{!$0.isClosed}}
    var closedCardList: [CreditCard] {return creditCardList.filter{$0.isClosed}}
    
    // Counts
    var businessCardCount: Int {businessCardList.count}
    var personalCardCount: Int {personalCardList.count}
    var closedCardCount: Int {closedCardList.count}
    var openCardCound: Int {openCardList.count}
}


func load<T: Decodable>(filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Could not find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
    }
}
