//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddTransaction = false
    var body: some View {
        NavigationView {
            
            VStack {
                Text("230 €")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(Color.primary)
                Text("Balance")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 18))
                ClickableHStack()
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                TransactionSection()
                
                Spacer()
                
                TabView {
                    
                    Text("Note")
                        .tabItem {
                            Image(systemName: "note.text")
                            Text("Note")
                        }
                    Text("Spese")
                        .tabItem {
                            Image(systemName: "dollarsign.circle")
                            Text("Spese")
                        }
                    Text("Profilo")
                        .tabItem {
                            Image(systemName: "person.circle")
                            Text("Profilo")
                            
                        }}
                

               
                
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
            .overlay(
                Button(action: {
                    self.showAddTransaction = true
                    //da aggiungere l'azione
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding(16)
                        .shadow(radius: 4)
                        .padding(.leading, 16)
                    
                    
                }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16),
                alignment: .bottomTrailing
            )
            
            .sheet(isPresented: $showAddTransaction) {
                // Aggiungi la vista per aggiungere una transazione
            }
            
            
            
        }
    }
}




struct TransactionSection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Transazioni")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Text("Vedi tutte")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            // Inserire qui la lista delle transazioni
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

