//
//  Country.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI

struct Country: Identifiable {
    var id: String { isoCode }
    let name: String
    let isoCode: String
    let phoneCode: String

    var flag: String {
        let base: UInt32 = 127397
        var s = ""
        for v in isoCode.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    static let allCountries: [Country] = [
        Country(name: "Afghanistan", isoCode: "AF", phoneCode: "+93"),
                Country(name: "Albania", isoCode: "AL", phoneCode: "+355"),
                Country(name: "Algeria", isoCode: "DZ", phoneCode: "+213"),
                Country(name: "Andorra", isoCode: "AD", phoneCode: "+376"),
                Country(name: "Angola", isoCode: "AO", phoneCode: "+244"),
                Country(name: "Argentina", isoCode: "AR", phoneCode: "+54"),
                Country(name: "Armenia", isoCode: "AM", phoneCode: "+374"),
                Country(name: "Australia", isoCode: "AU", phoneCode: "+61"),
                Country(name: "Austria", isoCode: "AT", phoneCode: "+43"),
                Country(name: "Azerbaijan", isoCode: "AZ", phoneCode: "+994"),
    ]
}
