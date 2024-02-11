//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Gaurav Rawat on 2024-02-10.
//

import Foundation
import TipKit

struct CurrencyTip: Tip{
    var title = Text("Change Currency")
    
    var message: Text? = Text("You can tap left or right currency to bring up the Select Currency Screen.")
}
