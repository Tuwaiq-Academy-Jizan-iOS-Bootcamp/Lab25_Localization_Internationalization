//
//  BundleExtention.swift
//  BMI MM
//
//  Created by موسى مسملي on 08/12/2021.
//

import Foundation
var bundleKey: UInt8 = 0
class LanguageBundle: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String, let bundle = Bundle(path:path) else {
            // use the main bundle default thingy
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
