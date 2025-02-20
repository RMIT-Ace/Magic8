//
//  ContentView.swift
//  Magic8
//
//  Created by ace on 20/2/2025.
//

import SwiftUI

let choicesArray = [
        "It is certain",
        "It is decidedly so",
        "Without a doubt",
        "Yes, definitely",
        "You may rely on it",
        "As I see it, yes",
        "Most likely",
        "Outlook good",
        "Yes",
        "Signs point to yes",
        "Reply hazy try again",
        "Ask again later",
        "Better not tell you now",
        "Cannot predict now",
        "Concentrate and ask again",
        "Don't count on it",
        "My reply is no",
        "My sources say no",
        "Outlook not so good",
        "Very doubtful"
    ]

struct ContentView: View {
    @State private var predictionNumber: Int = 3
    @State private var choiceNumber: Int = 0
    @State private var animationDelay: Double = 0.3
    
    let animationPerNumber: Double = 0.3
    let innerBallWidth: CGFloat = 105
    let maxNumberOfBalls: Int = choicesArray.count

    var body: some View {
        VStack(spacing: 0) {
            predictionView()
                .padding(0)
            ZStack {
                ballImageView()
                numberBallsView(currentNumber: predictionNumber, maxNumber: maxNumberOfBalls)
                controlPanelView()
            }
            .padding(0)
            .animation(.linear(duration: animationDelay), value: predictionNumber)
        }
    }
    
    func predictionView() -> some View {
        Text("\(choicesArray[choiceNumber])")
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 28, weight: .bold, design: .default))
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 60)
            .padding(20)
            .padding(.vertical, 20)
            .background(.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 20)
    }
    
    func ballImageView() -> some View {
        Image("predict-ball-image")
            .resizable()
            .foregroundStyle(.tint)
            .frame(width: 300, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func controlPanelView() -> some View {
        VStack {
            Spacer()
            Stepper(value: $predictionNumber, in: 0...maxNumberOfBalls - 1)  {
                Button {
                    predictionNumber = Int.random(in: 0..<maxNumberOfBalls)
                    let distance = abs(predictionNumber - choiceNumber)
                    animationDelay = animationPerNumber / 2.0 * Double(distance)
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                        choiceNumber = predictionNumber
                    }
                } label: {
                    Spacer()
                    Text("Predict")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
            } onEditingChanged: { _ in
//                animationDelay = animationPerNumber
                animationDelay = 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                    choiceNumber = predictionNumber
                }
            }
        }
        .frame(width: 300, height: 400)
    }
    
    @ViewBuilder
    func numberBallsView(currentNumber: Int = 0, maxNumber: Int = 3) -> some View {
        let shifting: CGFloat = CGFloat(maxNumber) / 2.0
        let outerBallWidth: CGFloat = 100
        ZStack {
            HStack(spacing: 0) {
                ForEach(0..<maxNumber, id: \.self) { index in
                    Text("\(index)")
                        .font(Font.system(size: 72, weight: .bold))
                        .frame(width: innerBallWidth)
                }
            }
            .frame(width: 8000, height: 100)
            .offset(x: CGFloat(shifting) * innerBallWidth - (innerBallWidth * CGFloat(currentNumber)) - (outerBallWidth / 2.0))
        }
        .frame(width: outerBallWidth, height: outerBallWidth)
        .padding()
        .background(Color.green)
        .clipShape(Circle())
        .padding(.bottom)
    }
    
}

#Preview {
    ContentView()
}
