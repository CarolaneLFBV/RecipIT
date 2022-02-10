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
                
                Section(header: Text("Paramètres généraux")) {
                    Text("Thème de l'application")
                    Text("Mode Sombre")
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
