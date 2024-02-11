//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Gaurav Rawat on 2024-02-06.
//

import SwiftUI
import SwiftData
import TipKit

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
                    CurrencyView(Currency: $leftCurrency, amount: $leftAmount, typing: _leftTyping, showSelectCurrency: $showSelectCurrency)
                    .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                    
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    
                    CurrencyView(Currency: $rightCurrency, amount: $rightAmount, typing: _rightTyping, showSelectCurrency: $showSelectCurrency)
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
                    .task {
                        try? Tips.configure()
                    }
                    .onChange(of: leftAmount) {
                        if(leftTyping){
                            rightAmount = leftCurrency.convertCurrency(leftAmount, to: rightCurrency)
                        }
                    }
                    .onChange(of: rightAmount) {
                        if(rightTyping){
                            leftAmount = rightCurrency.convertCurrency(rightAmount, to: leftCurrency)
                        }
                    }
                    .onChange(of: leftCurrency){
                            leftAmount = rightCurrency.convertCurrency(rightAmount, to: leftCurrency)
                    }
                    .onChange(of: rightCurrency){
                            rightAmount = leftCurrency.convertCurrency(leftAmount, to: rightCurrency)
                    }
                    .sheet(isPresented: $showExchangeInfo, content: {
                        ExchangeInfo()
                    })
                    .sheet(isPresented: $showSelectCurrency, content: {
                        SelectCurrency(selectedCurrencyFrom: $leftCurrency, selectedCurrencyTo: $rightCurrency)
                    })
                }
            }
            
        }
        .onTapGesture {
            leftTyping = false
            rightTyping = false
        }
        
    }
}

#Preview {
    ContentView(leftAmount: "", rightAmount: "", leftCurrency: .silverPiece, rightCurrency: .goldPiece)
}



struct CurrencyView: View {
    @Binding var Currency: CurrencyEnum
    @Binding var amount: String
    @FocusState var typing
    @Binding var showSelectCurrency: Bool
    
    var body: some View {
        VStack{
            HStack{
                Image(Currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
                Text(Currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            
            TextField(
                "Amount",
                text: $amount
            )
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
            .focused($typing)
            
        }
    }
}
