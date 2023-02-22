//
//  AppGroup1App.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI
import Firebase

@main
struct AppGroup1App: App {
    @StateObject private var dataController = DataController()
    @StateObject var dataManager = DataManager()
    @StateObject var obsUser = ObservableBool()
    let persistenceController = PersistenceController.shared
    
    init()
        {
            FirebaseApp.configure()
            Auth.auth().signInAnonymously() { authResult, error in
                if let error = error {
                    print("Error signing in anonymously: \(error.localizedDescription)")
                } else {
                    print("Signed in anonymously with UID: \(authResult!.user.uid)")
                }
            }
        }
    var body: some Scene {
        WindowGroup {
        
            TabBarView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataManager)
                .environmentObject(obsUser)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//           HomeView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environmentObject(dataManager)
//                .environmentObject(obsUser)
        }
    }
}

class ObservableBool: ObservableObject{
    @Published var isLoggedIn = false
}

//import SwiftUI
//import FirebaseCore
//content_copy
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//content_copy
//
//    return true
//  }
//}
//
//@main
//struct YourApp: App {
//  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//content_copy
//
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        ContentView()
//      }
//    }
//  }
//}

