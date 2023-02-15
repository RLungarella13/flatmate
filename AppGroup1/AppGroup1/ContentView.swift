//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(){
                HStack{
                    ForEach(0..<3){ index in
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }
                    
                }
            }
            .navigationTitle("Transactions")
            .navigationBarItems (trailing: Button(action: {/*showSearchView.toggle()*/}, label: {Image(systemName: "magnifyingglass")}))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
