//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Mikhail Polevin on 03.12.2019.
//  Copyright © 2019 Mikhail Polevin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var recipesPotatoViewModel: RecipesPotatoViewModel
    @EnvironmentObject var recipesCheeseViewModel: RecipesCheeseViewModel
    @EnvironmentObject var recipesCucumberViewModel: RecipesCucumberViewModel
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            RecipePotatoListView()
                .tag(0)
                .tabItem {
                    VStack {
                        Text("First")
                        Image(systemName: "rectangle")
                    }
            }
            RecipeCucumberListView()
                .tag(1)
                .tabItem {
                    VStack {
                        Text("Second")
                        Image(systemName: "triangle")
                    }
            }
            RecipeCheeseListView()
                .tag(2)
                .tabItem {
                    VStack {
                        Text("Third")
                        Image(systemName: "circle")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
