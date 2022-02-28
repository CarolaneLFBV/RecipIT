//
//  RecipeList.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct RecipeList: View {
    @State var initialRecipes: [Recipe] = []
    @State var recipes: [Recipe]
    @State var showingFavorites = false
    @State var firstLoad = true
    
    func restoreRecipe() {
        let addedRecipe = UserDefaults.standard.integer(forKey: "addedRecipe")
        print("From restore: \(addedRecipe)")
        let images = getImages(imageNames: UserDefaults.standard.object(forKey: "savedPictures") as? [String] ?? [String]())
        for i in 0..<addedRecipe {
            recipes.append(Recipe(name: UserDefaults.standard.string(forKey: "\(i)name")!, image: Image(uiImage: images[i]!), ingredients: UserDefaults.standard.string(forKey: "\(i)ingredients")!, directions: UserDefaults.standard.string(forKey: "\(i)directions")!, datePublished: UserDefaults.standard.string(forKey: "\(i)datePublished")!, category: UserDefaults.standard.string(forKey: "\(i)category")!))
            print("Added \(addedRecipe) recipe")
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "recettes" : "recette")")
                    .font(.headline.weight(.medium)).opacity(0.7)
                
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
                initialRecipes = recipes
                firstLoad = false
            }
            recipes = initialRecipes
            restoreRecipe()
            
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
