//
//  SettingsView.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State private var notificationPush = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Paramètres généraux")) {
                    Button("Permission de notification") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("Accepted")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    .frame(width: 200, height: 10)
                    .padding()
                    .foregroundColor(.white)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                        

                    Button("Planifier une notification") {
                        let content = UNMutableNotificationContent()
                        content.title = "Recip'IT"
                        content.subtitle = "De délicieuses recettes vous attendent !"
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }
                    .frame(width: 200, height: 10)
                    .padding()
                    .foregroundColor(.white)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
           

                }
                
                Section(header: Text("Réseaux sociaux")) {
                    Link("Site internet 🌐", destination: URL(string: "http://www.carolanelefebvre.com/")!)
                        .foregroundColor(.black)
               
                    Link("Twitter 🐦", destination: URL(string: "https://twitter.com/Akiuie")!)
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
