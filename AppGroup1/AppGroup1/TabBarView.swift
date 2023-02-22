//
//  TabBarView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var obsUser: ObservableBool
    
    var body: some View {
        
        TabView{
            ListsView()
                .tabItem {
                    Image(systemName: "pin")
                    Text("PinBoard")
                }
                .environmentObject(obsUser)
            
            ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Expenses")
                }
                .environmentObject(obsUser)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Account")
            }
                .environmentObject(obsUser)
            
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
