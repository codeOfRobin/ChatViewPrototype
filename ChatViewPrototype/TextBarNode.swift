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
	
	let backgroundNode = ASDisplayNode { () -> UIView in
		let effect = UIBlurEffect(style: .light)
		let visualEffectView = UIVisualEffectView(effect: effect)
		return visualEffectView
	}
	
	override init() {
		super.init()
		
		self.addSubnode(backgroundNode)
//		self.addSubnode(textNode)
//		self.addSubnode(sendButton)
		
//		self.backgroundNode.style.preferredSize = CGSize(width: 100, height: 100)
		self.backgroundNode.style.width = ASDimensionMakeWithFraction(1.0)
		self.backgroundNode.style.height = ASDimensionMakeWithFraction(1.0)
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		return ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: [backgroundNode])
	}
}
