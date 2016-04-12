//
//  UIHelper.swift
//  TabbedNotes
//
//  Created by Tech on 2016-04-02.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

class AlertHelper {
    
    
    static func createSaveAlert(delegate:SaveItemDelegate, title:String, fieldNames:[String:String])->UIAlertController {
        
        let alert = UIAlertController(title: title, message:"", preferredStyle: .Alert)
        
        let actions = createActions([
            "Save" : { (action:UIAlertAction) in
                let keys = getKeys(fieldNames)
                let values:[String] = alert.textFields!.map(getTextFieldValue)
                delegate.onSave(createDictionary(keys, values:values))
            },
            "Cancel" : { (action: UIAlertAction) in },
            "Details" : { (action: UIAlertAction) in }
        ])
        
        actions.forEach({ (action:UIAlertAction) in alert.addAction(action) })
        
        fieldNames.values.forEach({ (placeholder:String) in
            alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
                textField.placeholder = placeholder
            }
        })
        return alert
    }
    
    static func createActions(actions:[String:(UIAlertAction) -> Void])->[UIAlertAction] {
        return actions.map(createAction)
    }
    
    static func createAction(title:String, handler:((UIAlertAction) -> Void)) -> UIAlertAction {
        return UIAlertAction(title: title, style: .Default, handler: handler)
    }
    
    static func getKeys(dict:[String:String])->[String] {
        var arr = [String]()
        for (key, _) in dict {
            arr.append(key)
        }
        return arr
    }
    
    static func getTextFieldValue(field:UITextField)->String {
        return field.text!
    }
    
    static func createDictionary(keys:[String], values:[String]) -> [String:String] {
        var dict = [String:String]()
        var key:String, value:String
        for i in 0...(keys.count - 1) {
            key = keys[i]
            value = values[i]
            dict[key] = value
        }
        return dict
    }
    
}
