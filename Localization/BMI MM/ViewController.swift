//
//  ViewController.swift
//  BMI MM
//
//  Created by موسى مسملي on 07/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bmiDescriptionLabel: UILabel!
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
    // we need the below logic to fix the problem when we click on te segmentControl and we get reseted to the default behaviour
    @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                case "fr":
                    languageSegmentControl.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         languageSegmentControl.selectedSegmentIndex = 2
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     languageSegmentControl.selectedSegmentIndex = 2
                 }else {
                     languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
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
            // based on the local we will gate 1.6 or 1,7 so we need to change all input to Double to do that we need to use number formatter to convert string to NSNumber and then convert that to double and after that we do the calculation and reformat the Double output to String (using another formater to respect the local , or .)
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                bmiDescriptionLabel.text = getBMIDescription(bmi)
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


