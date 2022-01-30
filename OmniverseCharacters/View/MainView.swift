//
//  ContentView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct MainView: View {
	@ObservedObject var vm = MainViewModel()
	
    var body: some View {
		NavigationView {
			List(vm.myCharacters ?? [], id: \.id) { myCharacter in
				Text(myCharacter.name)
				
			}
			.navigationTitle("Omniverse Characters")
			.listStyle(.plain)
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
