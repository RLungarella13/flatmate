//
//  AddExpensiveView.swift
//  HelpingGroup1
//
//  Created by Nicola Restaino on 19/02/23.
//

import SwiftUI
import Combine
import Firebase

struct AddExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var obsUser: ObservableBool
  //  @Environment(\.managedObjectContext) private var viewContext
    @StateObject var dataManager = DataManager()
    @StateObject var dataManagerCoUser = DataManagerCoUser()
    @EnvironmentObject var dataManagerUser: DataManagerUser
    
    var itemCount = 0
    
    @State private var balance: Float = 0.0
    
    @State var desc : String = ""
    @State var title : String = ""
    @State var total : Float = 0.0
    
    @State private var selectedDate = Date()
    @State var isPersonal: Bool = true
    @State var isIncome: Bool = false
//    @Binding private var countExpenses: Int
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("title", text: $title)
                }
                
                Section(header: Text("Description")) {
                    TextField("description", text: $desc)
                }
                
//                Section(header: Text("Total")) {
//                    TextField("Totale", value: $total, formatter: formatter)
//                        .keyboardType(.decimalPad)
//                }
                Section(header: Text("Total")){
                    HStack{
                        Image(systemName: "eurosign")
                        CurrencyTextField( value: $total)
                    }
                }
                
                Section(header: Text("Date")) {
                    DatePicker(
                        "Select a date",
                        selection: $selectedDate,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                                
                    
                }
                
                Section(header: Text("For who?")) {
                    Button("Personal"){
                        isPersonal = true
                    }
                    Button("Group"){
                        isPersonal = false
                    }
                }
                
                Section(header: Text("Transaction")) {
                    Button("Expense"){
                        isIncome = false
                    }
                    Button("Income"){
                        isIncome = true
                    }
                }
            }
            .navigationTitle("New Expense")
            .navigationBarItems(leading: Button(action:{
                
                dismiss()
                
            }) {
                Text("Cancel")
            }, trailing: Button(action:{
                
//                saveNewExpense()
                if isPersonal{
                    let id = generateUniqueString()
                    dataManager.addExpense(id: id, title: title, desc: desc, total: total, date: selectedDate)
                    if isIncome{
                        
                        dataManagerUser.addUser(id: "TMvu9tQK3vHiNpM6Hp2a", balance: total)
                        
                    }
                }
//                countExpenses = total
                dataManagerUser.user.balance += total
                dismiss()
                    
                
            }) {
                Text("Save")
            }.disabled(title == "" || total == 0))
        }
        
    }
    
//    func saveNewExpense() {
//
//
//        let expense = Expense(context: viewContext)
//
//        expense.title = title
//        expense.desc = desc
//        expense.total = Float(total)
//        expense.date = selectedDate
//        expense.uID = UUID()
//
//        do {
//            try viewContext.save()
//            print("user saved")
//        } catch {
//
//            print(error.localizedDescription)
//
//        }
//
//    }
    func generateUniqueString() -> String {
        let uuid = UUID()
        return uuid.uuidString
    }
    
//    func observeItemCount() {
//        database.child("items").observe(.value) { snapshot in
//          itemCount = snapshot.childrenCount
//        }
//      }
    
}


//struct AddExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExpenseView()
//    }
//}

struct CurrencyTextField: View {
    @Binding var value: Float

    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        TextField("Total", value: $value, formatter: formatter)
            .keyboardType(.decimalPad)
            .onTapGesture {
                DispatchQueue.main.async {
                            UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                        }
            }
            .onReceive(Just(value)) { newValue in
                let filtered = String(newValue).filter { "0123456789.".contains($0) }
                if let result = Float(filtered) {
                    value = result
                } else {
                    value = 0
                }
            }
    }
}
