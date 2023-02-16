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
                
                ClickableHStack()
                    .padding(.horizontal, 16) // aggiungere padding ai lati dell'HStack
                    .padding(.top, 8) // aggiungere spazio sopra l'HStack
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                Text("230 €")
                    .font(.system(size: 30))
                    .bold()
                    
                Text("Balance")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 18))
                
                
                Spacer()
                    
            }
            .padding(15.0)
            
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


struct ClickableHStack: View {
    var body: some View {
        Button(action: {
            // Azione da eseguire quando l'HStack viene toccato
        }) {
            
            HStack {
                Spacer()
                Image(systemName: "person")
                Image(systemName: "person")
                Image(systemName: "person")
                Image(systemName: "person")
                Spacer()
            
            }
            .padding()
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
