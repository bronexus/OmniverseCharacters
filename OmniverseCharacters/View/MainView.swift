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
			if vm.characters?.count == 826 {
				ScrollView {
					ForEach((vm.characters ?? []).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { character in
						HStack {
							AsyncImage(url: URL(string: character.image)) { image in
								image
									.resizable()
									.scaledToFit()
							} placeholder: {
								ZStack {
									Image("character_image_placeholder")
										.resizable()
										.scaledToFit()
										.blur(radius: 3)
									ProgressView()
										.progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
									//								.scaleEffect(2)
								}
							}
							.frame(width: 80, height: 80, alignment: .center)
							.cornerRadius(16)
							Text(character.name)
							Spacer()
						}
						
					}
				}
				.searchable(text: $searchText, prompt: "Search by name")
				.navigationTitle("Omniverse Characters")
			} else {
				Text("Loading...")
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
