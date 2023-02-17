//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack{
            VStack (){
                //Titolo centrale con tasto di ricerca
                titleHomeView()
                ClickableHStack()//Rettangolo con la visualizzazione dei membri
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
                TransactionSection()//Lista delle transazioni
                Spacer()
                
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    floatingAddButton()
                }
            }
            .padding(40)
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
                Text("Transactions")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Text("Show All")
                    .font(.system(size: 18))
                    .foregroundColor(.accentColor)
                
            }
            .padding()
            List{
                ForEach(0..<10){index in
                    TransactionCell()
                }
                
            }
            .listStyle(PlainListStyle())
            
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
    @State private var showSearchView = false
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
                    Button(action: {showSearchView.toggle()}){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .padding(.trailing)
                    }
                }
                .foregroundColor(.accentColor)
            })
            .padding()
            .fullScreenCover(isPresented: $showSearchView){
                SearchView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TransactionCell: View{
    var body: some View{
        HStack{
            Image(systemName: "square")
                .font(.system(size: 50))
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text("Title of Spesa")
                        .font(.system(size: 20)).bold()
                    Spacer()
                    Text("Total:")
                    
                }
                HStack{
                    Text("You paid : 3$")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("34$")
                }
                
            }
            Spacer()
            
        }
        .padding(.vertical)
    }
    
}

struct floatingAddButton: View{
    @State private var showAddTransaction = false
    var body: some View{
        Button(action: {
            self.showAddTransaction = true
            //Aggiunta della transazione
        }){
            Image(systemName: "plus")
                .buttonStyle(.bordered)
                .tint(.pink)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
     
        .sheet(isPresented: $showAddTransaction) {
            // Aggiungi la vista per aggiungere una transazione
        }
    }
}
