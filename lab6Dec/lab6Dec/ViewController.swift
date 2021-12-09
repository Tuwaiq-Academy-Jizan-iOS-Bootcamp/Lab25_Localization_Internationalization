//
//  ViewController.swift
//  lab6Dec
//
//  Created by Ahlam Ahlam on 02/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bmiDescription: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var calculateBut: UIButton!
    @IBOutlet weak var textWight: UITextField!
    @IBOutlet weak var wightLabel: UILabel! {
        
        didSet{
           wightLabel.text = "wight".localized
        }
    }
    
    @IBOutlet weak var textHight: UITextField!
    @IBOutlet weak var hightLabel: UILabel!{
        didSet {
            hightLabel.text = "hight".localized
        }
    }
    
    @IBOutlet weak var changeLanguage: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    changeLanguage.selectedSegmentIndex = 0
                case "en":
                    changeLanguage.selectedSegmentIndex = 1
                case "fr":
                    changeLanguage.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         changeLanguage.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         changeLanguage.selectedSegmentIndex = 2
                     }else {
                         changeLanguage.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     changeLanguage.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     changeLanguage.selectedSegmentIndex = 2
                 }else {
                     changeLanguage.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar()
                 toolBar.sizeToFit()

                 let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneCliked))
         //        doneButton.title = "done".localized
                 toolBar.setItems([doneButton], animated: false)

                 toolBar.setItems([doneButton], animated: false)

//
//                 upperNumberTextFiled.inputAccessoryView = toolBar
//                 bottomNumberTextfeild.inputAccessoryView = toolBar
             }

             @objc func doneCliked () {


                     view.endEditing(true)
   
        }
    
    
    
    @IBAction func languageChange(_ sender: UISegmentedControl) {
        if let weightText = textWight.text,
           let heightText = textHight.text{
            // based on the local we will gate 1.6 or 1,7 so we need to change all input to Double to do that we need to use number formatter to convert string to NSNumber and then convert that to double and after that we do the calculation and reformat the Double output to String (using another formater to respect the local , or .)
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                bmiDescription.text = getBMIDescription(bmi)
            }
            
        }else {
            let alert = UIAlertController(title: "error", message: "please add height and width in the correct format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getBMIDescription(_ bmi:Double) -> String {
        switch bmi {
        case 0...18.4:
            return "underweight".localized
        case 18.5...24.9:
            return "normal".localized
        case 25...30:
            return "overweight".localized
        default:
            return "obese".localized
        }
    }
    
    
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

