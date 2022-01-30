//
//  DetailCharacterViewModel.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import Foundation
import Combine

class DetailCharacterViewModel: ObservableObject {
	
	@Published var locationCharacters: [RMCharacterModel]?
	
	
	let rmClient = RMClient()
	var cancellable: AnyCancellable?
	var cancellable2: AnyCancellable?
	
	init() {
	
	}
	
	func loadCurrentLocation(url: String) {
		cancellable = rmClient.location().getLocationByURL(url: url)
			.sink(receiveCompletion: { _ in }, receiveValue: { location in
				for url in location.residents {
					self.cancellable2 = self.rmClient.character().getCharacterByURL(url: url)
						.sink(receiveCompletion: { _ in }, receiveValue: { character in
							DispatchQueue.main.async {
								self.locationCharacters?.append(character)
							}
						})
				}
			})
	}
}
