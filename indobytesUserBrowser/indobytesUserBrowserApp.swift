//
//  indobytesUserBrowserApp.swift
//  indobytesUserBrowser
//
//  Created by bm yanti on 25/08/24.
//

import SwiftUI

@main
struct indobytesUserBrowserApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            UserListView(viewModel: UserListViewModel())
        }
    }
}
