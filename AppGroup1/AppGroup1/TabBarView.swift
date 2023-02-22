//
//  TabBarView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        
        TabView{
            ListsView()
                .tabItem {
                    Image(systemName: "pin")
                    Text("PinBoard")
                }
            
            ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Expenses")
                }
            
            ProfileView()
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
