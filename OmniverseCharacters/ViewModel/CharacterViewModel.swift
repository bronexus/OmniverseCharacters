//
//  MainViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
	
	@Published var characters: [RMCharacterModel]?
	
	let rmClient = RMClient()
	var cancellable: AnyCancellable?
	
	init() {
	
	}
	
	func loadCharacters(page: Int) {
		cancellable = rmClient.character().getCharactersByPageNumber(pageNumber: page)
			.sink(receiveCompletion: { _ in }, receiveValue: { characters in
				DispatchQueue.main.async {
					self.characters = characters
				}
			})
	}
	
	func loadEpisodeName(url: String, callback: @escaping (String) -> ()) {
		cancellable = rmClient.episode().getEpisodeByURL(url: url)
			.sink(receiveCompletion: { _ in }, receiveValue: { episode in
				callback(episode.name)
			})
	}
}
