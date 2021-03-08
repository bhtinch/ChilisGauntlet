//
//  RiverViewController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import UIKit

class RiverViewController: UIViewController {
    
    //  MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var previousJobLabel: UILabel!
    @IBOutlet weak var dreamJobLabel: UILabel!
    @IBOutlet weak var chilisJamLabel: UILabel!
    @IBOutlet weak var BioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let test = KingController.shared.loadFromPersistenceStore()
        
        if test == false {
            KingController.shared.createKings()
            KingController.shared.saveToPersistenceStore()
        }
        
        guard let king = KingController.shared.kings.first else { return }
        self.king = king
        updateViews(king: king)
    }
    
    //  MARK: - Properties
    var king: King?
    
    func updateViews(king: King) {
        nameLabel.text = king.name
        townLabel.text = king.homeTown
        ageLabel.text = king.age
        previousJobLabel.text = king.previousJob
        //dreamJobLabel.text = king.dreamJob
        chilisJamLabel.text = king.chilisJam
        BioLabel.text = king.bio
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRiverEditVC" {
            let destination = segue.destination as? EditKingViewController
            
            guard let king = self.king else { return }
            destination?.king = king
        }
    }

}
