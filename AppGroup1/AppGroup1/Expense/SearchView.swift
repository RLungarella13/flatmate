import SwiftUI
import Firebase

struct SearchView: View {
//    @FetchRequest<Expense>(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]) var allExpenses : FetchedResults<Expense>
    @StateObject var dataManager = DataManager()

//    var luckyExpense : [SExpense] {allExpenses.map{$0.self}}

    @State var searchText = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>



    var body: some View {

        NavigationView {
            ZStack{
                Color("BackGround").ignoresSafeArea()
                ScrollView{
                    ForEach(filteredExpense, id: \.id) { expense in
                        HStack {
                            SearchCell(expense: expense)
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                        .searchable(text: $searchText)
                        .navigationTitle("Search Transaction")
                        .navigationBarItems(leading: Button(action:{
                            
                            presentationMode.wrappedValue.dismiss()
                            
                        }){
                            Text("Dismiss")
                        })
                }
            }
        }
    }

    // Filter countries
    var filteredExpense: [SExpense] {
        // Make countries lowercased


        return searchText == "" ? dataManager.expenses : dataManager.expenses.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchCell: View{
    var expense: SExpense

    var body: some View{
        NavigationLink(destination: EditView(expense: expense) ){
            HStack{
                Spacer()
                Image(systemName: "cart")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 30))

                Spacer()
                VStack(alignment: .leading){
                    HStack{
                        Text(expense.title)
                            .font(.system(size: 20)).bold()
                        Spacer()
                        Text("Total:")
                    }
                    .foregroundColor(.primary)
                    HStack{
                        Text(expense.date.formatted(.dateTime.day().month().year()) )
                            .foregroundColor(.gray)
                        Spacer()

                        Text(String(format: "%.2f", expense.total)+"€")
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
