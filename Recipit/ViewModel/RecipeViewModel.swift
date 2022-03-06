//
//  RecipeViewModel.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published public var recipes: [Recipe]
    
    init() {
        recipes = Recipe.allRecipe
        
        let addedRecipe = UserDefaults.standard.integer(forKey: "addedRecipe")
        print("From restore: \(addedRecipe)")
        let images = getImages(imageNames: UserDefaults.standard.object(forKey: "savedPictures") as? [String] ?? [String]())
        for i in 0..<addedRecipe {
            let recipe = Recipe(name: UserDefaults.standard.string(forKey: "\(i)name")!, image: Image(uiImage: images[i]!), ingredients: UserDefaults.standard.string(forKey: "\(i)ingredients")!, directions: UserDefaults.standard.string(forKey: "\(i)directions")!, datePublished: UserDefaults.standard.string(forKey: "\(i)datePublished")!, category: UserDefaults.standard.string(forKey: "\(i)category")!)
            addRecipe(recipe: recipe)
            print("Added \(addedRecipe) recipe")
            //print("This is a test")
        }
    }
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
    
    func getRecipes() -> [Recipe] {
        return recipes
    }
}
