//
//  TextStyles.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 10/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit

struct TextBarStyles {
	static let sharedBarStyles = TextBarStyles()
	
	let inputBorderColor = UIColor(red:0.80, green:0.81, blue:0.82, alpha:1.00)
	let inputBGColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
	let placeholderAttrs = [NSForegroundColorAttributeName: UIColor(red:0.80, green:0.81, blue:0.82, alpha:1.00), NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)]
	let textAttrs = [NSForegroundColorAttributeName: UIColor.black,
	                 NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)]
	
}
