//
//  ViewController.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 04/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {

	let node = ASDisplayNode()
	let tableNode = ASTableNode()
	let manager = ChatTableManager()
	
	let textInputBar = TextBarNode()
	
	let backgroundNode = ASDisplayNode { () -> UIView in
		let effect = UIBlurEffect(style: .light)
		let visualEffectView = UIVisualEffectView(effect: effect)
		
		// 1
		let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
		// 2
		let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
		vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		// 3
		
		let red = UIView()
		red.backgroundColor = UIColor.red
		red.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
		
		vibrancyView.contentView.addSubview(red)
		
		// 4
		visualEffectView.contentView.addSubview(vibrancyView)
		
		return visualEffectView
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubnode(node)
		
		node.addSubnode(tableNode)
//		view.addSubnode(textInputBar)
		view.addSubnode(backgroundNode)
		textInputBar.textNode.maximumLinesToDisplay = 5
	
		
		backgroundNode.style.width = ASDimensionMakeWithFraction(1.0)
		backgroundNode.style.height = ASDimensionMake(44)
//		textInputBar.textNode.attributedPlaceholderText = NSAttributedString(string: "Reply here")
		
		tableNode.style.preferredSize = CGSize(width: 300, height: 300)
		tableNode.style.width = ASDimensionMakeWithFraction(1.0)
		tableNode.style.flexGrow = 1.0
		node.layoutSpecBlock = { size in
			
			let stack = ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: [self.tableNode])
			
			let relativeSpec = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: [], child: self.backgroundNode)
			
			let backgroundSpec = ASBackgroundLayoutSpec(child: relativeSpec, background: stack)
			
			return backgroundSpec
		}
		
		
		tableNode.dataSource = manager
		tableNode.delegate = manager
		tableNode.reloadData()
		
		tableNode.view.keyboardDismissMode = .interactive
		
	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
	}
}
