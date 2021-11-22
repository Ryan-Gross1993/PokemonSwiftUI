//
//  ContentView.swift
//  PokemonSwiftUI
//
//  Created by Ryan Gross on 11/20/21.
//

import SwiftUI

struct ContentView: View {
	@StateObject var service = PokemonService()
	
	@ViewBuilder
	var body: some View {
		if service.currentPokemon.isEmpty {
			ProgressView("Loading...")
				.progressViewStyle(.circular)
			
				.task {
					await service.getPokedex()
				}
		} else {
			VStack {
				Text(service.currentPokemon)
					.font(.title)
				Spacer()
					.frame(height: 100)
				Button("Click Me!", action: {
					service.changeName()
				})
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
