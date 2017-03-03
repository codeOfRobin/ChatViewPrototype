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
	let background = MyCustomView()
	
	let backgroundNode = ASDisplayNode { () -> UIView in
		let effect = UIBlurEffect(style: .extraLight)
		let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
		
		let visualEffectView = UIVisualEffectView(effect: effect)
		let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
		vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		visualEffectView.contentView.addSubview(vibrancyView)
		
		let white = UIView()
		white.backgroundColor = UIColor.white.withAlphaComponent(0.7)
		white.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		visualEffectView.contentView.addSubview(white)
		return visualEffectView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubnode(node)
		
		node.addSubnode(tableNode)
		textInputBar.textNode.maximumLinesToDisplay = 5
	
		
		tableNode.style.preferredSize = CGSize(width: 300, height: 300)
		tableNode.style.width = ASDimensionMakeWithFraction(1.0)
		tableNode.style.flexGrow = 1.0
		node.layoutSpecBlock = { size in
			return ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: [self.tableNode])
		}
		
		
		tableNode.dataSource = manager
		tableNode.delegate = manager
		manager.Controller = self
		tableNode.reloadData()
		
		tableNode.view.keyboardDismissMode = .interactive
		
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: OperationQueue.main) { (notification) in

		}
		
		guard let blurView = (backgroundNode.view as? UIVisualEffectView) else {
			return
		}

		backgroundNode.view.frame.size = CGSize(width: view.frame.width, height: 44 + 4)
		blurView.contentView.addSubnode(textInputBar)
		textInputBar.frame = blurView.contentView.bounds
		view.addSubnode(backgroundNode)
		
		view.bringSubview(toFront: backgroundNode.view)
		
		background.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 48)
		background.delegate = self
		background.isUserInteractionEnabled = false
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.becomeFirstResponder()
	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
	}
	
	override var inputAccessoryView: UIView? {
		get {
			return background
		}
	}
	
	func centerChanged(center: CGPoint) {
		
	}
	
	func frameChanged(frame: CGRect) {
		backgroundNode.frame = frame
		node.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: frame.origin.y)
	}
	
	var isShowingBar: Bool {
		return self.isFirstResponder || self.textInputBar.textNode.isFirstResponder()
	}
	
	func hideBar() {
//		self.backgroundNode.isHidden = true
	}
	
	func showBar() {
//		self.backgroundNode.isHidden = false
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
}
