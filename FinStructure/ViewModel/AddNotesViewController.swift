//
//  AddNotesViewController.swift
//  FinStructure
//
//  Created by Rupa Divya on 26/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

class AddNotesViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet var notesText: UITextView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var notesSave: UIButton!
    
    var notesAdd: NotesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create Notes"
        self.titleText?.becomeFirstResponder()
        notesSave?.setTitle("Add Notes", for: .normal)
        notesSave?.setTitleColor(.white, for: .normal)
        notesSave.titleLabel?.font = UIFont(name: "Marker Felt", size: 18)
    }
    
    @IBAction func notesSave(_ sender: Any) {
        guard let addTitle = titleText.text, titleText.text != "" else { return }
        guard let addDate = dateText.text, dateText.text != "" else {return }
        guard let addText = notesText.text, notesText.text != "" else { return }
        let addNote = Note(title: addTitle, date: addDate, text: addText)
        notesAdd?.notesDetails.append(addNote)
        navigationController?.popViewController(animated: true)
    }
}
