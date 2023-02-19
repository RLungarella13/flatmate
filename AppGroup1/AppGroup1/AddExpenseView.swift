//
//  AddExpensiveView.swift
//  HelpingGroup1
//
//  Created by Nicola Restaino on 19/02/23.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var desc : String = ""
    @State var title : String = ""
    @State var total : Float = 0.0
    @State private var selectedDate = Date()
    
    
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
            .navigationTitle("New Expense")
            .navigationBarItems(leading: Button(action:{
                
                dismiss()
                
            }) {
                Text("Cancel")
            }, trailing: Button(action:{
                
                saveNewExpense()
                dismiss()
                
                
            }) {
                Text("Save")
            })
        }
    }
    
    func saveNewExpense() {
        
        
        let expense = Expense(context: viewContext)
        
        expense.title = title
        expense.desc = desc
        expense.total = Float(total)
        expense.date = selectedDate
        expense.uID = UUID()
        
        do {
            try viewContext.save()
            print("user saved")
        } catch {
            
            print(error.localizedDescription)
            
        }
        
    }
    
    
    
}


struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
