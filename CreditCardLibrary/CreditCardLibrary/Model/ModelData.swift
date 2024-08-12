import Foundation
import Observation

@Observable class ModelData {
    // Lists
    var creditCardList: [CreditCardModel] = load(filename: "creditcards.json")

    var creditCardListSortedNewest: [CreditCardModel] {creditCardList.sorted(by: {$0.openDate > $1.openDate})}
    var creditCardListSortedOldest: [CreditCardModel] {creditCardList.sorted(by: {$0.openDate < $1.openDate})}
    
    var businessCardList: [CreditCardModel] {return creditCardListSortedNewest.filter{$0.isBusiness && !$0.isClosed}}
    var personalCardList: [CreditCardModel] {return creditCardListSortedNewest.filter{!$0.isBusiness && !$0.isClosed}}
    var openCardList: [CreditCardModel] {return creditCardListSortedNewest.filter{!$0.isClosed}}
    var closedCardList: [CreditCardModel] {return creditCardListSortedNewest.filter{$0.isClosed}}
    
    // Counts
    var businessCardCount: Int {businessCardList.count}
    var personalCardCount: Int {personalCardList.count}
    var closedCardCount: Int {closedCardList.count}
    var openCardCound: Int {openCardList.count}
}

