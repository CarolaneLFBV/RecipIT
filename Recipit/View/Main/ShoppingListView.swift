//
//  ShoppingListView.swift
//  RecipIT
//
//  Created by Carolane on 08/02/2022.
//

import SwiftUI
import Combine

struct ShoppingListView: View {
    @ObservedObject var shoppingListStorage = ShoppingListStorage()
    @State private var newIngredient: String = ""
    
    var searchBar: some View {
        HStack {
            TextField("Ajouter un ingrédient", text: self.$newIngredient)
            Button(action: addIngredient, label: {
                Text("Ajouter")
            })
        }
    }
    
    func addIngredient() {
        shoppingListStorage.shoppinglists.append(ShoppingList(id: String(shoppingListStorage.shoppinglists.count + 1), shoppingItem: newIngredient))
        self.newIngredient = ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar.padding()
                List {
                    ForEach(self.shoppingListStorage.shoppinglists) { shoppinglist in
                        Text(shoppinglist.shoppingItem)
                    }.onMove(perform: self.moveItem)
                        .onDelete(perform: self.deleteItem)
                }
                .navigationTitle("Liste de course 🛒")
                .navigationBarItems(trailing: EditButton())
            }
        }
        .navigationViewStyle(.stack)
    }
    func moveItem(from source: IndexSet, to destination: Int) {
        shoppingListStorage.shoppinglists.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteItem(at offsets: IndexSet) {
        shoppingListStorage.shoppinglists.remove(atOffsets: offsets)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
