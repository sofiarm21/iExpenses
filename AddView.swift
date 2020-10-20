//
//  AddView.swift
//  iExpenses
//
//  Created by Sofia Rodriguez Morales on 10/20/20.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses = Expenses()
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = "Personal"
    @State private var types = ["Personal", "Bussines"]
    @State private var amount = ""
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("\(self.type != "" ? self.type : "Type")", selection: $type){
                    ForEach(self.types, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                TextField("Amount", text: $amount)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    if let actualAmount = Int(amount){
                        let expense = ExpenseItem(name: name, type: type, amount: actualAmount)
                        expenses.items.append(expense)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Text("Add expense")
                        Image(systemName: "plus")
                    }
                    
                }
            )
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
