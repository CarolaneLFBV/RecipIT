//
//  RecipeList.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct RecipeList: View {
    @State var recipes: [Recipe]
    @State var showingFavorites = false
    @State var firstLoad = true
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "recettes" : "recette")")
                    .font(.headline.weight(.bold)).opacity(0.7)
                    .foregroundColor(.orange)
                
                Spacer()
            }
            
            Toggle(isOn: $showingFavorites) {
                Text("Favoris")
            }
            
            // LazyVGrid = vertical grid that adjusts depends on the number of items
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 15) {
                ForEach(recipes) { recipe in
                    if !self.showingFavorites || recipe.isFavorite == true {
                    NavigationLink(destination: RecipeView(recipe: recipe)){
                        RecipeCard(recipe: recipe)
                        }
                    }
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
        .onAppear(perform: {
            if firstLoad {
                recipes = recipeViewModel.getRecipes()
                firstLoad = false
            }
            
            for i in 0..<recipes.count {
                recipes[i].isFavorite = UserDefaults.standard.bool(forKey: "\(recipes[i].name)isFavorite")
            }
        })
        .navigationViewStyle(.stack)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        // Permet à l'utilisateur de pouvoir scroller
        ScrollView {
            RecipeList(recipes: Recipe.allRecipe)
        }
    }
}
