//
//  TextBarNode.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 05/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

class TextBarNode: ASDisplayNode, ASEditableTextNodeDelegate {
	
	let textNode = ASEditableTextNode()
	
	let sendButton = ASButtonNode()
	
	override init() {
		super.init()
		
		self.addSubnode(textNode)
		self.addSubnode(sendButton)
		
		sendButton.setAttributedTitle(NSAttributedString(string: ""), for: [])
		sendButton.backgroundColor = .blue
		textNode.attributedPlaceholderText = NSAttributedString(string: "iMessage", attributes: TextBarStyles.sharedBarStyles.placeholderAttrs)
		textNode.typingAttributes = TextBarStyles.sharedBarStyles.textAttrs
		textNode.borderWidth = 0.5
		textNode.borderColor = TextBarStyles.sharedBarStyles.inputBorderColor.cgColor
		textNode.backgroundColor = TextBarStyles.sharedBarStyles.inputBGColor
		textNode.clipsToBounds = true
		self.backgroundColor = .clear
		textNode.style.flexGrow = 1.0
		
		textNode.textContainerInset = UIEdgeInsets(top: 9, left: 12, bottom: 8, right: 37)
		
		textNode.delegate = self
		
		textNode.style.height = ASDimensionMake(35)
		textNode.layer.cornerRadius = 17.0
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		let nodes: [ASLayoutElement] = [textNode]
		let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .center, alignItems: .center, children: nodes)
		return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(2, 9, 2, 9), child: stack)
	}
}
