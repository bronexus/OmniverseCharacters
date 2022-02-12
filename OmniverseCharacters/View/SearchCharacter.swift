//
//  SearchCharacter.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct SearchCharacter: View {
	@ObservedObject var vm = SearchCharacterViewModel()
	@State var searchText: String = ""
	
	var body: some View {
		VStack {
			if vm.allCharacters?.count == 826 {
				List((vm.allCharacters ?? []).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { character in
					Text(character.name)
				}
				.searchable(text: $searchText, prompt: "Search by name")
				.navigationTitle("Search")
			} else {
				Text("Loading...")
			}
		}
		.onAppear {
			vm.loadAllCharacters()
		}
	}
}

#if DEBUG
struct SearchCharacter_Previews: PreviewProvider {
	static var previews: some View {
		SearchCharacter()
	}
}
#endif

