//
//  KeyboardHelper.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 06/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit

protocol MyCustomViewDelegate {
	func centerChanged(center: CGPoint)
}
class MyCustomView: UIView{
	
	private var centerContext = 0
	var delegate: MyCustomViewDelegate?
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
		guard let newSuperview = newSuperview else {
			self.superview?.removeObserver(self, forKeyPath: "center")
			return
		}
		let options = NSKeyValueObservingOptions([.new, .old])
		newSuperview.addObserver(self, forKeyPath: "center", options: options, context: &centerContext)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if context == &centerContext {
			
			guard let center = superview?.center else {
				super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
				return
			}
			
			delegate?.centerChanged(center: center)
			
		} else {
			super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
		}
	}

}
