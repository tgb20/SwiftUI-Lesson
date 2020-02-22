//
//  ContentView.swift
//  SwiftUI-Lesson
//
//  Created by Jacob Bashista on 2/22/20.
//  Copyright © 2020 Jacob Bashista. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Make sure these match image asset names, image assets should be in 3x slot
    @State private var robots = ["Ava", "Baymax", "C-3PO", "Iron Giant", "Maria", "Robby", "RoboCop", "Robot Police"].shuffled() // Randomize the robot array
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // State variables are used when they update in the UI
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            // Color.blue.edgesIgnoringSafeArea(.all) // Fill background with the color blue
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom) .edgesIgnoringSafeArea(.all) // Fill the background with a gradient from blue to purple
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the robot named")
                        .foregroundColor(.white)
                    Text(robots[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // Robot was tapped
                        self.robotTapped(number)
                    }) {
                        Image(self.robots[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 20)) // Lots of different shapes (Circle, Rectangle, Rounded Rectangle, Capsule)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1)) // Simple border that matches shape
                            .shadow(color: .black, radius: 2)

                    }
                }
                
                Spacer() // Push content to top of the screen
            }
        }
    .alert(isPresented: $showingScore, content: {
        Alert(title: Text(scoreTitle),
              message: Text("Your score is \(score)"),
              dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
    })
        
    }
    
    func robotTapped(_ number: Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        robots.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
