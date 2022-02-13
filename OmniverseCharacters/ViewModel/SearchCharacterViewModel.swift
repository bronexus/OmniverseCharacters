//
//  SearchCharacterViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class SearchCharacterViewModel: ObservableObject {
	
	@Published var allCharacters = [RMCharacterModel]()
	
	let rmClient = RMClient()
	var cancellable: AnyCancellable?
	
	init() {
	
	}
	
	func loadAllCharacters() {
		cancellable = rmClient.character().getAllCharacters()
			.sink(receiveCompletion: { _ in }, receiveValue: { characters in
				DispatchQueue.main.async {
					self.allCharacters = characters
				}
			})
	}
}
