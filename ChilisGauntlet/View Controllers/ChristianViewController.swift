//
//  ChristianViewController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import UIKit

class ChristianViewController: UIViewController {

    //  MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var previousJobLabel: UILabel!
    @IBOutlet weak var dreamJobLabel: UILabel!
    @IBOutlet weak var chilisJamLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var breakingBadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let test = KingController.shared.loadFromPersistenceStore()
        
        if test == false {
            KingController.shared.createKings()
            KingController.shared.saveToPersistenceStore()
        }
        
        let king = KingController.shared.kings[1]
        self.king = king
        updateViews(king: king)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        CharacterController.shared.fetchRandomCharacter { (result) in
            switch result {
            case .success(let character):
                self.updateCharacterImage(character: character)
                print(character)
            case .failure(let error):
                print(error.localizedDescription)
            } // end of switch result
        } // end of CharacterController.shared.fetchRandomCharacter
    }
    
    //  MARK: - Properties
    var king: King?
    
    func updateViews(king: King) {
        nameLabel.text = king.name
        townLabel.text = king.homeTown
        ageLabel.text = king.age
        previousJobLabel.text = king.previousJob
        dreamJobLabel.text = king.dreamJob
        chilisJamLabel.text = king.chilisJam
        bioLabel.text = king.bio
        imageView.image = UIImage(imageLiteralResourceName: ChristianConstants.imageString)
    }
    
    // MARK: - Helper Methods
    func updateCharacterImage(character: Character) {
        CharacterController.shared.fetchCharacterImage (character: character) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let img):
                    self.breakingBadImageView.image = img
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChristianEditVC" {
            let destination = segue.destination as? EditKingViewController
            
            guard let king = self.king else { return }
            destination?.king = king
            destination?.delegate = self
        }
    }
}

extension ChristianViewController: EditKingViewControllerDelegate{
    func updatePageWith(name: String, age: String, town: String, previousJob: String, dreamJob: String, chilisJam: String, bio: String) {
        nameLabel.text = name
        townLabel.text = town
        ageLabel.text = age
        previousJobLabel.text = previousJob
        dreamJobLabel.text = dreamJob
        chilisJamLabel.text = chilisJam
        bioLabel.text = bio
    }
}
