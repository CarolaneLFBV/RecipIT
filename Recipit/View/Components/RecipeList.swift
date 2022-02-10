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
    @State var didLoad = true
    
    func restoreRecipe() {
        var addedRecipe = UserDefaults.standard.integer(forKey: "addedRecipe")
        print("From restore: \(addedRecipe)")
        for i in 0..<addedRecipe {
            recipes.append(Recipe(name: UserDefaults.standard.string(forKey: "\(i)name")!, image: Image("photo1"), ingredients: UserDefaults.standard.string(forKey: "\(i)ingredients")!, directions: UserDefaults.standard.string(forKey: "\(i)directions")!, datePublished: UserDefaults.standard.string(forKey: "\(i)datePublished")!, category: UserDefaults.standard.string(forKey: "\(i)category")!, url: UserDefaults.standard.string(forKey: "\(i)url")!))
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
            
            // LazyVGrid créer une grid vertical permettant de s'ajuster automatiquement en fonction du nombre de cartes qui se trouvent.
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
            if didLoad {
                restoreRecipe()
                didLoad = false
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
