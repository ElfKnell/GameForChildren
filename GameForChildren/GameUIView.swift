//
//  GameUIView.swift
//  GameForChildren
//
//  Created by Andrii Kyrychenko on 01/08/2022.
//

import SwiftUI

struct GameUIView: View {
    
    var numberQuetion: Int
    var number1: Int
    @State private var alertNotNumber = false
    @State private var answer = ""
    @State private var answers = [String]()
    @State private var number2 = Int.random(in: 2...12)
    @State private var score = 0
    @State private var alertResult = false
    @State private var numberQ = -2
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Question \(numberQ == -2 ? numberQuetion : numberQ )")
            
            List {
                HStack{
                    Text("\(number1) * \(number2) = ")
                    TextField("", text: $answer)
                    Button("OK") {
                        myAnswer()
                    }
                }
                .alert("Is not number", isPresented: $alertNotNumber) {
                    Button ("repeat") {
                        badNumber()
                    }
                } message: {
                    Text("You entered a value that does not match to the numbers, please repeat")
                }
                
                Section {
                    ForEach(answers, id: \.self) {
                        Text($0)
                    }
                }
            }
            .sheet(isPresented: $isMenu) {
                ContentView()
            }
        }
        .alert("Game over", isPresented: $alertResult) {
            Button("New game") {
                endGame()
            }
            Button("Menu") {
                dismiss()
            }
        } message: {
            Text("Game is finished your score \(score)")
        }
        .navigationTitle("Multiplication")
    }
    
    func badNumber() {
        answer = ""
    }
    
    func endGame() {
        answer = ""
        answers = []
        numberQ = -2
    }
    
    func myAnswer() {
        
        let st: String
        guard let resultU = Int(answer) else {
            alertNotNumber = true
            return
        }
       
       if numberQ == -2 {
           numberQ = numberQuetion - 1
       } else {
           numberQ -= 1
       }
        
        if number1 * number2 == resultU {
            st = "\(number1) * \(number2) = \(number1 * number2) your answer \(resultU) ✅"
            answers.append(st)
            score += 1
        } else {
            st = "\(number1) * \(number2) = \(number1 * number2) your answer \(resultU) ❌"
            answers.append(st)
        }
        number2 = Int.random(in: 2..<13)
        answer = ""
        if numberQ == -1 {
            alertResult = true
        }
    }
}

struct GameUIView_Previews: PreviewProvider {
    static var previews: some View {
        GameUIView(numberQuetion: 0, number1: 1)
    }
}
