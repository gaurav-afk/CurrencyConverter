//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Gaurav Rawat on 2024-02-06.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: CurrencyEnum = .silverPiece
    @State var rightCurrency: CurrencyEnum = .goldPiece
    
    var body: some View{
        
        ZStack{
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Currency Exchange")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
            
                HStack{
                    VStack{
                        HStack{
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        TextField(
                            "Amount",
                            text: $leftAmount
                        )
                        .textFieldStyle(.roundedBorder)
                        .focused($leftTyping)
                        .onChange(of: leftAmount) {
                            if(leftTyping){
                                rightAmount = leftCurrency.convertCurrency(leftAmount, to: rightCurrency)
                            }
                        }
                    }
                    
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    
                    VStack{
                        HStack{
                            
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                                Image(rightCurrency.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        TextField(
                            "Amount",
                            text: $rightAmount
                        )
                        .textFieldStyle(.roundedBorder)
                        .focused($rightTyping)
                        .onChange(of: rightAmount) {
                            if(rightTyping){
                                leftAmount = rightCurrency.convertCurrency(rightAmount, to: leftCurrency)
                            }
                        }
                        
                    }
                    
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button{
                        showExchangeInfo.toggle()
                    }label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo, content: {
                        ExchangeInfo()
                    })
                    .sheet(isPresented: $showSelectCurrency, content: {
                        SelectCurrency(selectedCurrencyFrom: $leftCurrency, selectedCurrencyTo: $rightCurrency)
                    })
                }
            }
        }
        
    }
}

#Preview {
    ContentView(leftAmount: "", rightAmount: "", leftCurrency: .silverPiece, rightCurrency: .goldPiece)
}


