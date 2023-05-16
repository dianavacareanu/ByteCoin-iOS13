//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation



protocol CoinManagerDelegate {
    func didUpdateCoin(currencyPrice : String, currencyName : String)
    func didFailWithError( error : Error)
    
}
struct CoinManager {
    
   
    // be aware of http and https bcs apple doesnt let you use http bcs of secure reasons
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "43161CC5-FE3B-4BE2-B945-7818B4B69DF6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    // https://rest.coinapi.io/v1/exchangerate/BTC/{asset_id_quote}?&apikey=43161CC5-FE3B-4BE2-B945-7818B4B69DF6
    
    var delegate:CoinManagerDelegate?
    
    
    func fetchCurrency(for currencyName : String){
        let urlString = "\(baseURL)/\(currencyName)?apiKey=\(apiKey)"
        
        print(urlString)
        
        //1.create a url
        if let url = URL(string: urlString) {
            //2.create a url  session
            let session = URLSession(configuration: .default)
            //3.give the session a task . we can see that completionHandler is  a fucntion and we make a closure
            
            let task = session.dataTask(with: url) { (data, response , error) in
                if( error != nil ) {
                    print(error!)
                    // return keyword exit this program
                    return
                }
                
                if let safeData = data {
                    // we decode the json in format into a swift object
                    if let bitcoinPrice = parseJSON(coinData: safeData){
                        let currencyPrice = String(format: "%.2f" , bitcoinPrice)
                        self.delegate?.didUpdateCoin(currencyPrice: currencyPrice, currencyName: currencyName)
                    }}}
            //4. start task
            task.resume()
            
        }
    }
    
    
    
    func parseJSON(coinData : Data)-> Double?{
        let decoder = JSONDecoder()
        do{
            // my decoder recieve a type: T.Type, from data: Data
            let decodedData =  try decoder.decode(CoinData.self, from: coinData)
            print(decodedData.rate)
            let lastPrice = decodedData.rate
            return lastPrice
            
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
    
    
    
}
