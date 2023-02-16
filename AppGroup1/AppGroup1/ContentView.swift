//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//
import SwiftUI

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
                // Contenuto della vista
            }
            .navigationBarTitle("Cashflow")
            .navigationBarTitleDisplayMode(.automatic)
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.black)
            
            .navigationBarItems(trailing:
                                    Button(action: {
                // Gestione dell'azione del pulsante di ricerca
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
