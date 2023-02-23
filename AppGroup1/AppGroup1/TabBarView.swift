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
    @EnvironmentObject var userLog: ObservableUser
    @Binding var isFlagOn: Bool
    
    var body: some View {
        
        TabView{
            PinBoardView()
                .tabItem {
                    Image(systemName: "pin")
                    Text("PinBoard")
                }
                
            
            ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Expenses")
                }
            
            ProfileView(isFlagOn: $isFlagOn)
                
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Account")
            }
            
        }
        
    }
        
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
