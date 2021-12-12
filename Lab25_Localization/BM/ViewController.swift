//
//  ViewController.swift
//  BM
//
//  Created by Amal Jeli on 02/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DiscriptionLabel: UILabel!
    @IBOutlet weak var BmIlabel: UILabel!
    @IBOutlet weak var calculateBmi: UIButton!
    @IBOutlet weak var HeightLabel: UILabel!{
        didSet {
        HeightLabel.text = "Height".localized
    }
    }
    @IBOutlet weak var WeightLabel: UILabel!{
        didSet {
        WeightLabel.text = "Weight".localized
    }
    }
    @IBOutlet weak var HeightTextField: UITextField!
    @IBOutlet weak var WeightTextField: UITextField!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
       didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar" :
                    languageSegmentControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                default:
                    let localLang = Locale.current.languageCode
                    if localLang == "ar"{
                        languageSegmentControl.selectedSegmentIndex = 0
                    }else{
                        languageSegmentControl.selectedSegmentIndex = 1
                    }
                
                }
            }else {
                let locaLang = Locale.current.languageCode
                if locaLang == "ar" {
                    languageSegmentControl.selectedSegmentIndex = 0
                }else {
                    languageSegmentControl.selectedSegmentIndex = 1
                }
                }
       }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
            
//            HeightLabel.text = "Height".localized
//            WeightLabel.text = "Weight".localized
//
            
        }
        
        
  
    
    @IBAction func LanguageChange(_ sender:UISegmentedControl) {
        if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
            UserDefaults.standard.set(lang,forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storybord = UIStoryboard.init(name: "Main",bundle : nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene ,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController =
                storybord.instantiateInitialViewController()
            }
        }
    }
    
    

    
    @IBAction func calculateBMI(_ sender: Any) {
        if let weihtText = WeightTextField.text,
           let heightText = HeightTextField.text{
            print (weihtText)
            print(heightText)
            let calculationFormatter = NumberFormatter()
            if let  heightNumber = calculationFormatter.number(from: heightText), let
                weightNumber = calculationFormatter.number(from: weihtText){
                let height = Double (truncating: heightNumber)
                let weight = Double (truncating: heightNumber)
                let bmi = weight / pow (height,2)
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                BmIlabel.text = displayFormatter.string(from: NSNumber(value: bmi))
                DiscriptionLabel.text = getBMIDescription(bmi)
            }
            
        }else{
            let alert = UIAlertController(title: "error", message: "please add height and width in the correct format", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in self.dismiss(animated: true, completion: nil)
                }
                    alert.addAction(dismissAction)
                    self.present(alert, animated: true,completion: nil)
                    
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
//extension ViewController : UITextViewDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//        {
//            textField.resignFirstResponder()
//            return true
//        }
    

extension String {
    var localized :String {
        
        return NSLocalizedString(self, tableName: "localizable" , bundle: .main, value:self , comment: self)
        
    }
    
}







