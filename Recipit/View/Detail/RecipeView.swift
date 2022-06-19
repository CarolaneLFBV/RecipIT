//
//  RecipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

// Structure permettant de créer des rectangle arrondi
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Extension de RoundedCorner
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RecipeView: View {
    @State var recipe: Recipe
    
    // Fonction permettant d'ajouter des recettes en favoris
    func addToFavorites() {
        recipe.isFavorite.toggle()
        UserDefaults.standard.set(recipe.isFavorite, forKey: "\(recipe.name)isFavorite")
    }
    
    var body: some View {
        ScrollView {
            //le paramètres spacing permet à la vue de ne pas avoir de marge (padding)
            VStack(spacing: 0){
                ZStack() {
                    recipe.image?       //image? permet de définir si une image existe, dans le cas contraire, elle sortira nil
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: UnitPoint.top, endPoint: .bottom))
                    
                    VStack() {
                        Spacer()
                        Text(recipe.name)
                            .frame(width: 350, height: 60)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                            .font(.system(size: 25).bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                
                HStack() {
                    VStack() {
                        if !recipe.category.isEmpty {
                            Text("\(recipe.category)")
                                .font(.system(size: 20,
                                              weight: .regular,
                                              design: .default))
                            }
                        }
                    
                    VStack() {
                        Button() {
                            addToFavorites()
                        } label:{
                            //recipe.isFavorite ? "Retirer des favoris" : "Ajouter au favoris"
                            // Opération ternaire permettant de modifier si la recette est dans les favoris ou non (colorit l'icône)
                            Label(recipe.isFavorite ? "Favoris" : "Favoris" , systemImage: recipe.isFavorite ? "star.fill" : "star")
                                .foregroundColor(.orange)
                                .font(.system(size: 20,
                                              weight: .regular,
                                              design: .default))
                        }
                    }
                }
                .frame(width: 350, height: 5)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15, corners: [.bottomRight, .bottomLeft])
                .shadow(color: .black, radius: 15, x: 0, y: 12)
                
                
                // le paramètre leading permet de suivre la vue de son parent (VStack)
                VStack(alignment: .leading, spacing: 30) {
                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Spacer()
                                .frame(height: 20)
                            Text("Ingrédients")
                                .font(.headline)
                                .foregroundColor(.orange)
        
                            
                            Text(recipe.ingredients)
                        }
                    }
                    
                    if !recipe.directions.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Étapes")
                                .font(.headline)
                                .foregroundColor(.orange)
                            
                            Text(recipe.directions)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)

            }
            //.background(Color.orange)
        }
        .navigationViewStyle(.stack)
        
        // De base, la vue s'arrête uniquement sur une vue complète, et les bords sont donc pris en compte, ce qui rend
        // l'application pas agréable à la vue.
        .ignoresSafeArea(.container, edges: .top)
        
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        //Permet d'ajouter une liste en exemple
        RecipeView(recipe: Recipe.allRecipe[0])
    }
}
