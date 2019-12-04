//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Mikhail Polevin on 03.12.2019.
//  Copyright © 2019 Mikhail Polevin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            FirstView()
                .tabItem {
                    VStack {
                        Text("First")
                        Image(systemName: "rectangle")
                    }
            }
            .tag(0)
            SecondView()
                .tabItem {
                    VStack {
                        Text("Second")
                        Image(systemName: "triangle")
                    }
            }
            .tag(1)
            ThirdView()
                .tabItem {
                    VStack {
                        Text("Third")
                        Image(systemName: "circle")
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FirstView: View {
    
    var body: some View {

        Button(action: {
            
        }) {
            Text("Go to second view")
        }
    }
    
}


struct SecondView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SecondInnerView()) {
                    Text("First")
                }
                NavigationLink(destination: SecondInnerView()) {
                    Text("Second")
                }
                NavigationLink(destination: SecondInnerView()) {
                    Text("Third")
                }
            }
            .navigationBarTitle("Second Page")
        }
    }
    
}

struct SecondInnerView: View {
    
    var body: some View {
        Text("Second Inner Page")
    }
    
}

struct ModalView: View {
    
    var body: some View {
        Text("Modal")
    }
    
}

struct ThirdView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }) {
            Text("Show Modal")
        }
        .sheet(isPresented: $isPresented, content: { ModalView() })
    }
    
}
