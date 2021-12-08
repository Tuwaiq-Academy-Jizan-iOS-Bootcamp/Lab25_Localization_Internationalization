//
//  ViewController.swift
//  newlocalazation
//
//  Created by Arwa Alattas on 03/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var diameterTextFeild: UITextField!
 
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var langsegment: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    langsegment.selectedSegmentIndex = 1
                case "en":
                    langsegment.selectedSegmentIndex = 0
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         langsegment.selectedSegmentIndex = 1
                     }else {
                         langsegment.selectedSegmentIndex = 0
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     langsegment.selectedSegmentIndex = 1
                 }else{
                     langsegment.selectedSegmentIndex = 0
                 }
            }
        }
    }
    
    
    
    
    
    

    @IBOutlet weak var calcircumferenceOfCircle: UIButton!{
        didSet{
           calcircumferenceOfCircle.setTitle("calcircumferenceOfCircle".localized, for: .normal)
            
        }
        
    }
    @IBOutlet weak var diameterLabel: UILabel!{
        didSet{
            diameterLabel.text =
            "diameter".localized
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        diameterTextFeild.inputAccessoryView = toolBar
        
    }
    @objc func doneClicked(){
        
        view.endEditing(true)
    }
    @IBAction func calculationcircumferenceOfCircle(_ sender: Any) {
        if let diameterText = diameterTextFeild.text{
            let calculationFormatter = NumberFormatter()
            if let diameterNumber = calculationFormatter.number(from: diameterText){
                let diameter = Double(truncating: diameterNumber)
                let circumferenceOfCircle = diameter / 3.14
                let displayFormatter = NumberFormatter()
                displayFormatter.maximumFractionDigits = 2
                result.text = displayFormatter.string(from: NSNumber(value: circumferenceOfCircle))
            }
        }else {
            let alert = UIAlertController(title: "error", message: "please add  circumferenceOfCircle in the correct format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "ok", style: .default) { Action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func langChangeSegment(_ sender: UISegmentedControl) {
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
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
