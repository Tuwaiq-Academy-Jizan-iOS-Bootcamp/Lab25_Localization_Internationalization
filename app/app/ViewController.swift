//
//  ViewController.swift
//  app
//
//  Created by Hanan Somily on 06/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatButton: UIButton! {
        didSet{
            calculatButton.setTitle("calculate".localized, for: .normal)
        }
    }
    @IBOutlet weak var inserthightTexet: UITextField!
    @IBOutlet weak var insertWeightText: UITextField!
    @IBOutlet weak var changeLangouge: UISegmentedControl!{
            didSet{
                //changeLangouge.selectedSegmentIndex = 1
                if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                    switch lang {
                    case "ar":
    changeLangouge.selectedSegmentIndex = 0
                    case "en":
    changeLangouge.selectedSegmentIndex = 1
                    default:
   // changeLangouge.selectedSegmentIndex = 1
let localLang =  Locale.current.languageCode
if localLang == "ar" { changeLangouge.selectedSegmentIndex = 0
         }else{changeLangouge.selectedSegmentIndex = 1
                         }
                    }
    } else {
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         changeLangouge.selectedSegmentIndex = 0
                     }else {
                         changeLangouge.selectedSegmentIndex = 1
                     }
                }
            }
        }
    @IBOutlet weak var tollLabel: UILabel!{
        didSet {
            tollLabel.text = "height".localized
        }
    }
    @IBOutlet weak var weightLable: UILabel!{
        didSet {
            weightLable.text = "weight".localized
        }
    }
    @IBOutlet weak var resultCalculate: UILabel!
    @IBOutlet weak var bodyMassLable: UILabel!
    @IBOutlet weak var perfectLable: UILabel!{
        didSet{
            perfectLable.text = "Perfect Weight".localized
        }
    }
    @IBOutlet weak var viewPefcuctLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.inserthightTexet.addInputAccessoryView(title: "Done".localized, target: self, selector: #selector(tapDone))
        self.insertWeightText.addInputAccessoryView(title: "Done".localized, target: self, selector: #selector(tapDone))
    }
    @objc func tapDone() {
           self.view.endEditing(true)
       }
    @IBAction func calculateButton(_ sender: UIButton) {
        if let weightText = insertWeightText.text ,
           let hightText = inserthightTexet.text {
            print(weightText , hightText)
            let calculatFormat = NumberFormatter()
            if let hightNum = calculatFormat.number(from: hightText),
                let wightNum = calculatFormat.number(from: weightText)
            {
                print(hightNum , wightNum)
                let weight = Double(truncating: wightNum)
                let hight = Double(truncating: hightNum)
                let bmiCal = weight/pow(hight,2)
                
                print(bmiCal)
                let displayFormatt = NumberFormatter()
                displayFormatt.maximumFractionDigits = 2
                bodyMassLable.text = displayFormatt.string(from: NSNumber(value: bmiCal))
                resultCalculate.text = getBMIDescription(bmiCal)
                print(bmiCal)
                var perfect = hight*100
                print("perfect",perfect)
                viewPefcuctLable.text = displayFormatt.string(from: NSNumber(value:(perfect - 150) * 0.9+45))
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

    @IBAction func changeLango(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            if lang == "en"{
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            } else {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
}

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: "localized", bundle: .main, value: self, comment: self)
    }
}

extension UITextField {
    
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
