//
//  CategoryView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    var category: Category
    
    var recipesFilter: [Recipe] {
        return recipeViewModel.recipes.filter{ $0.category == category.rawValue }
    }
    
    var body: some View {
        ScrollView {
            RecipeList(recipes: recipesFilter)
        }
        .navigationTitle("\(category.rawValue)")
        .navigationViewStyle(.stack)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.dessert)
            .environmentObject(RecipeViewModel())
    }
}
