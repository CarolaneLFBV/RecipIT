//
//  HomeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: recipeViewModel.recipes)
            }
            .navigationTitle("Mes recettes 🍴")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipeViewModel())
    }
}
