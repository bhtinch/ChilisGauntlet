//
//  EditKingViewController.swift
//  ChilisGauntlet
//
//  Created by Benjamin Tincher on 3/8/21.
//

import UIKit

protocol EditKingViewControllerDelegate: AnyObject {
    func updatePageWith(name: String, age: String, town: String, previousJob: String, dreamJob: String, chilisJam: String, bio: String)
}

class EditKingViewController: UIViewController {
    //  MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var previousJobTextField: UITextField!
    @IBOutlet weak var dreamJobTextField: UITextField!
    @IBOutlet weak var chilisJamTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    //  MARK: - Properties
    var king: King?
    weak var delegate: EditKingViewControllerDelegate?
    
    //  MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let king = self.king,
              let name = nameTextField.text, !name.isEmpty,
              let town = townTextField.text, !town.isEmpty,
              let age = ageTextField.text, !age.isEmpty,
              let previousJob = previousJobTextField.text, !previousJob.isEmpty,
              let dreamJob = dreamJobTextField.text, !dreamJob.isEmpty,
              let chilisJam = chilisJamTextField.text, !chilisJam.isEmpty,
              let bio = bioTextView.text, !bio.isEmpty else { return }
        
        KingController.shared.updateKingWith(king: king, name: name, age: age, hometown: town, previousJob: previousJob, dreamJob: dreamJob, chilisJam: chilisJam, bio: bio)
        
        delegate?.updatePageWith(name: name, age: age, town: town, previousJob: previousJob, dreamJob: dreamJob, chilisJam: chilisJam, bio: bio)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let king = king else { return }
        
        nameTextField.text = king.name
        townTextField.text = king.homeTown
        ageTextField.text = king.age
        previousJobTextField.text = king.previousJob
        dreamJobTextField.text = king.dreamJob
        chilisJamTextField.text = king.chilisJam
        bioTextView.text = king.bio
    }

}
