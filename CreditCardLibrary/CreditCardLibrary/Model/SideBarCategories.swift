import Foundation

enum SideBarCategories: Int, CaseIterable, Identifiable {
    var id: Int { rawValue }
    
    case open
    case personal
    case business
    case closed
    case bank
    
    var displayName: String {
        switch self {
        case .open: return "All"
        case .personal: return "Personal"
        case .business: return "Business"
        case .closed: return "Closed"
        case .bank: return "By Bank"
        }
    }
    
    var displayImageName: String {
        switch self {
        case .open: return "creditcard"
        case .personal: return "person"
        case .business: return "briefcase"
        case .closed: return "archivebox"
        case .bank: return "building.columns"
        }
    }
    var sidebarFilter: (CreditCard) -> Bool {
        switch self {
        case .open: return { $0.closed == nil}
        case .personal: return { $0.isBusiness == false}
        case .business: return { $0.isBusiness == true}
        case .closed: return { $0.closed != nil}
        case .bank: return { $0.closed == nil} // Not used, placeholder
        }
    }
}
