//
//  ShoppingListModel.swift
//  RecipIT
//
//  Created by Carolane on 08/02/2022.
//

import Foundation
import SwiftUI
import Combine

struct ShoppingList : Identifiable {
    var id = String()
    var shoppingItem = String()
}


class ShoppingListStorage: ObservableObject {
    @Published var shoppinglists = [ShoppingList]()
}
