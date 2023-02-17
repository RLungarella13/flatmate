//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    var buttonSize = 30
    @State private var showAddTransaction = false
    var body: some View {
        VStack (){
            
            titleHomeView()
            Spacer()
            ClickableHStack()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
            
            TransactionSection()
            
            Spacer()
            
            .padding(15.0)
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

struct CustomCenter: AlignmentID {
  static func defaultValue(in context: ViewDimensions) -> CGFloat {
    context[HorizontalAlignment.center]
  }
}

extension HorizontalAlignment {
  static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
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
                ForEach(0..<4){ index in
                    Image(systemName: "person")
                        .font(.system(size:30))
                }
                
                Spacer()
                
            }
            .padding()
        }
    }
}

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder center: @escaping () -> Center, @ViewBuilder right: @escaping () -> Right) {
        self.left = left
        self.center = center
        self.right = right
    }
    var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}

struct titleHomeView: View{
    let buttonSize: CGFloat = 30
    var body: some View {
        VStack {
            CustomNavBar(left: {}, center: {
                VStack{
                    Text("230$")
                        .font(.title)
                        .bold()
                    Text("Balance")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
    
            }, right: {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing)
                }
                .foregroundColor(.accentColor)
            })
            .padding()
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

