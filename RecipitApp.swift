//
//  RecipITApp.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

@main
struct RecipITApp: App {
    @StateObject var recipeViewModel = RecipeViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeViewModel)
        }
    }
}
