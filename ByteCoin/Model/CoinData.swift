//
//  CoinData.swift
//  ByteCoin
//
//  Created by Diana Vacareanu on 13.05.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
// can decode itself form an external representation
struct CoinData :  Decodable {
    let time : String
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double

}
