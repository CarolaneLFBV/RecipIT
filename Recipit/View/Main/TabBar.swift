//
//  TabBar.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex = 0
    
    // Liste d'icônes
    let icons = [
    "house",
    "plus",
    "bag",
    ]
    
    var body: some View {
        // VStack est une vue permettant d'aligner ses enfants sur la verticale
        VStack {
            // ZStack est une vue permettant de superposer ses enfants
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()

                case 1:
                    NewRecipeView()
                    
                case 2:
                    ShoppingListView()
                 

                default:
                    HomeView()
                    
                }
                
            }
            
            Spacer()
            
            Divider()
            
            // HStack est une vue permettant d'aligner ses enfants sur l'horizontale
            HStack {
                ForEach(0..<3, id: \.self) { number in
                    Spacer()
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        // Modification du bouton au milieu de la barre de naviguation
                        if number == 1 {
                            Image(systemName: icons[number])
                                .font(.system(size: 25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Color.yellow)
                                .cornerRadius(20)
                                .shadow(color: .orange, radius: 5)
                            
                        } else {
                            Image(systemName: icons[number])
                                .font(.system(size: 25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(selectedIndex == number ? .orange : Color(UIColor.lightGray))
                        }
                    })
                    Spacer()
                }
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
