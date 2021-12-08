//
//  ViewController.swift
//  BMI
//
//  Created by Hanan Somily on 05/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sizeKGtextfield: UITextField!
    @IBOutlet weak var tollTexetField: UITextField!
    @IBOutlet weak var viewReseltLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    var a:Double = 0
    var b:Double = 0
    var formatNumber = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeKGtextfield.delegate = self
        tollTexetField.delegate = self
        
        // Do any additional setup after loading the view.
    }
   

    @IBAction func calculatButton(_ sender: UIButton) {
        a = Double(sizeKGtextfield.text!) ?? 0
        b = Double(tollTexetField.text!) ?? 0
        formatNumber.maximumFractionDigits = 2
        var size = a/(b*b)
        var final:NSNumber = NSNumber(value: size*100)
        var sizze = formatNumber.string(from: final)
        print(size)
        viewReseltLable.text = sizze
        if size < 18.5 {
            descriptionLable.text = "underwight".localize
        }else if size > 18.5 && size <= 25.0 {
            descriptionLable.text = "normal weight".localize
        }else if size >= 25.1 && size <= 30 {
            descriptionLable.text = "overweight".localize
        }else if size > 30 {
            descriptionLable.text = "obese".localize
        }
        
    }

}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension String {
    var localize:String{
        
  return NSLocalizedString(self, tableName: "localized", bundle: .main, value: self, comment: self)
}
}
