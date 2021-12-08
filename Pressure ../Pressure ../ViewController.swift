
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var changeLanguge: UISegmentedControl!{
        
        didSet{
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    changeLanguge.selectedSegmentIndex = 0
                case "en":
                    changeLanguge.selectedSegmentIndex = 1
                case "fr":
                    changeLanguge.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         changeLanguge.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         changeLanguge.selectedSegmentIndex = 2
                     }else {
                         changeLanguge.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     changeLanguge.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     changeLanguge.selectedSegmentIndex = 2
                 }else {
                     changeLanguge.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
            
    
    
@IBOutlet weak var upperNumberTextFiled: UITextField!
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerDateLabel: UILabel!

    
    @IBOutlet weak var bottomNumberTextfeild: UITextField!
    
    @IBOutlet weak var numberUpperLabel: UILabel!{
        didSet{
            
            numberUpperLabel.text = "numberUpper".localized
            
        }
    }
    @IBOutlet weak var bottomNumberLabel: UILabel! {
        didSet{
            bottomNumberLabel.text = "bottomNumber" .localized
        }
    }
    
    @IBOutlet weak var pressureState: UIButton! {
        didSet{
            
            pressureState.setTitle("pressureState".localized, for: .normal)
        }
    }

    @IBOutlet weak var descriptionPressure: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
//        let date = Date()
    

        
        
        
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneCliked))
//        doneButton.title = "done".localized
        toolBar.setItems([doneButton], animated: false)

        toolBar.setItems([doneButton], animated: false)

    
        upperNumberTextFiled.inputAccessoryView = toolBar
        bottomNumberTextfeild.inputAccessoryView = toolBar
    }
    
    @objc func doneCliked () {


            view.endEditing(true)
        }
        
    @IBAction func youStatePressure(_ sender: Any) {
        
    let upperNumber = upperNumberTextFiled.text
        let bottomNumber = bottomNumberTextfeild.text
        
         if Int(upperNumber!)! < 120 && Int(bottomNumber!)! < 80 {
            
    descriptionPressure.text = "less 120".localized
         }else if Int(upperNumber!)! >= 120 && Int(upperNumber!)! <= 129 &&  Int(bottomNumber!)! >= 80 && Int(bottomNumber!)! <= 84 {
             descriptionPressure.text = "normal".localized
             
} else if Int(upperNumber!)! >= 130 && Int(upperNumber!)! >= 139 && Int(bottomNumber!)! >= 85 &&  Int(bottomNumber!)! <= 89 {
    descriptionPressure.text = "pre-hypertension stage".localized
    
}else if Int(upperNumber!)! >= 140 && Int(upperNumber!)! <= 159 && Int(bottomNumber!)! <= 90 && Int(bottomNumber!)! >= 99 {
    descriptionPressure.text = "high blood pressure".localized
   
}else {
    descriptionPressure.text = "denger".localized
}
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let isoString = dateFormatter.string(from: pickerDate.date)
        dateFormatter.date(from: isoString)
pickerDateLabel.text = "\(isoString)"
        
        
    }
    
    @IBAction func segmentChangeLanguge(_ sender: UISegmentedControl) {
        

    
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
