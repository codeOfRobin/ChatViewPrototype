//
//  ChatTableManager.swift
//  ChatViewPrototype
//
//  Created by Robin Malhotra on 05/01/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

class ChatTableManager: NSObject, ASTableDataSource, ASTableDelegate {
	
	let strings = "Kinfolk hoodie church-key, keffiyeh echo park pickled keytar edison bulb. Four dollar toast fanny pack kale chips, ethical PBR&B messenger bag gochujang tote bag succulents scenester. Green juice sartorial chicharrones, cray paleo intelligentsia fingerstache before they sold out normcore deep v you probably haven't heard of them raw denim. Twee vape asymmetrical humblebrag tacos, thundercats meditation occupy pinterest food truck hell of actually shabby chic lumbersexual. Chicharrones fixie sriracha, ugh fam synth kinfolk tilde bicycle rights gochujang woke jean shorts keffiyeh. Scenester pitchfork bitters, next level four loko small batch church-key tumblr letterpress shabby chic tacos. Artisan sriracha slow-carb gochujang activated charcoal.Asymmetrical selfies kitsch, fap selvage vape af. Cred drinking vinegar humblebrag art party. Glossier man braid yr venmo intelligentsia ugh. Knausgaard poutine small batch, sustainable man bun aesthetic wolf photo booth pok pok YOLO sriracha pabst fingerstache. Normcore green juice keytar godard meditation ethical, blue bottle skateboard glossier. Roof party hashtag migas narwhal, fam bushwick yuccie banh mi health goth fap truffaut pork belly portland. Humblebrag church-key marfa DIY, seitan cronut scenester.Next level keytar waistcoat sustainable edison bulb gentrify lomo dreamcatcher pop-up, flannel meh vinyl tofu lumbersexual DIY. Man bun af PBR&B keytar, chillwave swag shabby chic brunch mixtape you probably haven't heard of them pour-over trust fund hell of portland. XOXO thundercats cliche pinterest, gentrify kitsch try-hard activated charcoal YOLO intelligentsia helvetica lo-fi unicorn brooklyn. Sartorial man braid mumblecore affogato wolf. Seitan everyday carry waistcoat portland salvia health goth, vape chambray gentrify cray raw denim marfa migas you probably haven't heard of them. Health goth fanny pack blog, gastropub DIY seitan chillwave ethical ugh microdosing biodiesel organic prism offal. Fingerstache portland occupy tofu XOXO narwhal 8-bit PBR&B normcore, selfies hell of irony wolf.Literally ethical heirloom shoreditch, gentrify drinking vinegar meditation mlkshk twee. Keytar seitan coloring book taxidermy, kinfolk woke four loko dreamcatcher. Helvetica banh mi fashion axe, man bun four dollar toast coloring book polaroid drinking vinegar pabst slow-carb beard edison bulb. Chambray 8-bit PBR&B literally. Waistcoat blog chambray, ethical marfa ennui succulents raclette plaid next level XOXO mixtape artisan. Vexillologist deep v la croix, kitsch cardigan master cleanse pork belly. Leggings shoreditch green juice stumptown jianbing pork belly.".components(separatedBy: ".")
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return strings.count
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		return {
			let node = ASTextCellNode()
			node.text = strings[indexPath.row]
			return node
		}()
	}
}
