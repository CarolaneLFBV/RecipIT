//
//  RecipeViewModel.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe]
    
    init() {
        recipes = Recipe.allRecipe
    }
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
