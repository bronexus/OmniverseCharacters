//
//  ContentView.swift
//  OmniverseCharacters
//
//  Created by Dumitru on 30.01.2022.
//

import SwiftUI

struct MainView: View {
	@State var tabView: TabView = .home
	
	var body: some View {
		ZStack {
			VStack {
				switch tabView {
				case .home:
					CharactersView()
				case .search:
					SearchCharacter()
				}
				
				HStack {
					Spacer()
					
					Button {
						tabView = .home
					} label: {
						Text("Home")
							.font(.system(.body, design: .rounded).weight(.bold))
					}
					
					Spacer()
					
					Button {
						tabView = .search
					} label: {
						Text("Search")
							.font(.system(.body, design: .rounded).weight(.bold))
					}
					
					Spacer()
				}
				.frame(width: UIScreen.screenWidth, height: 40)
			}
		}
		.ignoresSafeArea(.keyboard)
	}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
#endif

enum TabView {
	case home, search
}
