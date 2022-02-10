//
//  NewReceipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//


import SwiftUI

struct NewRecipeView: View {
    @State private var showingAddRecipe = false
    var body: some View {
        NavigationView {
            Button("Entrer une recette manuellement") {
                showingAddRecipe = true
            }
                .navigationTitle("Nouvelle recette 🍴")
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingAddRecipe) {
            AddRecipeView()
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}

