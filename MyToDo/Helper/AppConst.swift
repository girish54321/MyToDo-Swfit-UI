//
//  AppConst.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//


import Foundation
import AlertToast
import SwiftUI

struct AppConst {

    // MARK: Use with LocalHost
    static let todoimagesPath = "http://192.168.0.116:2000/"

    // MARK: Use with Remort
    static let isLoggedIn = "isLoggedIn"
    static let token = "JWT_token"
    static let isSkipped = "SIKPED"
    
    struct ApiConst {
        // MARK: Use with LocalHost
         let apiEndPoint = "http://192.168.0.116:2000/api/v1/"
    }
}

struct AppIconsSF {
    static let homeIcon = "list.clipboard"
    static let addNoteIcon = "plus.square"
    static let emailIcon = "envelope.fill"
    static let passwordIcon = "lock.fill"
    static let userIcon = "person.crop.circle.badge.checkmark"
    static let settingsIcon = "gearshape.fill"
    static let editIcon = "pencil"
    static let removeIcon = "trash"
    static let attachmentIcon = "paperclip"
}

struct AppKeyBoardType {
    static let `default` = 0 // Default type for the current input method.
    static let asciiCapable = 1 // Displays a keyboard which can enter ASCII characters
    static let numbersAndPunctuation = 2 // Numbers and assorted punctuation.
    static let URL = 3 // A type optimized for URL entry (shows . / .com prominently).
    static let numberPad = 4 // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
    static let phonePad = 5 // A phone pad (1-9, *, 0, #, with letters under the numbers).
    static let namePhonePad = 6 // A type optimized for entering a person's name or phone number.
    static let emailAddress = 7 // A type optimized for multiple email address entry (shows space @ . prominently).
    static let decimalPad = 8 // A number pad with a decimal point.
    static let twitter = 9 // A type optimized for twitter text entry (easy access to @ #)
    static let webSearch = 10 // A default keyboard type with URL-oriented addition (shows space . prominently).
    static let asciiCapableNumberPad = 11 // A number pad (0-9) that will always be ASCII digits.
}

class DateHelper {
    
    func formDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
    
}


class CreateAlert {
    
    func createErrorAlert(title: String, subTitle: String?) -> any View {
        let alertToast = AlertToast(
            displayMode: .banner(.slide),
            type: .error(.red),
            title: title,
            subTitle: subTitle)
        return alertToast
    }
}

