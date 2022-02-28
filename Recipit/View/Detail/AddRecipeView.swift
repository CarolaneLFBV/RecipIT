//
//  AddRecipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var name: String = ""
    @State private var selectedCategory: Category = Category.principal
    @State private var ingredients: String = ""
    @State private var directions: String = ""
    @State private var navigationRecipe = false
    
    //Recipe added user default
    @State var numberRecipesAdded = UserDefaults.standard.integer(forKey: "addedRecipe")
    
    // Library option
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    // Saved pic to restore
    @State private var savedPictures: [String] = UserDefaults.standard.object(forKey: "savedPictures") as? [String] ?? [String]()
    
    // Function that loads the image
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        savedPictures.append(saveImage(image: inputImage))
        UserDefaults.standard.set(savedPictures, forKey: "savedPictures")
    }


    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de la recette")) {
                    TextField("Recette", text: $name)
                }
                
                Section(header: Text("Catégorie")) {
                    Picker("Catégorie", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Ingrédient(s)")) {
                    TextEditor(text: $ingredients)
                }
                
                Section(header: Text("Étape(s)")) {
                    TextEditor(text: $directions)
                }
                
                Section (header: Text("Insertion d'image")) {
                    VStack {
                          ZStack {

                              Text("Ajouter une image")
                                  .foregroundColor(.gray)
                                  .font(.headline)

                              image?
                                  .resizable()
                                  .scaledToFit()
                          }
                          .onTapGesture {
                              showingImagePicker = true
                          }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        dismiss()
                    } label:{
                        Label("Annuler", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(isActive: $navigationRecipe) {
                        RecipeView(recipe: recipeViewModel.recipes.sorted {$0.datePublished > $1.datePublished}[0])
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Button() {
                            saveRecipe()
                            navigationRecipe = true
                        } label:{
                            Label("Recette complète", systemImage: "checkmark")
                        }
                    }
                    .disabled(name.isEmpty)
                }
            })
            .navigationTitle("Nouvelle Recette 🍽")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }
        .navigationViewStyle(.stack)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .environmentObject(RecipeViewModel())
    }
}

extension AddRecipeView {
    private func saveRecipe() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let datePublished = dateFormatter.string(from: date)
        
        // Sauvegarde de la recette
        UserDefaults.standard.set(name, forKey: "\(numberRecipesAdded)name")
        UserDefaults.standard.set(ingredients, forKey: "\(numberRecipesAdded)ingredients")
        UserDefaults.standard.set(directions, forKey: "\(numberRecipesAdded)directions")
        UserDefaults.standard.set(datePublished, forKey: "\(numberRecipesAdded)datePublished")
        UserDefaults.standard.set(selectedCategory.rawValue, forKey: "\(numberRecipesAdded)category")
        
        print("Recipe saved")
        
        print("from save : \(numberRecipesAdded)")
         
        numberRecipesAdded += 1
        
        let recipe = Recipe(name: name, image: image, ingredients: ingredients, directions: directions, datePublished: datePublished, category: selectedCategory.rawValue)
        recipeViewModel.addRecipe(recipe: recipe)
        
        print("Recipe added : \(numberRecipesAdded)")

        UserDefaults.standard.set(numberRecipesAdded, forKey: "addedRecipe")
    }
}
