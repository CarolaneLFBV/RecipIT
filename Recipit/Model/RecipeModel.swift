//
//  RecipeModel.swift
//  RecipIT
//
//  Created by Carolane on 07/02/2022.
//

import Foundation
import SwiftUI

// Définit un type commun pour un groupe de valeurs apparentées & permet de travailler avec de manière sûre.
enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case breakfast = "Petit Déjeuner 🥐"
    case soup = "Soupe 🥣"
    case salad = "Salade 🥗"
    case appetizer = "Appéritif 🍢"
    case principal = "Plat principal 🥘"
    case secondaire = "Plat secondaire 🥙"
    case dessert = "Dessert 🧁"
    case snack = "En-cas 🍪"
    case drink = "Boisson ☕️"
    
}

// La structure ici sera Identifiable car chaque recette sera unique, avec son propre ID
struct Recipe: Identifiable {
    
    // Initialisation des varaibles
    let id = UUID() // Permet de créer une chaîne de caractères permettant de constituer un ID
    let name: String
    let image: Image?
    var isFavorite: Bool
    let ingredients : String
    let directions: String
    let datePublished: String
    let category: Category.RawValue //.RawValue permet de lire le string au lieu du case en lui-même
    
    init(name: String, image: Image?, ingredients: String, directions: String, datePublished: String, category: Category.RawValue){
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.directions = directions
        self.datePublished = datePublished
        self.category = category
        self.isFavorite = false
    }
}

