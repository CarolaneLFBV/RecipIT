//
//  RecipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct RecipeView: View {
    @State var recipe: Recipe
    
    func addToFavorites() {
        recipe.isFavorite.toggle()
        UserDefaults.standard.set(recipe.isFavorite, forKey: "\(recipe.name)isFavorite")
    }

    var body: some View {
        ScrollView {
            recipe.image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: UnitPoint.top, endPoint: .bottom))
            
            VStack(spacing: 30) {
                Text(recipe.name)
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 20) {
                    Button() {
                        addToFavorites()
                    } label:{
                        Label(recipe.isFavorite ? "Retirer des favoris" : "Ajouter au favoris" , systemImage: recipe.isFavorite ? "star.fill" : "star")
                    }
                
                VStack(alignment: .leading, spacing: 30) {
                    if !recipe.category.isEmpty {
                        Text("Catégorie : \(recipe.category)")
                            .background(Color(.yellow))
                            .clipShape(Capsule())
                    }
                    
                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Ingrédients")
                                .font(.headline)
                            
                            Text(recipe.ingredients)
                        }
                    }
                    
                    if !recipe.directions.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Étapes")
                                .font(.headline)
                            
                            Text(recipe.directions)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            }
        }
        .navigationViewStyle(.stack)
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.allRecipe[0])
    }
}
