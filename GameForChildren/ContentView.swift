//
//  ContentView.swift
//  GameForChildren
//
//  Created by Andrii Kyrychenko on 29/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var number1 = 2
    @State private var numberQuetion = 0
    @State private var quetionNum = 5
    @State private var quetionsNum = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    Stepper("\(number1)" , value: $number1, in: 2...12, step: 1)
                    
                } header: {
                    Text("Please select which multiplication table you want to practice:")
                    
                }
                
                Section {
                    
                    Picker("Questions", selection: $quetionNum) {
                        ForEach(quetionsNum, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Please select how many questions:")
                }
                
                Section {
                    NavigationLink("Start Game", destination: GameUIView(numberQuetion: quetionNum, number1: number1))

                }
            }
            .navigationTitle("Multiplication")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
