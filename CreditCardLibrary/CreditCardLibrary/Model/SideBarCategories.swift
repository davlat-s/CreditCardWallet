import Foundation

enum SideBarCategories: Int, CaseIterable, Identifiable {
    var id: Int { rawValue }
    
    case open
    case personal
    case business
    case closed
    
    var displayName: String {
        switch self {
        case .open: return "Open"
        case .personal: return "Personal"
        case .business: return "Business"
        case .closed: return "Closed"
        }
    }
    
    var displayImageName: String {
        switch self {
        case .open: return "creditcard"
        case .personal: return "person"
        case .business: return "building.columns"
        case .closed: return "archivebox"
        }
    }
    var sidebarFilter: (CreditCard) -> Bool {
        switch self {
        case .open: return { $0.closed == nil}
        case .personal: return { $0.isBusiness == false}
        case .business: return { $0.isBusiness == true}
        case .closed: return { $0.closed != nil}
        }
        
    }
}
