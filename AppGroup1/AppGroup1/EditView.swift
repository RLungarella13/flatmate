//
//  EditView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 18/02/23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest<Expense>(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]) var allExpenses : FetchedResults<Expense>
  
    @State private var showDisclaimer = false
    @State private var acceptedDisclaimer = false
    var expense: Expense
    
    @State var desc : String
    @State var title : String
    @State var total: Float
    @State private var selectedDate = Date()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    
    init ( expense : Expense) {
        
        self.expense = expense

        self._desc = State(wrappedValue: expense.desc ?? "")
        self._title = State(wrappedValue: expense.title ?? "")
        self._total = State(wrappedValue: Float(expense.total))
    
    }
    
    
    
    var body: some View {
       
            Form {
                Section(header: Text("Title")) {
                    TextField("title", text: $title)
                }
                
                Section(header: Text("Description")) {
                    TextField("description", text: $desc)
                }
                
                Section(header: Text("Total")) {
                    TextField("Totale", value: $total, formatter: formatter)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Date")) {
                    DatePicker(
                        "Select a date",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                                
                    
                }

            }
            .navigationBarTitle("Edit Expense", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") { saveNewExpense()}.disabled(title == ""))
            
            .navigationBarItems(trailing: Button("Delete"){
                acceptedDisclaimer = true
            })
            .alert(isPresented: $acceptedDisclaimer){
                Alert(title: Text("Are you sure?"), message: Text(""), primaryButton: .default(Text("Yes")) {
                    removeExpense()
                }, secondaryButton: .cancel(Text("No")))
            }
            
    }
    
    func saveNewExpense() {
    
        expense.title = title
        expense.desc = desc
        expense.total = Float(total)
        expense.date = selectedDate
        dismiss()
        
        
        do {
            try viewContext.save()
            print("item updated")
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        
    }
    
    func removeExpense() {
        guard let index = allExpenses.firstIndex(of: expense) else { return }
        viewContext.delete(allExpenses[index])
        showDisclaimer = false

        do {
            try viewContext.save()
            dismiss()
        }
        catch {

            print(error.localizedDescription)
        }
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(expense: Expense(context: PersistenceController.preview.container.viewContext))
    }
}
