//
//  Bundel.swift
//  AfafAlqahtani-LocateTextFild
//
//  Created by Afaf Yahya on 02/05/1443 AH.
//

import Foundation
var bunleKay: UInt8 = 0
class LanguageBundle: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bunleKay) as? String, let bundle = Bundle(path:path) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
class func setLanguage(_ language:String) {
    object_setClass(Bundle.main, LanguageBundle.self)
    objc_setAssociatedObject(Bundle.main, &bunleKay, Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}
}
