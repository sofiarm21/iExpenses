//
//  ContentView.swift
//  iExpenses
//
//  Created by Sofia Rodriguez Morales on 10/19/20.
//

import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items, id:\.name){ item in
                    Text(item.name)
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("iExpenses")
            .navigationBarItems(trailing:
                Button(action: {
                    var expense = ExpenseItem(name:"Item", type: "Generic", amount: 10)
                    expenses.items.append(expense)
                }) {
                   Image(systemName: "plus")
                }
            )
            
        }
        
    }
    
    func deleteExpense(at index: IndexSet){
        expenses.items.remove(atOffsets: index)
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
