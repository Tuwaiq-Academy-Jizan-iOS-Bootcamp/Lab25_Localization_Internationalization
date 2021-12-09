//
//  ViewController.swift
//  Lab25_Localization_Internationalization
//
//  Created by Faten Abdullh salem on 04/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
@IBOutlet weak var BmiDescriptionLabel: UILabel!
@IBOutlet weak var bmiLabel: UILabel!
@IBOutlet weak var calculateButton: UIButton!
    
@IBOutlet weak var heightLabel: UILabel! {
    didSet {
    heightLabel.text = "height".localized
    }
}
@IBOutlet weak var weightLabel: UILabel!{
    didSet {
    weightLabel.text = "weight".localized
}
    
}
    
@IBOutlet weak var heightTextField: UITextField!
@IBOutlet weak var weightTextField: UITextField!
    
@IBOutlet weak var languageSegmentControl: UISegmentedControl! {
        didSet {
            
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                }
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 }else {
                     languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.doneClicked))

        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
       
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicked () {
        view.endEditing(true)
    }

@IBAction func languageChanged(_ sender: Any) {
    if let lang = (sender as AnyObject).titleForSegment(at:(sender as AnyObject).selectedSegmentIndex)?.lowercased() {
        UserDefaults.standard.set(lang, forKey: "currentLanguage")
        Bundle.setLanguage(lang)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
    }
    }
@IBAction func calculateBMI(_ sender: Any) {
    if let weightText = weightTextField.text,
       let heightText = heightTextField.text{
        let calculationFormatter = NumberFormatter()
        if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
            let height = Double(truncating: heightNumber)
            let weight = Double(truncating: weightNumber)
            let bmi = weight / pow(height,2)
            let displayFormatter = NumberFormatter()
            displayFormatter.maximumFractionDigits = 2
            bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
            BmiDescriptionLabel.text = getBMIDescription(bmi)
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

