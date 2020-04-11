//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Mikhail Polevin on 03.12.2019.
//  Copyright © 2019 Mikhail Polevin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            RecipeListView(pageType: .potato)
                .tag(0)
                .tabItem {
                    VStack {
                        Text("First")
                        Image(systemName: "rectangle")
                    }
            }
            RecipeListView(pageType: .cheese)
                .tag(1)
                .tabItem {
                    VStack {
                        Text("Second")
                        Image(systemName: "triangle")
                    }
            }
            RecipeListView(pageType: .cucumber)
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
