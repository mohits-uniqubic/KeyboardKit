//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol is just a util protocol that extends the type
 that implements it with more functionality.
 */
public protocol DeviceSpecificInputSetProvider: KeyboardInputSetProvider {
    
    var device: UIDevice { get }
}

public extension DeviceSpecificInputSetProvider {
    
    /**
     This function creates an input row, using inputs with a
     standard upper- and lowercased version of each provided
     character in the string.
     */
    func row(_ chars: String) -> KeyboardInputRow {
        row(chars.chars)
    }
    
    /**
     This function creates an input row, using inputs with a
     standard upper- and lowercased version of each provided
     character.
     */
    func row(_ chars: [String]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    /**
     This function creates a device-specific input row for a
     phone or pad, depending on the device's interface idiom.
     The inputs use a standard upper- and lowercased version
     of each provided character in the string.
     */
    func row(phone: String, pad: String) -> KeyboardInputRow {
        KeyboardInputRow(device.isPhone ? phone.chars : pad.chars)
    }
}
