//
//  TabBarView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject var logInState = LogInState()
    
    var body: some View {
        
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Expenses")
                }
            
            ListsView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Notes")
                }
            
            ProfileView()
                .environmentObject(logInState)
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Account")
                        
                    
            }
            
        }
//        .fullScreenCover(isPresented: $logInState.isObserving){
//            HomeView()
//                .environmentObject(logInState)
//        }
        
    }
        
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

class LogInState: ObservableObject {
    @Published var isObserving: Bool = true
}
