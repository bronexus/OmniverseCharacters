//
//  MainViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
	
	@Published var myCharacters: [RMCharacterModel]?
	
	let rmClient = RMClient()
	
	var cancellable: AnyCancellable?
	
//	init() {
//		cancellable = rmClient.character().getAllCharacters()
//			.sink(receiveCompletion: { _ in }, receiveValue: { characters in
//				characters.forEach() { print ($0.name) }
//			})
//	}
	
	func getCharacters() {
		cancellable = rmClient.character().getAllCharacters()
			.sink(receiveCompletion: { _ in }, receiveValue: { characters in
				self.myCharacters = characters
			})
	}
}
