enum SideBarCategories: Hashable {
    case business
    case personal
    case all
    case closed
    case charts
    
    var displayName: String {
        switch self {
        case .business: return "Business"
        case .personal: return "Personal"
        case .all: return "All Cards"
        case .closed: return "Closed Cards"
        case .charts: return "Charts"
        }
    }
    
    var order: Int {
        switch self {
            
        case .all : return 1
        case .business: return 3
        case .personal: return 2
        case .closed: return 4
        case .charts: return 5
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
        case .charts:
            return "chart.line.uptrend.xyaxis"
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
        case .charts:
            return false
        }
    }
}
