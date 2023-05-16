//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource ,  CoinManagerDelegate{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row : Int , forComponent component : Int) -> String?{
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentCurrency = coinManager.currencyArray[row]
        print(coinManager.fetchCurrency(for: currentCurrency))
    }
  //Coin Manager Delegate
    func didUpdateCoin(currencyPrice: String, currencyName: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currencyPrice
            self.currencyLabel.text = currencyName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }


}

