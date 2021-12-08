//
//  ViewController.swift
//  AfafAlqahtani-LocateTextFild
//
//  Created by Afaf Yahya on 01/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hightLable: UILabel!{
    didSet {
        hightLable.text = "height".localizeed
    }
    }
    @IBOutlet weak var weightLable: UILabel!{
    didSet {
        weightLable.text = "weight".localizeed

    }
    }
        @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
//    @IBOutlet weak var buttonOutlit: UIButton!
    @IBOutlet weak var bmLable: UILabel!
    @IBOutlet weak var bmiDescLable: UILabel!
    @IBOutlet weak var languageChangeOtlit: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageChangeOtlit.selectedSegmentIndex = 0
                case "en":
                    languageChangeOtlit.selectedSegmentIndex = 1
                case "fr":
                    languageChangeOtlit.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageChangeOtlit.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         languageChangeOtlit.selectedSegmentIndex = 2
                     }else {
                         languageChangeOtlit.selectedSegmentIndex = 1
                     }
                 
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageChangeOtlit.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     languageChangeOtlit.selectedSegmentIndex = 2
                 }else {
                     languageChangeOtlit.selectedSegmentIndex = 1
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
                         self.weightText.inputAccessoryView = toolbar
                         self.heightText.inputAccessoryView = toolbar

                   }
                  @objc func doneButtonAction() {
                      self.view.endEditing(true)
                   }
 
    
    @IBAction func languageChangeAction(_ sender: UISegmentedControl) {
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
        
        if let wightText = weightText.text,
           let highText = heightText.text {
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: highText), let weightNumber =
                calculationFormatter.number(from: wightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height, 2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                bmLable.text = displayFormatter.string(from: NSNumber(value: bmi))
                bmiDescLable.text = getBMIDescription(bmi)
                
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
    func getBMIDescription(_ bim:Double) -> String {
        switch bim {
        case 0...18.4:
            return "underweight".localizeed
        case 18.5...24.9:
            return "normal".localizeed
        case 25...30:
            return "overweight".localizeed
        default:
            return "obese".localizeed
        }
    }
    
}
    



extension String {
    var localizeed: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

    extension UITextField{
        @IBInspectable var doneAccessory: Bool{
            get{
                return self.doneAccessory
            }
            set (hasDone) {
                if hasDone{
                    addDoneButtonOnKeyboard()
                }
            }
        }
func addDoneButtonOnKeyboard()
   {
       let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
       doneToolbar.barStyle = .default

       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

       let items = [flexSpace, done]
       doneToolbar.items = items
       doneToolbar.sizeToFit()

       self.inputAccessoryView = doneToolbar
   }

   @objc func doneButtonAction()
   {
       self.resignFirstResponder()
   }
}
