//
//  NewReceipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

// Vue avec un bouton permettant d'accéder au formulaire de création
// de recettes
import SwiftUI

struct NewRecipeView: View {
    @State private var showingAddRecipe = false
    
    var body: some View {
        
        // NavigationView permet de naviguer sur l'application
        NavigationView {
            Button("Créer une nouvelle recette") {
                showingAddRecipe = true
            }
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            // .[paramètre] permet d'ajouter des paramètres (forme, couleur, etc.) au parent (ici, le bouton)
            
            .navigationTitle("Nouvelle recette 🍴")
        }
        .navigationViewStyle(.stack)
        // Lorsque l'on clique sur le bouton, la variable devient True, et affiche le formulaire
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

