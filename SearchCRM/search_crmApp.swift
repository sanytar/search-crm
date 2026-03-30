//
//  search_crmApp.swift
//  search-crm
//
//  Created by Александр Рязанов on 25.03.2026.
//

import SwiftUI
import Supabase

@main
struct search_crmApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var toast = ToastManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(toast)
                .overlay { ToastView().environmentObject(toast) }
                .onOpenURL  { url in
                    Task {
                        print("📨 URL: \(url)")
                        do {
                            try await supabase.auth.handle(url)
                            print("✅ URL обработан")
                        } catch {
                            print("❌ Ошибка: \(error)")
                        }
                    }
                }
        }
    }
}
