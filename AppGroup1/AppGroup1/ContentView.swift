//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
              
            }
            .navigationBarTitle("Cashflow")
            .navigationBarItems(trailing:
                Button(action: {
                    // Gestione azione del pulsante di ricerca
                }) {
                    Image(systemName: "magnifyingglass")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
