//
//  ContentView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//m

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var expenses: FetchedResults<Expense>
    var body: some View {
        ZStack{
            Color("BackGround").ignoresSafeArea()
            ScrollView{
                VStack(spacing: -10){
                    //Titolo centrale con tasto di ricerca
                    titleHomeView()
                    ClickableHStack()//Rettangolo con la visualizzazione dei membri
                        .background(Color("ForeGround"))
                        .cornerRadius(10)
                        .padding()
                    TransactionSection()//Lista delle transazioni
                    Spacer()
                    
                }
                
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

struct TransactionSection: View {
    @State var expanded = true
    var body: some View {
        
        
            VStack{
                DisclosureGroup(isExpanded: $expanded, content: {
                    ForEach(expenses.count){expense in
                        TransactionCell()
                    }
                    
                }, label: {
                    Text("Transactions")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.primary)
                })
                .padding(20)
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
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size:30))
                }
                
                Spacer()
                
            }
            .frame(height: 50)
            .padding()
        }
    }
}

struct titleHomeView: View{
    
    let balanceTitle = "Balance"
    var monetarySign = "€"
    let buttonSize: CGFloat = 30
    @State private var showSearchView = false
    
    
    
    
    var body: some View {
        VStack {
            CustomNavBar(left: {}, center: {
                VStack{
                    Text("00,00€")
                        .font(.title)
                        .bold()

                    Text(balanceTitle)
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
    @ObservedObject var expense: Expense
    var body: some View{
        Button(action: {}){
            HStack{
                Spacer()
                Image(systemName: "cart")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 30))
                
                Spacer()
                VStack(alignment: .leading){
                    HStack{
                        Text("Title of Spesa")
                            .font(.system(size: 20)).bold()
                        Spacer()
                        Text("Total:")
                    }
                    .foregroundColor(.primary)
                    HStack{
                        Text("You paid : 3$")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("34$")
                            .foregroundColor(.primary)
                    }
                    
                }.padding()
                Spacer()
                
            }
            .background(Color("ForeGround"))
            .cornerRadius(10)
        }
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

struct CustomCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
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
