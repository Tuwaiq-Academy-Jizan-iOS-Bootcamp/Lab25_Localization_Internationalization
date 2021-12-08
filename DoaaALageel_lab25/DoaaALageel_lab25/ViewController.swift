//
//  ViewController.swift
//  DoaaALageel_lab25
//
//  Created by Dua'a ageel on 04/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var changeLangugeOutLet: UISegmentedControl! {
    
    didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
              
                switch lang {
                case "ar":
                    changeLangugeOutLet.selectedSegmentIndex = 1
                case "en":
                    
                    changeLangugeOutLet.selectedSegmentIndex = 0
                
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "en" {
                         changeLangugeOutLet.selectedSegmentIndex = 0
                         
                     } else {
                         changeLangugeOutLet.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "en" {
                     changeLangugeOutLet.selectedSegmentIndex = 0
                 } else {
                     changeLangugeOutLet.selectedSegmentIndex = 1
                 }
            }
        }
        }
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var heighTextField: UITextField!
    
    
    @IBOutlet weak var heightLable: UILabel!
    
    {
            didSet {
                heightLable.text = "height".localized
            }
        }
    
    
    
    
    @IBOutlet weak var weightLable: UILabel!
    
    
    
    {
            didSet {
                weightLable.text = "weight".localized
            }
        }
    
    @IBOutlet weak var calculateButton: UIButton!
    {
            didSet {
        calculateButton.setTitle(NSLocalizedString("CalculateBMI", tableName: "Localizable", comment: ""), for: .normal)
            }
            
        }
    
    @IBOutlet weak var descriptionLable: UILabel!
    
    @IBOutlet weak var resultLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
                  let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
                let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
                  toolbar.setItems([flexSpace, doneBtn], animated: false)
                  toolbar.sizeToFit()
                  self.weightTextField.inputAccessoryView = toolbar
                  self.heighTextField.inputAccessoryView = toolbar
          
            }
           @objc func doneButtonAction() {
               self.view.endEditing(true)
            }
        
        
        
        
        
        
   
    @IBAction func calculateChangeAC(_ sender: UIButton) {
        if let weightText = weightTextField.text,
                   let heightText = heighTextField.text{
                   
                    let calculationFormatter = NumberFormatter()
                    if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                        let height = Double(truncating: heightNumber)
                        let weight = Double(truncating: weightNumber)
                        let bmi = weight / pow(height,2)
                        let displayFormatter = NumberFormatter()
                        displayFormatter.maximumFractionDigits = 2
                        resultLable.text = displayFormatter.string(from: NSNumber(value: bmi))
                        descriptionLable.text = getBMIDescription(bmi)
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

    @IBAction func changeLanguageAC(_ sender: UISegmentedControl) {
        
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
                    if lang == "ar"{
                       
                     
                        UIView.appearance().semanticContentAttribute = .forceRightToLeft
                    }else{
                        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                    }
                    UserDefaults.standard.set(lang, forKey: "currentLanguage")
                    Bundle.setLanguage(lang)
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                        
                    }
                }
        
    
    }
}

extension String {
    var localized: String {

        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
        
       
    }
}
