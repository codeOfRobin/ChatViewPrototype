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
	
	var height = CGFloat(44)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubnode(node)
		
		node.addSubnode(tableNode)
	
		tableNode.style.height = ASDimensionMakeWithFraction(1.0)
		tableNode.style.width = ASDimensionMakeWithFraction(1.0)
		
		node.layoutSpecBlock = { size in
			return ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: [self.tableNode])
		}
		
		
		tableNode.dataSource = manager
		tableNode.delegate = manager
		tableNode.reloadData()
		
		tableNode.view.keyboardDismissMode = .interactive
		
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main) { (notification) in

		}
		
		
		let time = DispatchTime.now() + .seconds(4)
		DispatchQueue.main.asyncAfter(deadline: time) { 
			self.height *= 3
			
			self.resignFirstResponder()
			self.reloadInputViews()
			self.becomeFirstResponder()
			
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.becomeFirstResponder()

	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
		guard let blurView = (backgroundNode.view as? UIVisualEffectView) else {
			return
		}
		textInputBar.frame = blurView.bounds
	}
	
	override var inputAccessoryView: UIView? {
		
		guard let blurView = (backgroundNode.view as? UIVisualEffectView) else {
			return nil
		}
		
		backgroundNode.frame.size = CGSize(width: view.frame.width, height: height)
		print(backgroundNode.frame)
		blurView.contentView.addSubnode(textInputBar)
		
		return backgroundNode.view
	}
	
	func centerChanged(center: CGPoint) {
	}
	
	func frameChanged(frame: CGRect) {
		node.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: frame.origin.y)
		node.layout()
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
}
