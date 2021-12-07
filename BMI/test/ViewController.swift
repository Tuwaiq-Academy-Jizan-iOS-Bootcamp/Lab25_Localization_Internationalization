//
//  ViewController.swift
//  test
//
//  Created by Yasir Hakami on 05/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstNumberTxt: UITextField!
    @IBOutlet weak var colectButten: UIButton!
    
    @IBOutlet weak var logoBMI: UILabel!
    @IBOutlet weak var resultLebel: UILabel!
    @IBOutlet weak var heightLebel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var langChange: UIButton!
    @IBOutlet weak var shoeResult: UITextView!
    @IBOutlet weak var secondNumberTxt: UITextField!
    @IBOutlet weak var rusletLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logoBMI.text = "BMI".Localizable
        colectButten.setTitle(NSLocalizedString("addButtenBMI", comment: ""), for: .normal)
        addDoneButtonOnKeyboard() // done butten
        langChange.setTitle(NSLocalizedString("changeLan", comment: ""), for: .normal)
        resultLebel.text = "Result".Localizable
        weightLabel.text = "weight".Localizable
        heightLebel.text = "height".Localizable
    }

    @IBAction func lungerChange(_ sender: Any) {
        let currentLang = Locale.current.languageCode
        let newLang = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newLang], forKey: "AppleLanguages")
        exit(0)
    }
    
    @IBAction func addButten(_ sender: Any) {
        if let wightText = firstNumberTxt.text, let hightText = secondNumberTxt.text, let wight = Double(wightText), let higt = Double(hightText) {
            let finalResult = wight / pow(higt,2)
            rusletLabel.text = "\(finalResult)"
            
            
            
            switch finalResult {
            case 0...18.5 :
                shoeResult.text += "underweight".Localizable
            case 18.6...25:
                shoeResult.text += "normalweight".Localizable
            case 25.0...30 :
                shoeResult.text += "overweight".Localizable
            case 30.0...100000 :
                shoeResult.text += "obese".Localizable
                
            default:
                shoeResult.text += "try again! "
            }
            
            
        }else {
            let alert = UIAlertController(title: "error", message: "please add height and width in the correct format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        view.endEditing(true)
        
    }
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        firstNumberTxt.inputAccessoryView = doneToolbar
        secondNumberTxt.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            firstNumberTxt.resignFirstResponder()
            secondNumberTxt.resignFirstResponder()
        }
}

extension String {
    var Localizable:String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

