//
//  String+Placemark.swift
//  GoTree
//
//  Created by Hernan Paez on 07/08/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import CoreLocation
import Contacts

extension CNMutablePostalAddress {
    convenience init(placemark: CLPlacemark) {
        self.init()
        street = [placemark.subThoroughfare, placemark.thoroughfare]
            .compactMap { $0 }           // remove nils, so that...
            .joined(separator: " ")      // ...only if both != nil, add a space.
        /*
         // Equivalent street assignment, w/o flatMap + joined:
         if let subThoroughfare = placemark.subThoroughfare,
         let thoroughfare = placemark.thoroughfare {
         street = "\(subThoroughfare) \(thoroughfare)"
         } else {
         street = (placemark.subThoroughfare ?? "") + (placemark.thoroughfare ?? "")
         }
         */
        city = placemark.locality ?? ""
        state = placemark.administrativeArea ?? ""
        postalCode = placemark.postalCode ?? ""
        country = placemark.country ?? ""
        isoCountryCode = placemark.isoCountryCode ?? ""
        if #available(iOS 10.3, *) {
            subLocality = placemark.subLocality ?? ""
            subAdministrativeArea = placemark.subAdministrativeArea ?? ""
        }
    }
}

extension String {
    init?(placemark: CLPlacemark?) {
        guard let placemark = placemark else { return nil }
        let postalAddress = CNMutablePostalAddress(placemark: placemark)
        let formatter = CNPostalAddressFormatter()
        formatter.style = CNPostalAddressFormatterStyle.mailingAddress
        self.init(formatter.string(from: postalAddress))
    }
}