extension Recipe {
    static var allRecipe: [Recipe] = [
        Recipe(
            name: "Salade de concombre au chèvre et olives",
            image: Image("photo1"),
            ingredients: "Basilic\n1 Concombre\nOlives vertes dénoyautés\n1 bûche de chèvre\nVinaigrette",
            directions: "Étape 1 : Peler et couper le concombre en rondelles et le faire dégorger.\n\nÉtape 2 : Couper le chêvre en petits morceaux.\n\nÉtape 3 : Mélanger dans un saladier le concombre, les morceaux de fromage de chèvre, les olives dénoyautés, le basilic et la vinaigrette.\n\nÉtape 4 : Mettre au frais en attendant.",
            datePublished: "",
            category: "Salade 🥗"
        ),
        
        Recipe(
            name: "Gâteau de crêpes à la chantilly et confiture",
            image: Image("photo2"),
            ingredients: "500ml de lait\n1 4 oeufs\n40g de sucre\n½ c.à.s de vanille en poudre\n170g de farine\n20ml d'huile végétale\n50g de beurre doux\n250g de mascarpone\n150ml de crème fleurette\n30g de sucre glace\n1 pot de confiture Fraise Intense Bonne Maman",
            directions: "Étape 1 : Préparer un beurre noisette en chauffant le beurre dans une casserole à feu doux jusqu'à coloration. Le beurre va crépiter. Puis, laisser refroidir et verser dans une passoire pour enlever les résidus. Réserver.\n\nÉtape 2 : Batter au fouet les oeufs et le sucre, ajouter la vanille, la farine en pluie et homogénéiser. Incorporer l'huile et le beurre noisette puis le lait. Mélanger bien.\n\nÉtape 3 : Chauffer la poêle à crêpes et verser la pâte à la louche sans la graisser. Cuiser et retouner les crêpes une à une. Laisser refroidir avant de monter le gâteau.\n\nÉtape 4 : Batter en chantilly la crème fleurette, le mascarpone et le sucre.\n\nÉtape 5 : Sur une asiette, disposez une crêpe en étalant dessus de la chantilly et de la Confiture de Fraise Intense Bonne Maman, recouvrer d'une autre crêpe et répétez l'opération.",
            datePublished: "",
            category: "Dessert 🧁"
        ),
        
        Recipe(
            name: "Bavarois aux fraises sur génoise",
            image: Image("photo3"),
            ingredients: "Nappage :\n3 Feuilles de gélatine\n1 coulis de fruits rouges\n\nBavarois :\n500g de fraises\n1 citron\n6 feuilles de gélatine\n200g de sucre\n40cl de crème liquide fleurette\n\nGénoise :\n125g de sucre\n125g de farine\n4 jaunes d'oeuf\n4 blancs d'oeuf",
            directions: "Étape 1 : A préparer la veille.\n\nÉtape 2 : Génoise : mélanger les jaunes d'oeufs avec le sucre et travailler jusqu'à ce que le mélange blanchisse.\n\nÉtape 3 : Ajouter la farine et mélanger.\n\nÉtape 4 : Monter les blancs en neige et les mêler délicatement à la pâte.\n\nÉtape 5 : Étaler cette pâte en couche régulière dans un cercle à pâtisserie à bords hauts, sur une plaque garnie d'une feuille de papier cuisson.\n\nÉtape 6 : Faire cuire une dizaine de minutes à 220°C jusqu'à ce que la pâte soit cuite, la glisser sur un plat à dessert et ôter le papier cuisson.\n\nÉtape 7 : Bavarois : faire ramolir les 6 feuilles de gélatine dans un bol d'eau froid.\n\nÉtape 8 : Laver et équeuter les fraises.\n\nÉtape 9 : Les mixer avec le jus de citron et ajouter les 220g de sucre.\n\nÉtape 10 : Verser ce mélange dans une casserole, faire chauffer à feu doux et y ajouter les feuilles de gélatine ramollies et essorées. Remuer jusqu') ce qu'elles fondent, puis laisser refroidir.\n\nÉtape 11 : Monter les 40cl de crème chantilly.\n\nÉtape 12 : Quand la mixture est refroidie et avant que la gélatine ne prenne, y ajouter délicatement la crème fouettée.\n\nÉtape 13 : Verser le tout sur la génoise dans le cercle à pâtisserie et mettre au réfrégirateur jusqu'au lendemain.\n\nÉtape 14 : Le lendemain, préparer le nappage : faire ramollir les 3 feuilles de gélatine dans de l'eau.\n\nÉtape 15 : Chauffer le coulis dans une casserole, y ajouter les feuilles de gélatine en les faisant bien fondre et les laisser refroidir.\n\nÉtape 16 : Passer la lame d'un couteau sur le bord du cercle à pâtisserie pour démouler le bavarois, puis le napper.\n\nÉtape 17 : Mettre un peu au réfrégirateur.",
            datePublished: "",
            category: "Dessert 🧁"
        ),
        
        Recipe(
            name: "Poulet aux olives",
            image: Image("photo4"),
            ingredients: "2 Oignons\n3 Gousses d'ail\n 15cl D'huile d'olive\n1 Bouquet de persil + coriandre\n½ C.à.s d'épices à couscous\n1 Dose de safran\n½ C.à.s de paprika\nPoivre\nSel\n1 Poulet\n500g d'Olives vertes",
            directions: "Étape 1 : Couper grossièrement les oignons en lamelles, l'air en quatr, et ciseler le persil et la coriandre.\n\nÉtape 2 : Mettre un fond d'huile d'olive dans une marmite et y ajouter le poulet découpé en morceaux. Saler et poivrer.\n\nÉtape 3 : Faire légèrement dorer el poulet à feu moyen en remuant de temps en temps. Une fois le poulet doré, ajouter dans la marmite : 20cl d'eau, les oignons, l'ail, toutes les épices et 1 pognées d'olives vertes. Remuer.\n\nÉtape 4 : Laisser mijoter 20-25min en remuant de temps de temps.\n\nÉtape 5 : Lorsque le poulet est cuit, retirer-le de la marmite et ajouter le reste des olives, mélanger bien et laisser de nouveau mijoter à feu doux.\n\nÉtape 6 : Au moment de servir, placer les morceaux de poulet dans un grand plat en verstant la sauce par-dessus.",
            datePublished: "",
            category: "Plat principal 🥘"
        ),
        
        Recipe(
            name: "Oeufs cocottes",
            image: Image("photo5"),
            ingredients: "Crème fraîche\nPoivre\nSel\nGruyère râpé\n1 oeuf\n1 tranche de jambon",
            directions: "Étape 1 : Préchauffer le four à 180°C. Pendant ce temps beurrer un ramequin. Couper la tranche de jambon en 2 puis déposer les 2 morceaux dans le ramquin.\n\nÉtape 2 : Ajouter l'oeuf.\n\nÉtape 3 : Recourir de crème fraîche.\n\nÉtape 4 : Saler, poivrer.\n\nÉtape 5 : Parsemer de gruyère pour terminer.\n\nÉtape 6 : Vérifier la cuisson.",
            datePublished: "",
            category: "Appéritif 🍢"
        ),
    
        Recipe(
            name: "Chili con carne facile",
            image: Image("photo6"),
            ingredients: "50g de beurre\n2 Oignons\n2 gousses d'ail\n1 C.à.s de chilli en poudre\n1 C.à.s de cumin en poudre\n65g de concentré de tomates\n1 grosse boîte d'haricots rouges égouttés\n30cl de bouillon de boeuf\nSel, Poivre\nPersil (décoration)\n500g de boeuf hâché",
            directions: "Étape 1 : Préchauffer le four à 180°C. \n\nÉtape 2 : Hacher l'oignon et l'ail.\n\nÉtape 3 : Dans uen cocotte en fonte, faire fondre le beurre, et ensuite dorer doucement l'oignon et l'ail.\n\nÉtape 4 : Incorporer le boeuf haché et laisser cuire doucement 10min.\n\nÉtape 5 : Mélanger le chili, le cumin, le concentré de tomates, et incorprer le tout au boeuf. Ajouter les haricots, le bouillon, du sel et du poivre.\n\nÉtape 6 : Couvrir et cuire 25min au four.",
            datePublished: "",
            category: "Plat secondaire 🥙"
        ),
    ]
}


