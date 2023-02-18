//
//  TabBarView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Spese")
                }
            
            ListsView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Note")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                
                    
            }
            
        }
        
    }
        
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
