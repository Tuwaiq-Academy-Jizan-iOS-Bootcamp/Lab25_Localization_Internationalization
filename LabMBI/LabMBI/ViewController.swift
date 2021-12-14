//
//  ViewController.swift
//  LabMBI
//
//  Created by زهور حسين on 09/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
    

    }
    @IBOutlet weak var heighttextfild: UITextField!
 
    @IBOutlet weak var calculatorbutton: UIButton!
    @IBOutlet weak var descriptionlable: UILabel!
    @IBOutlet weak var weighttextfild: UITextField!

    @IBOutlet weak var resultMBI: UILabel!
    @IBOutlet weak var lableheight: UILabel!{
        didSet{
            lableheight.text = "height".localized
        }
    }
        @IBOutlet weak var lableweight: UILabel!{
            didSet{
                lableweight.text = "weight".localized
            }
        }
    
    
    @IBOutlet weak var segmntedcontrol: UISegmentedControl!{
        didSet{
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    segmntedcontrol.selectedSegmentIndex = 0
                case "en":
                    segmntedcontrol.selectedSegmentIndex = 1
                case "fr":
                    segmntedcontrol.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         segmntedcontrol.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         segmntedcontrol.selectedSegmentIndex = 2
                     }else {
                         segmntedcontrol.selectedSegmentIndex = 1
                     }
                  
                }
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     segmntedcontrol.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     segmntedcontrol.selectedSegmentIndex = 2
                 }else {
                     segmntedcontrol.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    
    
    @IBAction func segmntedconrolltow(_ sender: UISegmentedControl) {
        
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
    
    // we need the below logic to fix the problem when we click on te segmentControl and we get reseted to the default behaviour
    @IBAction func calculator(_ sender: Any) {
    
        
        if let weightText = weighttextfild.text,
           let heightText = heighttextfild.text{
            // based on the local we will gate 1.6 or 1,7 so we need to change all input to Double to do that we need to use number formatter to convert string to NSNumber and then convert that to double and after that we do the calculation and reformat the Double output to String (using another formater to respect the local , or .)
            let calculationFormatter = NumberFormatter()
            if let heightNumber = calculationFormatter.number(from: heightText), let weightNumber = calculationFormatter.number(from: weightText) {
                let height = Double(truncating: heightNumber)
                let weight = Double(truncating: weightNumber)
                let bmi = weight / pow(height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                resultMBI.text = displayFormatter.string(from: NSNumber(value: bmi))
                descriptionlable.text = getBMIDescription(bmi)
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
            return NSLocalizedString(self, tableName: "localized", bundle: .main, value: self, comment: self)
        }
    }


