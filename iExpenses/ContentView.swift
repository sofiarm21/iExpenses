//
//  ContentView.swift
//  iExpenses
//
//  Created by Sofia Rodriguez Morales on 10/19/20.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try?
                decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }else{
            self.items = []
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showAddView = false
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items){ item in
                    Text(item.name)
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("iExpenses")
            .navigationBarItems(trailing:
                Button(action: {
                    showAddView = true
                }) {
                   Image(systemName: "plus")
                }
            )
            
        }
        .sheet(isPresented: $showAddView, content: {
            AddView(expenses: expenses)
        })
        
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
