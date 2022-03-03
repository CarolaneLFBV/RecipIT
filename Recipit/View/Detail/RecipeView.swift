//
//  RecipeView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RecipeView: View {
    @State var recipe: Recipe
    
    func addToFavorites() {
        recipe.isFavorite.toggle()
        UserDefaults.standard.set(recipe.isFavorite, forKey: "\(recipe.name)isFavorite")
    }
    

    var body: some View {
        ScrollView {
            VStack(spacing: 0){
                ZStack() {
                    recipe.image?
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
                            /*recipe.isFavorite ? "Retirer des favoris" : "Ajouter au favoris" , */
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
        .ignoresSafeArea(.container, edges: .top)
        
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.allRecipe[0])
    }
}
