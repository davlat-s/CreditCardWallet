enum SideBarCategories: Hashable {
    case business
    case personal
    case open
    case closed
    case bank(Bank)
    
    var displayName: String {
        switch self {
        case .business:
            return "Business"
        case .personal:
            return "Personal"
        case .open:
            return "Open"
        case .closed:
            return "Closed"
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
        case .open:
            return "tray"
        case .closed:
            return "archivebox"
        case .bank:
            return "banknote"
        }
    }
    
    func sidebarFilter(_ creditCard: CreditCard) -> Bool {
        switch self {
        case .open:
            return creditCard.closed == nil
        case .personal:
            return !creditCard.isBusiness
        case .business:
            return creditCard.isBusiness
        case .closed:
            return creditCard.closed != nil
        case .bank(let bank):
            return creditCard.bank == bank
        }
    }
}
