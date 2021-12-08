//
//  ViewController.swift
//  Interanationalzation
//
//  Created by Ehab Hakami on 01/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    // full name
    @IBOutlet weak var shoeResult: UILabel!
    
    
    @IBOutlet weak var BmiLabel: UILabel!
    
    @IBOutlet weak var wighitLabel: UILabel!
    var wight = ""
    
    @IBOutlet weak var highatLabel: UILabel!
    var highat = ""
    
    @IBOutlet weak var dataLabel: UILabel!
    var databmi = ""
    @IBOutlet weak var wighitTextField: UITextField!
    var wighitTxtf = ""
    @IBOutlet weak var highitTextField: UITextField!
    var highitTxtf = ""
    @IBOutlet weak var btnChangeLanguagh: UIButton!
    
    
    @IBOutlet weak var addBmibtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        wighitLabel.text = wight
//        highatLabel.text = highat
//        dataLabel.text = databmi
//        wighitTextField.text = wighitTxtf
//        highitTextField.text = highitTxtf
        
        // Do any additional setup after loading the view.
        wighitLabel.text = "wight".Localizable
        highatLabel.text = "hight".Localizable

        dataLabel.text = "eqwilBmi".Localizable

        BmiLabel.text = "Bmi".Localizable
       
        btnChangeLanguagh.setTitle(NSLocalizedString("ChangeLanguagh", comment: ""), for: .normal)
        addBmibtn.setTitle(NSLocalizedString("CalcuateBmi", comment: ""), for: .normal)
    }
    

    @IBAction func btnChangeLanguagh(_ sender: Any) {
        let currentLang = Locale.current.languageCode
        let newLanguage = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
        exit(0)
    }
    
    
    
    @IBAction func addbmibtn(_ sender: Any) {
//        if let wightText = wighitTextField.text, let hightText = highitTextField.text, let wight = Double(wightText), let higt = Double(hightText) {
//            let finalResult = wight / pow(higt,2)
//            dataLabel.text = "\(finalResult)"
            
        if let weightText = wighitTextField.text,
           let heightText = highitTextField.text{
            
            
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                dataLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                shoeResult.text = getBMI(bmi)

            }

            func getBMI(_ bmi:Double) -> String {
                switch bmi {
                case 0...18.4:
                    return "underweight".Localizable
                case 18.5...24.9:
                    return "normalweight".Localizable
                case 25...30:
                    return "obese".Localizable
                default:
                    return "gg"
                }
            }

            
            
        }else {
            let alert = UIAlertController(title: "error", message: "please add height and width in the correct format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        view.endEditing(true)
        
        
    }
    
    
    
    
}

extension String {
    var Localizable:String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
