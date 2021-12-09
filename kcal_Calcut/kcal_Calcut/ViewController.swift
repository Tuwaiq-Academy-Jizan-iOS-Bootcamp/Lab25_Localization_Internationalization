//
//  ViewController.swift
//  kcal_Calcut
//
//  Created by dahma alwani on 03/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
            let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
            let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
                         toolbar.setItems([flexSpace, doneBtn], animated: false)
                         toolbar.sizeToFit()
        self.ageTextField.inputAccessoryView = toolbar
        self.weightTextField.inputAccessoryView = toolbar
        self.heightTextField.inputAccessoryView = toolbar

    }
                  @objc func doneButtonAction() {
                      self.view.endEditing(true)
                   }
        

   
    @IBOutlet weak var genderSegment: UISegmentedControl! {
        didSet {
            genderSegment.setTitle("male".localized, forSegmentAt: 0)
            genderSegment.setTitle("female".localized, forSegmentAt: 1)
        }
    }
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var activitySegment: UISegmentedControl! {
        didSet {
            activitySegment.setTitle("Sedentary".localized, forSegmentAt: 0)
            activitySegment.setTitle("moderate".localized, forSegmentAt: 1)
            activitySegment.setTitle("heavey".localized, forSegmentAt: 2)
        }
    }
    @IBOutlet weak var calculationButton: UIButton! {
        didSet {
            calculationButton.setTitle("calculation".localized, for: .normal)
        }
    }
    @IBOutlet weak var discribeLabel: UILabel!
    
    @IBOutlet weak var langugeSegment: UISegmentedControl!
    {
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "en":
                    langugeSegment.selectedSegmentIndex = 1
                case "ar":
                    langugeSegment.selectedSegmentIndex = 0
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "en" {
                         langugeSegment.selectedSegmentIndex = 1
                     }else{
                         langugeSegment.selectedSegmentIndex = 0
                     }
                }
           }else{
                let localLang =  Locale.current.languageCode
                 if localLang == "en" {
                     langugeSegment.selectedSegmentIndex = 1
                 } else{
                     langugeSegment.selectedSegmentIndex = 0
                 }
            }
                }
            }
    
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.text = "age".localized
        }
    }
    @IBOutlet weak var weightLabel: UILabel! {
        didSet {
            weightLabel.text = "weight".localized
        }
    }
    @IBOutlet weak var heightLabel: UILabel! {
        didSet {
            heightLabel.text = "height".localized
        }
    }
    
    @IBAction func langugeChange(_ sender: UISegmentedControl) {
        
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
    @IBAction func caculationButtonAction(_ sender: Any) {
        if let ageText = ageTextField.text,
            let weightText = weightTextField.text,
           let heightText = heightTextField.text{
          
            let calculationFormatter = NumberFormatter()
            if let ageNumber = calculationFormatter.number(from: ageText),
                let heightNumber = calculationFormatter.number(from: heightText),
                let weightNumber = calculationFormatter.number(from: weightText) {
                let age = Double(truncating: ageNumber)
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                
                let FBMR = 655 + (9.6 * weight)  + (1.8 * height) - (4.7 * age)
                let MBMR = 66 + (13.7 * weight) + (5 * height) - (6.8 * age)
                discribeLabel.text = "\(MBMR)"
                if genderSegment.selectedSegmentIndex == 0 {
                    print(FBMR)
                    discribeLabel.text = "your calore is \(FBMR)"
                }else if genderSegment.selectedSegmentIndex == 1{
                    print(MBMR)
                }
                if activitySegment.selectedSegmentIndex == 0 {
                    let Sedentary = FBMR * 1.2
                    print(Sedentary)
                    discribeLabel.text = "your calore is \(Sedentary)"
                }else if activitySegment.selectedSegmentIndex == 1{
                    let moderate = FBMR * 1.5
                    print(moderate)
                    discribeLabel.text = "your calore is \(moderate)"
                    
                }else if activitySegment.selectedSegmentIndex == 2 {
                    let heavey = FBMR * 1.9
                    print(heavey)
                    discribeLabel.text = "your calore is \(heavey)"
                }
                if activitySegment.selectedSegmentIndex == 0 {
                    let Sedentary = MBMR * 1.2
                    print(Sedentary)
                }else if activitySegment.selectedSegmentIndex == 1{
                    let moderate = MBMR * 1.5
                    print(moderate)
                }else if activitySegment.selectedSegmentIndex == 2 {
                    let heavey = MBMR * 1.9
                    print(heavey)
                }
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
               
            }
        }else {
            let alert = UIAlertController(title: "ERROR", message: "please add height, wigth,age in the correct format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
        }
    
        }

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "localaziable", bundle: .main, value: self, comment: self)
    }
}

