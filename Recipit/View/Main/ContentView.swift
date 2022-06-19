//
//  ContentView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Ajout de la vue TabBar -> permet de l'avoir partout dans l'application
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeViewModel())
            // Permet à l'application d'accéder à la base de données de l'application
    }
}
