//
//  HomeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    // Variables
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showSettings = false
    
    var body: some View {
        // NavigationView permet de naviguer sur l'application
        NavigationView {
            // Permet de Scroller
            ScrollView {
                RecipeList(recipes: recipeViewModel.recipes)    // Ajout de la liste des recettes
            }
            .navigationTitle("Recip'IT")
            
            // Ajout d'un menu dans la barre d'outil (en haut) -> Accède aux paramètres
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // NavigationLink -> Permet de naviguer d'une vue à une autre à l'aide d'un bouton
                    NavigationLink(isActive: $showSettings) {
                        SettingsView()
                    } label:{
                        Label("Paramètres", systemImage: "gear")
                    }.foregroundColor(.orange)
                    // .[paramètre] permet d'ajouter des paramètres (forme, couleur, etc.) au parent (ici, le bouton)
                }
            })
        }
        .navigationViewStyle(.stack) // Permet d'éviter des bugs avec la console
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipeViewModel())
    }
}
