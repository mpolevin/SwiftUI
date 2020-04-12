//
//  RecipesViewModel.swift
//  SwiftUIApp
//
//  Created by Mikhail Polevin on 11.04.2020.
//  Copyright © 2020 Mikhail Polevin. All rights reserved.
//

import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    
    @Published var items: [Recipe] = [Recipe]()
    @Published var page: Int = 1
    @Published var isPageLoading: Bool = false
    
    func loadPage() {
       
    }
}

class RecipesPotatoViewModel: RecipesViewModel {
    
    override func loadPage() {
        RecipeAPI.getRecipe(i: "patato,egg", q: "potato pancakes", p: page) { response, error in
            if let results = response?.results {
                self.items.append(contentsOf: results)
            }
            self.isPageLoading = false
        }
    }
}

class RecipesCheeseViewModel: RecipesViewModel {
    
    override func loadPage() {
        RecipeAPI.getRecipe(i: "cheese", q: "sandwich", p: page) { response, error in
            if let results = response?.results {
                self.items.append(contentsOf: results)
            }
            self.isPageLoading = false
        }
    }
}

class RecipesCucumberViewModel: RecipesViewModel {
    
    override func loadPage() {
        RecipeAPI.getRecipe(i: "cucumber", q: "salad", p: page) { response, error in
            if let results = response?.results {
                self.items.append(contentsOf: results)
            }
            self.isPageLoading = false
        }
    }
}

extension Recipe: Identifiable {
    public var id: String {
        self.title ?? UUID().uuidString
    }
}

struct RecipeRow: View {
    
    let item: Recipe
    let isPageLoading: Bool
    let isLast: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.title ?? "")
                .font(.headline)
            Text(item.ingredients ?? "")
                .font(.callout)
                .foregroundColor(.gray)
            
            if isPageLoading && isLast {
                Divider()
                Text("Loading...")
            }
        }
    }
}

struct RecipePotatoListView: View {
    
    @EnvironmentObject var viewModel: RecipesPotatoViewModel
    
    var body: some View {
        
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    RecipeRow(item: item, isPageLoading: self.viewModel.isPageLoading, isLast: self.viewModel.items.isLast(item))
                        .onAppear() {
                            if self.viewModel.items.isLast(item) {
                                self.viewModel.loadPage()
                            }
                    }
                }
            }
            .navigationBarTitle("Recipes with Potato")
            .onAppear() {
                self.viewModel.loadPage()
            }
        }
    }
    
}

struct RecipeCucumberListView: View {
    
    @EnvironmentObject var viewModel: RecipesCucumberViewModel
    
    var body: some View {
        
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    RecipeRow(item: item, isPageLoading: self.viewModel.isPageLoading, isLast: self.viewModel.items.isLast(item))
                        .onAppear() {
                            if self.viewModel.items.isLast(item) {
                                self.viewModel.loadPage()
                            }
                    }
                }
            }
            .navigationBarTitle("Recipes with Cucumber")
            .onAppear() {
                self.viewModel.loadPage()
            }
        }
    }
    
}

struct RecipeCheeseListView: View {
    
    @EnvironmentObject var viewModel: RecipesCheeseViewModel
    
    var body: some View {
        
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    RecipeRow(item: item, isPageLoading: self.viewModel.isPageLoading, isLast: self.viewModel.items.isLast(item))
                        .onAppear() {
                            if self.viewModel.items.isLast(item) {
                                self.viewModel.loadPage()
                            }
                    }
                }
            }
            .navigationBarTitle("Recipes with Cheese")
            .onAppear() {
                self.viewModel.loadPage()
            }
        }
    }
    
}

