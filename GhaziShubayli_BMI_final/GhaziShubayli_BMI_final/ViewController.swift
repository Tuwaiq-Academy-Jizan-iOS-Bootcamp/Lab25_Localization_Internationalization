//
//  ViewController.swift
//  GhaziShubayli_BMI_final
//
//  Created by ماك بوك on 01/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bmiMainTitle: UILabel! {
        didSet {
            bmiMainTitle.text = "bodyMassIndex".localiz
        }
    }
    @IBOutlet weak var choseTheLanguage: UISegmentedControl! {
        didSet {
            if let language = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch language {
                case "ar":
                    choseTheLanguage.selectedSegmentIndex = 0
                case "en":
                    choseTheLanguage.selectedSegmentIndex = 1
                case "fr":
                    choseTheLanguage.selectedSegmentIndex = 2
                default:
                    let localLanguage =  Locale.current.languageCode
                    if localLanguage == "ar" {
                        choseTheLanguage.selectedSegmentIndex = 0
                    } else if localLanguage == "fr"{
                        choseTheLanguage.selectedSegmentIndex = 2
                    }else {
                        choseTheLanguage.selectedSegmentIndex = 1
                    }
                }
            }else {
                let localLanguage =  Locale.current.languageCode
                if localLanguage == "ar" {
                    choseTheLanguage.selectedSegmentIndex = 0
                } else if localLanguage == "fr"{
                    choseTheLanguage.selectedSegmentIndex = 2
                }else {
                    choseTheLanguage.selectedSegmentIndex = 1
                }
            }
        }
    }
    @IBOutlet weak var heightLabel: UILabel! {
        didSet {
            heightLabel.text = "height".localiz
        }
    }
    @IBOutlet weak var heightTextField: UITextField! {
        didSet {
            heightTextField.placeholder = "pleaseEnterYourHeighInMeterEg1.7".localiz
        }
    }
    @IBOutlet weak var weightLabel: UILabel! {
        didSet {
            weightLabel.text = "weight".localiz
        }
    }
    @IBOutlet weak var weightTextField: UITextField! {
        didSet {
            weightTextField.placeholder = "pleaseEnterYourWeight".localiz
        }
    }
    @IBOutlet weak var calculate: UIButton! {
        didSet {
            calculate.setTitle(NSLocalizedString("calculate", comment: ""), for: .normal)
        }
    }
    @IBOutlet weak var calculateNumbers: UILabel! {
        didSet {
            calculateNumbers.text = "weightInNumbers".localiz
        }
    }
    @IBOutlet weak var calculateCondition: UILabel! {
        didSet {
            calculateCondition.text = "weightCondition".localiz
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBotton = UIBarButtonItem(title: "done".localiz, style: .plain, target: self, action: #selector(closeKeyboard))
        toolBar.setItems([doneBotton], animated: true)
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
        if let language = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(language, forKey: "currentLanguage")
            Bundle.setLanguage(language)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
    @IBAction func calculationResult(_ sender: Any) {
        if let weightText = weightTextField.text,
           let heighText = heightTextField.text {
            let calculateFormate = NumberFormatter()
            if heighText.contains("٫") || heighText.contains(",") {
                calculateFormate.decimalSeparator = ","
            }else {
                calculateFormate.decimalSeparator = "."
            }
            if let heightNum = calculateFormate.number(from: heighText),
               let weightNum = calculateFormate.number(from: weightText) {
                let height = Double(truncating: heightNum)
                let weight = Double(truncating: weightNum)
                let calculateForma = weight / pow(height, 2)
                let fixedFormat = NumberFormatter()
                fixedFormat.maximumFractionDigits = 2
                calculateNumbers.text = fixedFormat.string(from: NSNumber(value: calculateForma))
                calculateCondition.text = bmiCalculation(calculateForma)
                self.view.endEditing(true)
            }
            self.view.endEditing(true)
        }else {
            let alert = UIAlertController(title: "error".localiz, message: "pleaseAddHeightAndWidthInTheCorrectFormat".localiz, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func bmiCalculation(_ bmi: Double) -> String {
        switch bmi {
        case 0...18.4:
            return "underweight".localiz
        case 18.5...24.9:
            return "normal".localiz
        case 25...30:
            return "overweight".localiz
        default:
            return "obese".localiz
        }
    }
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
}
extension String {
    var localiz: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

