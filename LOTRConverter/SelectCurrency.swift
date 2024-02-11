//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Gaurav Rawat on 2024-02-08.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedCurrencyFrom: CurrencyEnum
    @Binding var selectedCurrencyTo: CurrencyEnum
    
    var body: some View {
        ZStack{
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                Text("Select the currncy you are starting with: ")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                
                CurrencyGridView(selectedCurrency: $selectedCurrencyFrom)

                
                Text("Select the currncy you would like to convert to: ")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    
                CurrencyGridView(selectedCurrency: $selectedCurrencyTo)


                Spacer()
                
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
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(selectedCurrencyFrom: .constant(.silverPiece), selectedCurrencyTo: .constant(.goldPiece))
}






struct Currency: View {
    @State var currencyImage: ImageResource
    @State var currencyText: String
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            Text(currencyText)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.brown.opacity(0.75))
                .foregroundColor(.black)
        }
        .padding(3)
        .background(.brown)
        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .clipShape(.rect(cornerRadius: 25))
    }
}

enum CurrencyEnum: Double, CaseIterable, Identifiable{
    
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    case theRing = 0.001
    
    var id: CurrencyEnum { self }
    
    var image: ImageResource{
        switch self{
            case .copperPenny: .copperpenny
            case .silverPenny: .silverpenny
            case .silverPiece: .silverpiece
            case .goldPenny: .goldpenny
            case .goldPiece: .goldpiece
            case .theRing: .thering
        }
    }
    
    var name: String{
        switch self{
            case .copperPenny: "Copper Penny"
            case .silverPenny: "Silver Penny"
            case .silverPiece: "Silver Piece"
            case .goldPenny: "Gold Penny"
            case .goldPiece: "Gold Piece"
            case .theRing: "The Ring"
        }
    }
    
    func convertCurrency(_ amountString: String, to currency: CurrencyEnum) -> String{
        
        guard let doubleAmount = Double(amountString) else{
            return ""
        }
        
        let convertedValue = (doubleAmount / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedValue)
    }
}

struct CurrencyGridView: View {
    @Binding var selectedCurrency: CurrencyEnum
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(CurrencyEnum.allCases){ currency in
                
                if selectedCurrency == currency {
                    Currency(currencyImage: currency.image, currencyText: currency.name)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay{
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                                .foregroundColor(.black)
                        }
                }
                else {
                    Currency(currencyImage: currency.image, currencyText: currency.name)
                        .onTapGesture {
                            selectedCurrency = currency
                        }
                }
            }
        }
    }
}
