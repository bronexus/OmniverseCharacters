//
//  File.swift
//  OmniverseCharacters2
//
//  Created by Dumitru on 09.01.2022.
//

import SwiftUI

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

class Utility {
	func isSmallDevice() -> Bool {
		if UIScreen.screenHeight < 812 {
			return true
		} else { return false }
	}
}
