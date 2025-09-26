//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Farid Gambarli on 09.06.2    x5.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showEchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency = Currency.load(key: "leftCurrency", fallback: .silverPiece) // or
    @State var rightCurrency: Currency = Currency.load(key: "rightCurrency", fallback: .goldPiece)
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    leftTyping = false
                    rightTyping = false
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Conversion section
                HStack {
                    // Left conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        // Text field
                        TextField("Amount", text: $leftAmount) // binding string($)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .onChange(of: leftAmount) {
                                if leftTyping {
                                    rightAmount =  leftCurrency.convert( leftAmount, to: rightCurrency)
                                }
                            }
                            .onChange(of: leftCurrency) {
                                leftAmount = rightCurrency.convert( rightAmount, to: leftCurrency)
                                Currency.save(leftCurrency, key: "leftCurrency")
                            }
                    }
                    // Equal sign
                    Image(systemName: "equal") // SF symb. can be treated as Txt and Img
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        
                        // Text field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .onChange(of: rightAmount) {
                                if rightTyping {
                                    leftAmount = rightCurrency.convert( rightAmount, to: leftCurrency)
                                }
                            }
                            .onChange(of: rightCurrency) {
                                rightAmount = leftCurrency.convert( leftAmount, to: rightCurrency)
                                Currency.save(rightCurrency, key: "rightCurrency")
                            }
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    
                    Button {
                        showEchangeInfo.toggle()
                        //                        print("showExchangeInfo value: \(showEchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
                
            }
//            .border(.blue)
        }
        .task {
            try? Tips.configure()
        }
        .sheet(isPresented: $showEchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}
