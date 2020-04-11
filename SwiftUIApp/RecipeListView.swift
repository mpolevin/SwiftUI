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

    @Published private(set) var items: [Recipe] = [Recipe]()
    @Published private(set) var page: Int = 0
    @Published private(set) var isPageLoading: Bool = false
    
    func loadPage(pageType: RecipeListView.PageType)  {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true
        page += 1
        var dish = ""
        var ingredients = ""
        switch pageType {
        case .potato:
            dish = "potato pancakes"
            ingredients = "patato,egg"
        case .cheese:
            dish = "sandwich"
            ingredients = "cheese"
        case .cucumber:
            dish = "salad"
            ingredients = "cucumber"
        }
        RecipeAPI.getRecipe(i: ingredients, q: dish, p: page) { response, error in
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

    @EnvironmentObject var viewModel: RecipesViewModel
    
    let item: Recipe
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.title ?? "")
                .font(.headline)
            Text(item.ingredients ?? "")
                .font(.callout)
                .foregroundColor(.gray)
            
            if self.viewModel.isPageLoading && self.viewModel.items.isLast(item) {
                Divider()
                Text("Loading...")
            }
        }
    }
}

struct RecipeListView: View {

    enum PageType: Int {
        case potato
        case cheese
        case cucumber
    }
    
    var pageType: PageType = .potato
    @EnvironmentObject var viewModel: RecipesViewModel

    var body: some View {
        
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    RecipeRow(item: item)
                    .onAppear() {
                        if self.viewModel.items.isLast(item) {
                            self.viewModel.loadPage(pageType: self.pageType)
                        }
                    }
                }
            }
            .navigationBarTitle("Recipes")
            .onAppear() {
                self.viewModel.loadPage(pageType: self.pageType)
            }
        }
    }
    
}
