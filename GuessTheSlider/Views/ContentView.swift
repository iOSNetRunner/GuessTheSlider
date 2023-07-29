//
//  ContentView.swift
//  GuessTheSlider
//
//  Created by Dmitrii Galatskii on 29.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var startNumber = Float.random(in: 1...100).rounded()
    @State private var selectedValue: Int = 0
    @State private var alertPresented = false
    
    var body: some View {
        VStack {
            Text("Move slider as close as possible to: \(startNumber.formatted())")
            
            HStack {
                Text("0")
                UISliderRepresentation(value: $selectedValue, action: computeScore)
                Text("100")
            }
            .padding()
            
            Button {
                alertPresented = true
            } label: {
                Text("Check me!")
            }
            .alert(isPresented: $alertPresented) {
                Alert(title: Text("SCORE"), message:
                        computeScore() != 100
                      ? Text("\n🏆 Points scored: \(computeScore()) 🏆")
                      : Text("\n 🥇 WIN 🥇 \n\nPoints scored: \(computeScore())")
                )
            }
            .padding(.bottom, 20)
            
            Button {
                startNumber = Float.random(in: 1...100).rounded()
            } label: {
                Text("Restart")
            }
        }
        .padding()
    }
    
    
    private func computeScore() -> Int {
        let targetValue = Double(startNumber)
        let currentValue = Double(selectedValue)
        let difference = abs(lround(targetValue) - lround(currentValue))
        return Int(100 - difference)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
