//
//  EditView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 18/02/23.
//

import SwiftUI

import SwiftUI

struct EditView: View {
    

    @Environment(\.managedObjectContext) private var viewContext
    
  
    
    var expense: Expense
    
    @State var desc : String
    @State var title : String
    @State var total: Float
    
    
    init ( expense : Expense) {
        
        self.expense = expense

        self._desc = State(wrappedValue: expense.desc!)
        self._title = State(wrappedValue: expense.title!)
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
                
                Section(header: Text("Quantity")) {
                    Stepper("\(total) $", value: $total)
                }
                
                Section(header: Text("Date last modified")) {
                    Text(expense.date!.formatted())
                }

            }
            .navigationBarTitle("Edit Expense", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") { saveNewExpense()})

    }
    
    func saveNewExpense() {
    
        expense.title = title
        expense.desc = desc
        expense.total = Float(total)
        
        
        do {
            try viewContext.save()
            print("item updated")
        } catch {
            
            print(error.localizedDescription)
            
        }
        
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(expense: Expense(context: PersistenceController.preview.container.viewContext))
    }
}
