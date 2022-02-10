//
//  TabBar.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

/* Incorporation d'une barre de naviguation avec différentes parties :
 - Page principale
 - Page catégories
 - Page nouvelle recette
 - Page recettes favorites
 - Page paramètres */

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
            // Permet d'ajouter une catégorie dans la barre de naviguation avec nom et image
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Catégories", systemImage: "filemenu.and.selection")
                }
            
            NewRecipeView()
                .tabItem {
                    Label("Nouvelle", systemImage: "plus")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Course", systemImage: "bag")
                }
            
            SettingsView()
                .tabItem {
                    Label("Paramètres", systemImage: "gear")
                }
  
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(RecipeViewModel())
    }
}
