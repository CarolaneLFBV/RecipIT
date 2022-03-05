//
//  SettingsView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Réseaux sociaux")) {
                    
                    Link("Site internet 🌐", destination: URL(string: " http://www.carolanelefebvre.com/")!)
                        .foregroundColor(.black)
               
                    Link("Twitter 🐦", destination: URL(string: "https//www.twitter.com")!)
                        .foregroundColor(.black)
                    
                }
                
                Section(header: Text("Informations application")) {
                    Text("Version de l'application : v.1.1.0")
                    Text("Développé par Carolane LEFEBVRE")

                }
            
            }
                .navigationTitle("Paramètres ⚙️")
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
