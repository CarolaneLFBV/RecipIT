//
//  HomeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showSettings = false
    var body: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: recipeViewModel.recipes)
            }
            .navigationTitle("Recip'IT")
            
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(isActive: $showSettings) {
                        SettingsView()
                    } label:{
                        Label("Paramètres", systemImage: "gear")
                    }.foregroundColor(.orange)
                }

            })
            
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
