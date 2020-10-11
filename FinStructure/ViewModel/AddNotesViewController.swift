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
    
    var notesAdd: NotesInfo?
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker() {
        let tBar = UIToolbar()
        tBar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateChanged))
        tBar.setItems([done], animated: true)
        
        dateText.inputAccessoryView = tBar
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateText.inputView = datePicker
        
    }
    @objc func dateChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        //datePicker.minimumDate = Date()
        let dt = datePicker! as UIDatePicker
        
        if Date() <= dt.date
        {
            dateText.text = dateFormatter.string(from: datePicker!.date)
        }
        else
        {
            dt.date = Date()
            let alert = UIAlertController(title: "Try Again", message: "The Date is already completed", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = notesAdd {
            self.navigationItem.title = "Edit Notes"
            notesSave?.setTitle("Update", for: .normal)
            titleText.text = note.title
            dateText.text = note.date
            notesText.text = note.text
        }
        else {
            self.navigationItem.title = "Create Notes"
            self.titleText?.becomeFirstResponder()
            notesSave?.setTitle("Save Notes", for: .normal)
            titleText.text = ""
            dateText.text = ""
            notesText.text = ""
        }
    }
    
    @IBAction func notesSave(_ sender: Any) {
        guard let addTitle = titleText.text, titleText.text != "" else { return }
        guard let addDate = dateText.text, dateText.text != "" else {return }
        guard let addText = notesText.text, notesText.text != "" else { return }
        
        if (notesAdd != nil){
            notesAdd?.title = titleText.text
            notesAdd?.date = dateText.text
            notesAdd?.text = notesText.text
            notesAdd?.createDate = Date()
            CoreData.saveNote()
            let alert = UIAlertController(title: "Successfully", message: "Notes Updated", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            present(alert,animated: true)
        }
        else {
            let addNote = CoreData.newNote()
            addNote.title = addTitle
            addNote.date = addDate
            addNote.text = addText
            addNote.createDate = Date()
            CoreData.saveNote()
            let alert = UIAlertController(title: "Successfully", message: "Notes Created", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            present(alert,animated: true)
        }
    }
}
