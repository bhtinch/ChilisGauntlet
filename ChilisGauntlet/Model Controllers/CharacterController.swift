//
//  CharacterController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import Foundation
import UIKit

class CharacterController {
    
    let baseURL = URL(string: "https://www.breakingbadapi.com/api/")
    let characterEndpoint = "character"
    let randomEndpoint = "random"
    
    static let shared = CharacterController()
    
    func fetchRandomCharacter(completion: @escaping (Result<Character, NetworkError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let characterURL = baseURL.appendingPathComponent(characterEndpoint)
        let finalURL = characterURL.appendingPathComponent(randomEndpoint)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======ERROR======")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======ERROR======")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let breakingBad = try JSONDecoder().decode([Character].self, from: data)
                guard let final = breakingBad.first else {return completion(.failure(.unableToDecode))}
                return completion(.success(final))
            } catch {
                print("======ERROR======")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======ERROR======")
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    func fetchCharacterImage(character: Character, completion: @escaping (Result<UIImage,NetworkError>) -> Void) {
        
        guard let imageURL = URL(string:"\(String(describing: character.img))") else {return}
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("======ERROR======")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======ERROR======")
            }
            
            guard let data = data else {return completion(.failure(.unableToDecode))}
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
        }.resume()
        
    }
} // END OF STRUCT
