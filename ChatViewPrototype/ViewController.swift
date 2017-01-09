//
//  ViewController.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 04/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController, MyCustomViewDelegate, ASEditableTextNodeDelegate {

	let node = ASDisplayNode()
	let tableNode = ASTableNode()
	let manager = ChatTableManager()
	
	var accessoryView = UIView()
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
		
		
		let time = DispatchTime.now() + .seconds(1)
		DispatchQueue.main.asyncAfter(deadline: time) { 
//			self.accessoryView.frame = .zero

		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.becomeFirstResponder()

	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
	}
	
	func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
//		self.resignFirstResponder()
//		editableTextNode.becomeFirstResponder()
//		editableTextNode.textView.inputAccessoryView = accessoryView
//		let deadline = DispatchTime.now() + .seconds(3)
//		UIView.animate(withDuration: 0.5, delay: 3, options: [], animations: { 
//			editableTextNode.textView.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//		}, completion: nil)
	}
	
	override var inputAccessoryView: UIView? {
		
		let backgroundNode = ASDisplayNode { () -> UIView in
			let effect = UIBlurEffect(style: .extraLight)
			let visualEffectView = UIVisualEffectView(effect: effect)
			
			let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
			let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
			let white = UIView()
			white.backgroundColor = UIColor.white.withAlphaComponent(0.7)
			white.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			
			
			vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			visualEffectView.contentView.addSubview(vibrancyView)
			visualEffectView.contentView.addSubview(white)
			return visualEffectView
		}
			
		
		guard let blurView = (backgroundNode.view as? UIVisualEffectView) else {
			return nil
		}
		
		let textInputBar = TextBarNode()
		textInputBar.textNode.delegate = self
		
		backgroundNode.frame.size = CGSize(width: view.frame.width, height: height)
		print(backgroundNode.frame)
		blurView.contentView.addSubnode(textInputBar)
		
		textInputBar.frame = blurView.bounds
		accessoryView = backgroundNode.view
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
