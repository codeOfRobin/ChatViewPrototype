//
//  TextBarNode.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 05/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

class TextBarNode: ASDisplayNode {
	
	let textNode = ASEditableTextNode()
	
	let sendButton = ASButtonNode()
	
	override init() {
		super.init()
		
		self.addSubnode(textNode)
		self.addSubnode(sendButton)
		
		sendButton.setAttributedTitle(NSAttributedString(string: "something"), for: [])
		textNode.attributedPlaceholderText = NSAttributedString(string: "something")
		textNode.borderWidth = 1.0
		textNode.borderColor = UIColor.black.cgColor
		self.backgroundColor = .clear
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		return ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .center, alignItems: .center, children: [textNode, sendButton])
	}
}
