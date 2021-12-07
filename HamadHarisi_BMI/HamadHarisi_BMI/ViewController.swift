//
//  ViewController.swift
//  HamadHarisi_BMI
//
//  Created by حمد الحريصي on 06/12/2021.
//

import UIKit

class ViewController: UIViewController
{
    let numberToolbar: UIToolbar = UIToolbar()
    @IBOutlet var languageSegmentedControl: UISegmentedControl!
    {
        didSet
        {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage")
            {
                switch lang
                {
                case "ar":
                    languageSegmentedControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentedControl.selectedSegmentIndex = 1
                case "fr":
                    languageSegmentedControl.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar"
                    {
                         languageSegmentedControl.selectedSegmentIndex = 0
                     }
                    else if localLang == "fr"
                    {
                        languageSegmentedControl.selectedSegmentIndex = 2
                     }
                    else
                    {
                        languageSegmentedControl.selectedSegmentIndex = 1
                     }
                }
            }
            else
            {
                let localLang =  Locale.current.languageCode
                if localLang == "ar"
                {
                    languageSegmentedControl.selectedSegmentIndex = 0
                }
                else if localLang == "fr"
                {
                    languageSegmentedControl.selectedSegmentIndex = 2
                }
                else
                {
                    languageSegmentedControl.selectedSegmentIndex = 1
                }
            }
        }
    }
    @IBOutlet var heightLabel: UILabel!
    {
        didSet
        {
            heightLabel.text = "Height".localized
        }
    }
    @IBOutlet var weightLabel: UILabel!
    {
        didSet
        {
            weightLabel.text = "Weight".localized
        }
    }
    
    @IBOutlet var heightTextField: UITextField!

    
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var firstResultOfBMI: UILabel!
    
    @IBOutlet var secondResultOfBMI: UILabel!
    
    @IBOutlet var calculateBMIButton: UIButton!
   
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }

    override func viewDidLoad()
    {
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
//        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
        
        func handleTap()
        {
        heightTextField.resignFirstResponder() // dismiss keyoard
        }

        heightTextField.delegate = self
        
     
        
        super.viewDidLoad()
        heightLabel.text = "Height".localized
        weightLabel.text = "Weight".localized
        calculateBMIButton.setTitle(NSLocalizedString("Calculate BMI", comment: ""), for: .normal)
        
//
//        numberToolbar.barStyle = UIBarStyle.BlackTranslucent
//           numberToolbar.items = [
//               UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "hoopla"),
//               UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),
//               UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Bordered, target: self, action: "boopla")
//           ]

//           numberToolbar.sizeToFit()
//
//           textField.inputAccessoryView = numberToolbar
        
//
        //        let _: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    
//        view.addGestureRecognizer(tap)
        
        
        //self.hideKeyboardWhenTappedAround()
//        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
       
   
    
    
    
    
    }
    
//    func boopla () {
//        heightTextField.resignFirstResponder()
//    }
//
//    func hoopla () {
//        heightTextField.text = ""
//        heightTextField.resignFirstResponder()
//    }
//
    
//
//    @objc func tapDone(sender: Any) {
//            self.view.endEditing(true)
//        }
    @IBAction func languageSegmentedControl(_ sender: UISegmentedControl)
    {
        
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased()
        {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
    
//    func doneButtonTappedForMyNumericTextField() {
//        print("Done");
//        myNumericTextField.resignFirstResponder()
//    }
    @IBAction func CalculateBMIActionButton(_ sender: Any)
    {
        if let weightText = weightTextField.text,
           let heightText = heightTextField.text
        {
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText)
            {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                firstResultOfBMI.text = displayFormatter.string(from: NSNumber(value: bmi))
                secondResultOfBMI.text = getBMIDescription(bmi)
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
extension String
{
    var localized: String
    {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
//extension UITextField {
//
//   func addDoneButtonOnKeyboard() {
//       let keyboardToolbar = UIToolbar()
//       keyboardToolbar.sizeToFit()
//       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//           target: nil, action: nil)
//       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
//           target: self, action: #selector(resignFirstResponder))
//       keyboardToolbar.items = [flexibleSpace, doneButton]
//       self.inputAccessoryView = keyboardToolbar
//   }
//}
extension UIViewController
{
    

//    func hideKeyboardWhenTappedAround()
//    {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
