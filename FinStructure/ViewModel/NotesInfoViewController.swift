//
//  NotesViewController.swift
//  FinStructure
//
//  Created by Rupa Divya on 26/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

class NotesInfoViewController: UIViewController {
    //Connection With Main Board
    
    @IBOutlet var notesText: UITextView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    var note: NotesInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notes"
        titleText.isUserInteractionEnabled = false
        dateText.isUserInteractionEnabled = false
        notesText.isEditable = false
        titleText.text = note?.title
        dateText.text = note?.date
        notesText.text = note?.text
    }
}
