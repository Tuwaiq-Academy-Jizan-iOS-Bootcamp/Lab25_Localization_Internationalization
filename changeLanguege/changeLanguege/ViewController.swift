//
//  ViewController.swift
//  changeLanguege
//
//  Created by grand ahmad on 02/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
//    label
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
//    text field
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var wieghtTextField: UITextField!
//    total button
    @IBOutlet weak var calculateBMIButton: UIButton!
//    result total and descrip
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
//    segement controll
    
    @IBOutlet weak var languageBMI: UISegmentedControl! {
    didSet {
        if let lang = UserDefaults.standard.string(forKey: "currentLanguage"){
            switch lang {
        case "ar":
            languageBMI.selectedSegmentIndex = 0
        case "en":
            languageBMI.selectedSegmentIndex = 1
        case "fr" :
            languageBMI.selectedSegmentIndex = 2
            default:
                let localLang = Locale.current.languageCode
                if localLang == "ar" {
                    languageBMI.selectedSegmentIndex = 0
                }else if localLang == "fr" {
                    languageBMI.selectedSegmentIndex = 2
                }else {
                    languageBMI.selectedSegmentIndex = 1
                }
        }
        }else{
            let localLang = Locale.current.languageCode
            if localLang == "ar" {
                languageBMI.selectedSegmentIndex = 0
            }else if localLang == "fr" {
                languageBMI.selectedSegmentIndex = 2
            }else {
                languageBMI.selectedSegmentIndex = 1
            }
        }
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    @IBAction func languageChangeAction(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                print(lang)
            }
        }
    }

    @IBAction func calculateBMIAction(_ sender: Any) {
        if let weightText = wieghtTextField.text,
           let heightText = heightTextField.text{
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                descriptionLabel.text = getBMIDescription(bmi)
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


extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
}
