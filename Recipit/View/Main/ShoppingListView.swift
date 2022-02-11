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
    @State private var addedIngredients = 0
    @State private var didLoad = true
 
    
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
        addedIngredients += 1
        UserDefaults.standard.set(addedIngredients, forKey: "NumberIngredients")
        UserDefaults.standard.set(newIngredient, forKey: "\(addedIngredients-1)Added")
        self.newIngredient = ""
    }
    
    func deleteItem(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        for i in index..<addedIngredients-1 {
            let nextUD = UserDefaults.standard.string(forKey: "\(i+1)Added")!
            UserDefaults.standard.set(nextUD, forKey: "\(i)Added")
        }
        UserDefaults.standard.removeObject(forKey: "\(addedIngredients-1)Added")
        
        shoppingListStorage.shoppinglists.remove(atOffsets: offsets)
        addedIngredients -= 1
        UserDefaults.standard.set(addedIngredients, forKey: "NumberIngredients")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar.padding()
                List {
                    ForEach(self.shoppingListStorage.shoppinglists) { shoppinglist in
                        Text(shoppinglist.shoppingItem)
                    }.onDelete(perform: self.deleteItem)
                }
                .navigationTitle("Liste de course 🛒")
                .navigationBarItems(trailing: EditButton())
            }
        }
        .onAppear(perform: {
            if didLoad {
                addedIngredients = UserDefaults.standard.integer(forKey: "NumberIngredients")
                for i in 0..<addedIngredients {
                    shoppingListStorage.shoppinglists.append(ShoppingList(id: String(shoppingListStorage.shoppinglists.count + 1), shoppingItem: UserDefaults.standard.string(forKey: "\(i)Added")!))
                }
                didLoad = false
            }
        })
        .navigationViewStyle(.stack)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
