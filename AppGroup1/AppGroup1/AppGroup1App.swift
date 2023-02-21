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
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataManager)
                .environmentObject(obsUser)
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

