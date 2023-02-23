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
    @StateObject var dataManagerUser = DataManagerUser()
    @StateObject var userLog = ObservableUser()
    @StateObject var dataManagerNote = DataManagerNote()
    @State var isFlagOn = false
    
    
    let persistenceController = PersistenceController.shared
    @State private var isLogged: Bool = false
    
    let defaults = UserDefaults.standard
    
    
    init()
        {
            isFlagOn = defaults.bool(forKey: "isFlagOn")
            defaults.set(self.isFlagOn, forKey: "isFlagOn")
            if !isFlagOn{
                FirebaseApp.configure()
                Auth.auth().signInAnonymously() { authResult, error in
                    if let error = error {
                        print("Error signing in anonymously: \(error.localizedDescription)")
                    } else {
                        print("Signed in anonymously with UID: \(authResult!.user.uid)")
                    }
                }
            }
            
        }
    var body: some Scene {
        WindowGroup {
        
            TabBarView(isFlagOn: $isFlagOn)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataManagerUser)
                .environmentObject(dataManagerNote)
                .environmentObject(dataManager)
                .environmentObject(userLog)
                .environmentObject(obsUser)
                
                
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

class ObservableUser: ObservableObject{
    @Published var id : String = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
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

