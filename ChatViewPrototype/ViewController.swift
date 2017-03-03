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
		tableNode.reloadData()
		
		tableNode.view.keyboardDismissMode = .interactive
		
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main) { (notification) in
			let lastRow = IndexPath(row: self.tableNode.numberOfRows(inSection: 0) - 1, section: 0)
			self.tableNode.scrollToRow(at: lastRow, at: .top, animated: true)

		}
		
		guard let blurView = (backgroundNode.view as? UIVisualEffectView) else {
			return
		}

		backgroundNode.view.frame.size = CGSize(width: view.frame.width, height: 44 + 4)
		blurView.contentView.addSubnode(textInputBar)
		textInputBar.frame = blurView.contentView.bounds
		view.addSubnode(backgroundNode)
		
		
//		let deadline = DispatchTime.now() + .seconds(3)
//		DispatchQueue.main.asyncAfter(deadline: deadline) { 
////			self.textInputBar.isShowingSendButton = false
////			self.textInputBar.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
//			UIView.animate(withDuration: 2, delay: 3, options: [], animations: {
//				guard let blurView = (self.backgroundNode.view as? UIVisualEffectView) else {
//					return
//				}
//				self.backgroundNode.frame = CGRect(x: 0, y: -300, width: self.view.frame.width, height: 200)
//				self.textInputBar.frame = blurView.contentView.bounds
//			}, completion: nil)
//		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.becomeFirstResponder()
		backgroundNode.addObserver(self, forKeyPath: "frame", options: [], context: nil)

	}

	override func viewDidLayoutSubviews() {
		node.frame = view.frame
	}
	
	override var inputAccessoryView: UIView? {
		let view = MyCustomView(frame: .zero)
		view.delegate = self
		return view
	}
	
	func centerChanged(center: CGPoint) {
		
	}
	
	func frameChanged(frame: CGRect) {
		node.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: frame.origin.y)
		print(node.frame)
		node.layout()
		backgroundNode.frame = CGRect(x: 0, y: frame.minY - 48, width: view.frame.width, height: 48)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		print(backgroundNode.view.frame)
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
}
