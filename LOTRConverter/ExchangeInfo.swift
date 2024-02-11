//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Gaurav Rawat on 2024-02-06.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                Text("Exchange Rates")
                    .tracking(3)
                    .font(.largeTitle)
                    .padding(.vertical)
                
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                
                ExchangeRate(leftCurrencyRate: "1 Ring", leftCurrencyImage: .thering,
                    rightCurrencyRate: "1000 Gold Piece", rightCurrencyImage: .goldpiece)
                
                ExchangeRate(leftCurrencyRate: "1 Gold Piece", leftCurrencyImage: .goldpiece,
                                  rightCurrencyRate: "4 Gold Pennies", rightCurrencyImage: .goldpenny)
                
                ExchangeRate(leftCurrencyRate: "1 Gold Penny", leftCurrencyImage: .goldpenny,
                                  rightCurrencyRate: "4 Silver Pieces", rightCurrencyImage: .silverpiece)
                
                ExchangeRate(leftCurrencyRate: "1 Silver Piece", leftCurrencyImage: .silverpiece,
                                  rightCurrencyRate: "4 Silver Pennies", rightCurrencyImage: .silverpenny)
                
                ExchangeRate(leftCurrencyRate: "1 Silver Penny", leftCurrencyImage: .silverpenny,
                                  rightCurrencyRate: "100 Copper Pennies", rightCurrencyImage: .copperpenny)
                              
                
                Button{
                        dismiss()
                }label: {
                    Text("DONE")
                }
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .padding(.top)
             
                Spacer()
            }
            .foregroundColor(.black)
        }
    }
    
     struct ExchangeRate:  View {
        
         @State var leftCurrencyRate: String = ""
         @State var leftCurrencyImage: ImageResource
         @State var rightCurrencyRate: String = ""
         @State var rightCurrencyImage: ImageResource
         
         var body: some View{
             HStack{
                 Image(leftCurrencyImage)
                     .resizable()
                     .scaledToFit()
                     .frame(height: 30)
                 Text(leftCurrencyRate)
                 
                 Image(systemName: "equal")
                     .font(.title3)
                     .foregroundStyle(.black)
                     .symbolEffect(.pulse)
                 
                 Text(rightCurrencyRate)
                 Image(rightCurrencyImage)
                     .resizable()
                     .scaledToFit()
                     .frame(height: 30)
             }
         }
    }
    
    
}

#Preview {
    ExchangeInfo()
}
