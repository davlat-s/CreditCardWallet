enum SideBarCategories: Hashable {
    case business
    case personal
    case all
    case closed
    case bank(Bank)
    
    var displayName: String {
        switch self {
        case .business:
            return "Business"
        case .personal:
            return "Personal"
        case .all:
            return "All Cards"
        case .closed:
            return "Closed Cards"
        case .bank(let bank):
            return bank.name
        }
    }
    
    var displayImageName: String {
        switch self {
        case .business:
            return "briefcase"
        case .personal:
            return "person"
        case .all:
            return "tray"
        case .closed:
            return "archivebox"
        case .bank:
            return "banknote"
        }
    }
    
    func sidebarFilter(_ creditCard: CreditCard) -> Bool {
        switch self {
        case .all:
            return creditCard.closed == nil
        case .personal:
            return !creditCard.isBusiness && creditCard.closed == nil
        case .business:
            return creditCard.isBusiness && creditCard.closed == nil
        case .closed:
            return creditCard.closed != nil
        case .bank(let bank):
            return creditCard.bank == bank
        }
    }
}
