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
    @State private var currentImg: UIImage?

    // Saved pic to restore
    @State private var savedPictures: [String] = UserDefaults.standard.object(forKey: "savedPictures") as? [String] ?? [String]()
    
    // Function that loads the image
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        currentImg = inputImage
    }


    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de la recette")) {
                    TextField("Recette", text: $name)
                }
                .font(.system(size: 13, weight: .bold))
                
                Section(header: Text("Catégorie")) {
                    Picker("Catégorie", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .font(.system(size: 13, weight: .bold))
                
                Section(header: Text("Ingrédient(s)")) {
                    TextEditor(text: $ingredients)
                }
                .font(.system(size: 13, weight: .bold))
                
                Section(header: Text("Étape(s)")) {
                    TextEditor(text: $directions)
                }
                .font(.system(size: 13, weight: .bold))
                
                Section (header: Text("Insertion d'image")) {
                    VStack {
                          ZStack {

                              Text("Ajouter une image")
                                  .foregroundColor(.orange)
                                  .font(.system(size: 15, weight: .bold))

                              image?
                                  .resizable()
                                  .scaledToFit()
                          }
                          .onTapGesture {
                              showingImagePicker = true
                          }
                    }
                }
                .font(.system(size: 13, weight: .bold))
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
                        RecipeView(recipe: recipeViewModel.recipes.last!)
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
        
        guard let currentImg = currentImg else { return }
        
        savedPictures.append(saveImage(image: currentImg))
        UserDefaults.standard.set(savedPictures, forKey: "savedPictures")
        
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
