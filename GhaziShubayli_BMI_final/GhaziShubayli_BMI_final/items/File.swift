//
//  File.swift
//  GhaziShubayli_BMI_final
//
//  Created by ماك بوك on 08/05/1443 AH.
//

import Foundation

var bundleKey : UInt8 = 0
class LanguageBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String, let bundle = Bundle(path: path) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
extension Bundle {
    class func setLanguage(_ language:String) {
        object_setClass(Bundle.main, LanguageBundle.self)
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
