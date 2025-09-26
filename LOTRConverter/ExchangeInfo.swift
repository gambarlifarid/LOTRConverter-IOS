//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Farid Gambarli on 12.06.25.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            //Background parchment image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Title text
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3) // (space between letters)
                
                // Description text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                
                // Exchange rates
                ExchangeRate(leftImage: .goldpiece, rightImage: .goldpenny, text: "1 Gold Piece = 4 Gold Pennies")
                
                ExchangeRate(leftImage: .goldpenny, rightImage: .silverpiece, text: "1 Gold Penny = 4 Silver Pieces")
                
                ExchangeRate(leftImage: .silverpiece, rightImage: .silverpenny, text: "1 Silver Piece = 4 Silver Pennies")
                
                ExchangeRate(leftImage: .silverpenny, rightImage: .copperpenny, text: "1 Silver Penny = 100 Copper Pennies")

                
                // Done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white) // (for dark mode)
            }
            .foregroundStyle(.black) // (for dark mode)
        }
    }
}

#Preview {
    ExchangeInfo()
}


