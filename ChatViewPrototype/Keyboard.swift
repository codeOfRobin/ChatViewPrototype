//
//  File.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 06/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

protocol KeyboardToolbar {
	var node: ASDisplayNode {get}
	
}

extension KeyboardToolbar where Self: UIViewController {

	func setup() {
		self.viewDidLayoutSubviews()
	}
}
