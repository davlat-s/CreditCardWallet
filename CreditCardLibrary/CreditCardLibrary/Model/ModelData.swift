import Foundation
import Observation

@Observable class ModelData {
    // Lists
    var creditCardList: [CreditCard] = load(filename: "creditcards.json")

    var creditCardListSortedNewest: [CreditCard] {creditCardList.sorted(by: {$0.openDate > $1.openDate})}
    var creditCardListSortedOldest: [CreditCard] {creditCardList.sorted(by: {$0.openDate < $1.openDate})}
    
    var businessCardList: [CreditCard] {return creditCardListSortedNewest.filter{$0.isBusiness && !$0.isClosed}}
    var personalCardList: [CreditCard] {return creditCardListSortedNewest.filter{!$0.isBusiness && !$0.isClosed}}
    var openCardList: [CreditCard] {return creditCardListSortedNewest.filter{!$0.isClosed}}
    var closedCardList: [CreditCard] {return creditCardListSortedNewest.filter{$0.isClosed}}
    
    // Counts
    var businessCardCount: Int {businessCardList.count}
    var personalCardCount: Int {personalCardList.count}
    var closedCardCount: Int {closedCardList.count}
    var openCardCound: Int {openCardList.count}
}

