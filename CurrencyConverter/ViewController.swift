//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Fatih Oğuz on 31.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tryLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var eurLabel: UILabel!
    
    @IBOutlet weak var cadLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func ratesButton(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=68b9d6c7f47656df93964eab5aa79bc9")
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okAlert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAlert)
                self.present(alert, animated: true, completion: nil)
            }else {
                
                if data != nil {
                    
                    do {
                     
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let eur = rates["EUR"] as? Double {
                                    self.eurLabel.text = "EUR : \(eur)"
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                            }
                        
                        }
                        
                    }catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
        
        
        
    }
    
}

