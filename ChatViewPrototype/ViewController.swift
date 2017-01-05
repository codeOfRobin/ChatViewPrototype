//
//  ViewController.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 04/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController, MyCustomViewDelegate {

	let node = ASDisplayNode()
	let tableNode = ASTableNode()
	let manager = ChatTableManager()
	
	let textInputBar = TextBarNode()
	
	let backgroundNode = ASDisplayNode { () -> UIView in
		let effect = UIBlurEffect(style: .extraLight)
		let visualEffectView = UIVisualEffectView(effect: effect)
		return visualEffectView
	}

	let textInputNode = TextBarNode()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubnode(node)
		
		node.addSubnode(tableNode)
		view.addSubnode(backgroundNode)
		textInputBar.textNode.maximumLinesToDisplay = 5
	
		
		backgroundNode.style.width = ASDimensionMakeWithFraction(1.0)
		backgroundNode.style.height = ASDimensionMake(44)
		
		tableNode.style.preferredSize = CGSize(width: 300, height: 300)
		tableNode.style.width = ASDimensionMakeWithFraction(1.0)
		tableNode.style.flexGrow = 1.0
		node.layoutSpecBlock = { size in
			
			let stack = ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: [self.tableNode])
			
			let overlaySpec = ASOverlayLayoutSpec(child: self.backgroundNode, overlay: self.textInputNode)
			
			let relativeSpec = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: [], child: overlaySpec)
			
			let backgroundSpec = ASBackgroundLayoutSpec(child: relativeSpec, background: stack)
			
			return backgroundSpec
		}
		
		
//		(backgroundNode.view as? UIVisualEffectView)?.contentView.addSubnode(textInputNode)
		view.addSubnode(textInputNode)
		
		tableNode.dataSource = manager
		tableNode.delegate = manager
		tableNode.reloadData()
		
		tableNode.view.keyboardDismissMode = .interactive
		
	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
	}
	
	override var inputAccessoryView: UIView? {
		let custom = MyCustomView(frame: .zero)
		custom.delegate = self
		return custom
	}
	
	func centerChanged(center: CGPoint) {
		print(center)
	}
}
