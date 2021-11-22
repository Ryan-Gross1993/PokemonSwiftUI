//
//  PokemonService.swift
//  PokemonSwiftUI
//
//  Created by Ryan Gross on 11/20/21.
//

import Combine
import Foundation

struct Pokemon: Codable {
	var name: String
	var url: String
}

struct PokedexResponse: Codable {
	var pokemonSpecies: [Pokemon]?
}

class PokemonService: ObservableObject {
	private let baseUrl = "https://pokeapi.co/api/v2/"
	
	lazy var jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		return jsonDecoder
	}()
	
	@Published var currentPokemon: String = ""
	@Published var pokedexResponse: PokedexResponse?
	
	@MainActor
	func getPokedex() async {
		guard let url = URL(string: "\(baseUrl)/generation/\(Int.random(in: 1...9))") else { return }
		
		await Task.sleep(2_000_000_000)
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			pokedexResponse = try jsonDecoder.decode(PokedexResponse.self, from: data)
			changeName()
		} catch let error {
			print("Error: \(error.localizedDescription)")
		}
	}
	
	func changeName() {
		guard let name = pokedexResponse?.pokemonSpecies?.randomElement()?.name.capitalized else { return }
		currentPokemon = name
	}
}
