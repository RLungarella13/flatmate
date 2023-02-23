//
//  EditView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 18/02/23.
//

import SwiftUI
import Firebase

struct EditView: View {
    
    @Environment(\.dismiss) private var dismiss
//  @Environment(\.managedObjectContext) private var viewContext
//  @FetchRequest<Expense>(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]) var allExpenses : FetchedResults<Expense>
  
    @State private var showDisclaimer = false
    @State private var acceptedDisclaimer = false
    var expense: SExpense
    @EnvironmentObject var dataManager: DataManager
    
    @State var desc : String
    @State var title : String
    @State var total: Float
    @State private var selectedDate = Date()
    @EnvironmentObject var dataManagerUser: DataManagerUser
    init ( expense : SExpense) {
            self.expense = expense

            self._desc = State(wrappedValue: expense.desc )
            self._title = State(wrappedValue: expense.title )
            self._total = State(wrappedValue: Float(expense.total))
        
        }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
       
            Form {
                Section(header: Text("Title")) {
                    TextField("title", text: $title)
                }
                
                Section(header: Text("Description")) {
                    TextField("description", text: $desc)
                }
                
                Section(header: Text("Total")){
                    HStack{
                        Image(systemName: "eurosign")
                        CurrencyTextField(value: $total)
                            
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

            }
            .navigationBarTitle("Edit Expense", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") { saveNewExpense(title: title, desc: desc, total: total, date: selectedDate)}.disabled(title == "" || total == 0))
            .navigationBarItems(trailing: Button("Delete"){
                acceptedDisclaimer = true
            })
            .alert(isPresented: $acceptedDisclaimer){
                Alert(title: Text("Are you sure?"), message: Text(""), primaryButton: .default(Text("Yes")) {
                    removeExpense()
                }, secondaryButton: .cancel(Text("No")))
            }
            
    }
    
    func saveNewExpense(title: String, desc: String, total: Float, date: Date) {
        let db = Firestore.firestore()
        
        db.collection("Expense").document(expense.id).getDocument { (document, error) in
            if let document = document, document.exists {
                db.collection("Expense").document(expense.id).setData([
                    "id": expense.id,
                    "title": title,
                    "desc": desc,
                    "total": total,
                    "date": date
                ])
            }
            else{
                print("ERRORE \(expense.id) \(db.collection("Expense").document(expense.id).documentID)")
            }
            
        }
        dismiss()
    }
    
    func removeExpense() {
        let db = Firestore.firestore()
        
        db.collection("Expense").document(expense.id).getDocument { (document, error) in
            if let document = document, document.exists {
                db.collection("Expense").document(expense.id).delete()
            }
            else{
                print("ERRORE \(expense.id) \(db.collection("Expense").document(expense.id).documentID)")
            }
            
        }
        dismiss()
        showDisclaimer = false

        

    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(expense: expense)
//    }
//}
