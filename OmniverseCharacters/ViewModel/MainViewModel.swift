//
//  MainViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
	
	@Published var characters: [RMCharacterModel]?
	
	let rmClient = RMClient()
	
	var cancellable: AnyCancellable?
	
	init() {
	cancellable = rmClient.character().getAllCharacters()
		.sink(receiveCompletion: { _ in }, receiveValue: { characters in
			self.characters = characters
		})
	}
	
//	func getCharacters() {
//		cancellable = rmClient.character().getAllCharacters()
//			.sink(receiveCompletion: { _ in }, receiveValue: { characters in
//				self.characters = characters
//			})
//	}
}
