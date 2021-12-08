//
//  ViewController.swift
//  Bmi2
//
//  Created by Afrah Omar on 02/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bmiDescriptionLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
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

    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl!
    {
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
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
                 let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
               let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
                 toolbar.setItems([flexSpace, doneBtn], animated: false)
                 toolbar.sizeToFit()
                 self.weightTextField.inputAccessoryView = toolbar
                 self.heightTextField.inputAccessoryView = toolbar

           }
          @objc func doneButtonAction() {
              self.view.endEditing(true)
           }

    
    @IBAction func languageChanged(_ sender: UISegmentedControl){
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
            let alert = UIAlertController(title: "error", message: "C", preferredStyle: .alert)
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
    
