import SwiftUI
import Combine

class TenantsViewModel: ObservableObject {
    @Published var tenant: NewTenantModel = NewTenantModel(fullName: "", phone: "")
    
    @Published var tenants: [TenantsModel] = []
    
    
}
