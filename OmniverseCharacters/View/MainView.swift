//
//  ContentView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct MainView: View {
	@ObservedObject var vm = MainViewModel()
	
	@State var searchText: String = ""
	
    var body: some View {
		NavigationView {
			List((vm.myCharacters ?? []).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { myCharacter in
				Text(myCharacter.name)
				
			}
			.searchable(text: $searchText, prompt: "Search by name")
			.navigationTitle("Omniverse Characters")
			.onAppear {
				vm.getCharacters()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// (todoItems.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) }))
