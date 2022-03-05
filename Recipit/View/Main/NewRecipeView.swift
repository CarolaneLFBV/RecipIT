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
            Button("Créer une nouvelle recette") {
                showingAddRecipe = true
            }
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
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

