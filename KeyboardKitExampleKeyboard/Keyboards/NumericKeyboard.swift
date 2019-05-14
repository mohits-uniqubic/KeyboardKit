//
//  NumericKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the default numeric keyboard for iOS,
 just like `AlphabeticKeyboard` mimics the alphabetic one.
 
 */

import KeyboardKit

struct NumericKeyboard {
    
    init(for idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom) {
        actions = type(of: self).actions(for: idiom)
    }
    
    let actions: [[KeyboardAction]]
}


// MARK: - Actions

private extension NumericKeyboard {
    
    static func actions(for idiom: UIUserInterfaceIdiom) -> [[KeyboardAction]] {
        return characters
            .mappedToActions()
            .adjusted(for: idiom)
    }
}


// MARK: - Characters

private extension NumericKeyboard {
    
    static var characters: [[String]] {
        return [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
            [".", ",", "?", "!", "´"]
        ]
    }
}


// MARK: - Character Extensions

private extension Sequence where Iterator.Element == [String] {
    
    func mappedToActions() -> [[KeyboardAction]] {
        return map { $0.map { .character($0) } }
    }
}


// MARK: - Action Extensions

private extension Sequence where Iterator.Element == [KeyboardAction] {
    
    func adjusted(for idiom: UIUserInterfaceIdiom) -> [Iterator.Element] {
        switch idiom {
        case .pad: return widthSideButtonsForIpad().withSystemButtonsForIpad()
        default: return widthSideButtonsForIphone().withSystemButtonsForIphone()
        }
    }
    
    func widthSideButtonsForIphone() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.switchToSymbolicKeyboard, at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
    
    func widthSideButtonsForIpad() -> [Iterator.Element] {
        var actions = map { $0 }
        return actions
    }
    
    func withSystemButtonsForIphone() -> [Iterator.Element] {
        let systemActions: [KeyboardAction] = [.switchToAlphabeticKeyboard, .space, .newLine]
        return map { $0 } + [systemActions]
    }
    
    func withSystemButtonsForIpad() -> [Iterator.Element] {
        return map { $0 }
    }
}
