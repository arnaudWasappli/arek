//
//  ArekCellVMServiceProgrammatically.swift
//  arek_example
//
//  Copyright (c) 2016 Ennio Masi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import arek

class ArekCellVMServiceProgrammatically {
    static private var permissions = [
        ["popupDataTitle": "Media Library Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Camera Access - PMAlertController", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Location Always Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Motion - PMAlertController", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"]
    ]
    
    static func numberOfVMs() -> Int {
        return self.permissions.count
    }
    
    static func buildVM(index: Int) -> ArekCellVM {
        let data = permissions[index]
        
        let configuration = ArekConfiguration(frequency: .Always, presentInitialPopup: true, presentReEnablePopup: true)
        let initialPopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["enableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopupType(index: index), styling: ArekPopupStyle(cornerRadius: 0.9, maskBackgroundColor: UIColor.orange, maskBackgroundAlpha: 1.0, titleTextColor: UIColor.green, titleFont: nil, descriptionFont: nil, descriptionLineHeight: nil, headerViewHeightConstraint: nil, allowButtonTitleColor: nil, allowButtonTitleFont: nil, denyButtonTitleColor: UIColor.brown, denyButtonTitleFont: nil))
        let reenablePopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["reEnableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopupType(index: index), styling: nil)
        
        let permission = getPermissionType(index: index, configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
        return ArekCellVM(permission: permission!, title: data["popupDataTitle"]!)
    }
    
    static private func getPopupType(index: Int) -> ArekPopupType {
        switch index {
        case 0:
            return .native
        case 1:
            return .codeido
        case 2:
            return .native
        case 3:
            return .codeido
        default:
            return .native
        }
    }
    
    static private func getPermissionType(index: Int, configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) -> ArekPermissionProtocol? {
        
        switch index {
        case 0:
            return ArekMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        case 1:
            return ArekCamera(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        case 2:
            return ArekLocationAlways(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        case 3:
            return ArekMotion(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        default:
            return nil
        }
    }
}
