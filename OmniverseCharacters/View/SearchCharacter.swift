//
//  SearchCharacter.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct SearchCharacter: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var vm = SearchCharacterViewModel()
	@State var searchText: String = ""
	
	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			
			if vm.allCharacters.count >= 826 {
				VStack(spacing: 0.0) {
					HStack {
						Button {
							presentationMode.wrappedValue.dismiss()
						} label: {
							CustomButtonImage(image: "chevron.left")
						}
						
						Spacer()
						
						TextField("Character name", text: $searchText)
							.foregroundColor(Color.black)
							.padding(9)
							.overlay(
								RoundedRectangle(cornerRadius: 10)
									.stroke(Color(hex: "#CFCFCF"), lineWidth: 1)
							)
							.overlay(
								HStack {
									Spacer()
									Button {
										searchText = ""
									} label: {
										Image(systemName: "xmark")
											.foregroundColor(Color.black)
									}
								}
									.padding(.trailing, 9)
							)
					}
					.padding(.horizontal)
					.padding(.bottom, 8)
					
					Divider()
					
					ScrollView {
						VStack(spacing: 0.0) {
							ForEach((vm.allCharacters).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { character in
								NavigationLink {
									DetailCharacterView(character: character)
								} label: {
									VStack {
										Divider()
										Text(character.name)
											.foregroundColor(Color.black)
									}
									.padding(.bottom, 12)
								}
							}
						}
					}
				}
			} else {
				VStack {
					Text("Loading")
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
				}
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

