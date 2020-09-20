//
//  EditNoteViewController.swift
//  FinStructure
//
//  Created by Rupa Divya on 4/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

class EditNotesViewController: UIViewController {
    
    var noteEdit: NotesModel?
    var note: Note?
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var notesEdit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Notes"
        self.navigationItem.hidesBackButton = true
        self.titleText?.becomeFirstResponder()
        notesEdit?.setTitle("Update/Back", for: .normal)
        notesEdit?.setTitleColor(.white, for: .normal)
        notesEdit.titleLabel?.font = UIFont(name: "Marker Felt", size: 18)
        
        titleText.text = note?.title
        dateText.text = note?.date
        notesText.text = note?.text
    }
    
    @IBAction func notesEdit(_ sender: Any) {
        guard let addTitle = titleText.text, titleText.text != "" else { return }
        guard let addDate = dateText.text, dateText.text != "" else {return }
        guard let addText = notesText.text, notesText.text != "" else { return }
        let addNote = Note(title: addTitle, date: addDate, text: addText)
        noteEdit?.notesDetails.append(addNote)
        navigationController?.popViewController(animated: true)
    }
    
}
