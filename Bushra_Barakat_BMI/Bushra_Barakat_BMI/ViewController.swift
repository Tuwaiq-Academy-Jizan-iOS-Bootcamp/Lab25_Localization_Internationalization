//
//  ViewController.swift
//  Bushra_Barakat_BMI
//
//  Created by Bushra Barakat on 03/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculatButton: UIButton!{
        didSet{
            calculatButton.setTitle("Calculate".localized, for: .normal)
        }
    }
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var descripationLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!{
        didSet{
            heightLabel.text = "height".localized
        }
    }
    @IBOutlet weak var weightLabel: UILabel!{
        didSet{
            weightLabel.text = "weight".localized
        }
    }
    
    @IBOutlet weak var langugeChangeSegmented: UISegmentedControl!{
        didSet {
            if let language = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch language {
                case "ar":
                    langugeChangeSegmented.selectedSegmentIndex = 0
                case "en":
                    langugeChangeSegmented.selectedSegmentIndex = 1
                case "fr":
                    langugeChangeSegmented.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         langugeChangeSegmented.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         langugeChangeSegmented.selectedSegmentIndex = 2
                     }else {
                         langugeChangeSegmented.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     langugeChangeSegmented.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     langugeChangeSegmented.selectedSegmentIndex = 2
                 }else {
                     langugeChangeSegmented.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
// ______________________for toolbar________________
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title:"done".localized,style: UIBarButtonItem.Style.done ,target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace,doneButton] , animated: false)
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
        
        
    }
    @objc func doneClicked() {
        view.endEditing(true)
    }

    @IBAction func buttonCalculatResult(_ sender: Any) {
    if let heightText = heightTextField.text,
       let weightText = weightTextField.text {
       let calculationFormater = NumberFormatter()
        
    if let heightNumber = calculationFormater.number(from: heightText),
       let weightNumber = calculationFormater.number(from: weightText) {
        
       let height = Double(truncating: heightNumber)
       let weight = Double(truncating: weightNumber)
       let bmi = weight / pow(height,2)
       let displayFormatter = NumberFormatter()
        displayFormatter.maximumFractionDigits = 2
        bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
        descripationLabel.text = getBMIDescription(bmi)
        
        }
            
        
    }else {
        let alert = UIAlertController(title: "error", message: "please add height and weight in correct formate", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
     }
    
    }
    @IBAction func langugeSegmented(_ sender:UISegmentedControl) {
        if let language = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
            if language == "ar"{
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                  }else{
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                  }
            UserDefaults.standard.set(language, forKey: "currentLanguage")
            Bundle.setLanguage(language)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
    
    
    func getBMIDescription(_ bmi:Double) -> String {
        switch bmi {
        case 0...18.4:
            return "Under Weight".localized
        case 18.5...24.9:
            return "Normal Weight".localized
        case 25...30:
            return "Over Weight".localized
        default:
            return "Obese".localized
        }
    }
    
}
extension String{
    var localized: String{
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

