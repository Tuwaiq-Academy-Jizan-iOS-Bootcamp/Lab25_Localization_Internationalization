//
//  ViewController.swift
//  JawaherAbuLahsah_BMI
//
//  Created by Jawaher Mohammad on 02/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var calculator: UIButton!{
        didSet{
            calculator.setTitle("calculator".localized, for: .normal)
            calculator.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentedControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentedControl.selectedSegmentIndex = 1
                case "fr":
                    languageSegmentedControl.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                    if localLang == "ar" {
                        languageSegmentedControl.selectedSegmentIndex = 0
                    } else if localLang == "fr"{
                        languageSegmentedControl.selectedSegmentIndex = 2
                    }else {
                        languageSegmentedControl.selectedSegmentIndex = 1
                    }
                    
                }
                
            }else {
                let localLang =  Locale.current.languageCode
                if localLang == "ar" {
                    languageSegmentedControl.selectedSegmentIndex = 0
                } else if localLang == "fr"{
                    languageSegmentedControl.selectedSegmentIndex = 2
                }else {
                    languageSegmentedControl.selectedSegmentIndex = 1
                }
            }
        }
    }
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var heightLabel: UILabel!{
        didSet {
            heightLabel.text = "height".localized
        }
    }
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!{
        didSet {
            weightLabel.text = "weight".localized
        }
    }
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var bmiResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "done".localized, style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClicke))
        toolBar.setItems([flexButton,doneButton], animated: false)
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicke(){
        view.endEditing(true)
    }
    
    @IBAction func languageChange(_ sender: UISegmentedControl) {
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
                print(lang)
                
            }
        }
        
        
    }
    @IBAction func calculatorButton(_ sender: UIButton) {
        
        if let weightText = weightTextField.text , let heightText = heightTextField.text{
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                var height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                height = 0.01 * height
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                bmiLabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                switch bmi {
                case 0...18.4:
                    bmiResultLabel.text = "undrtweigth".localized
                    bmiResultLabel.textColor = .red
                case 18.5...24.9:
                    bmiResultLabel.text = "normalweigth".localized
                    
                    bmiResultLabel.textColor = .green
                case 25...30:
                    bmiResultLabel.text = "overweigth".localized
                    bmiResultLabel.textColor = .orange
                default:
                    bmiResultLabel.text = "obese".localized
                    bmiResultLabel.textColor = .red
                }
            }
        }
    }
}
extension String{
    var localized: String {
        
        return NSLocalizedString(self, tableName: "Localization", bundle: .main, value: self, comment: self)
    }
}


