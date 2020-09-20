//
//  ThirdViewController.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let notesData = NotesModel()
    
    @IBOutlet var labelText: UILabel!
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var noteImage: UIImageView!
    
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNotes(_ sender: Any) {
        let addView = storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        addView.notesAdd = notesData
        navigationController?.pushViewController(addView, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.notesDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tCell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath)
        labelText.isHidden = true
        noteImage.isHidden = true
        notesTableView.isHidden = false
        tCell.textLabel?.text = notesData.notesDetails[indexPath.row].title
        tCell.detailTextLabel?.text = notesData.notesDetails[indexPath.row].date
        return tCell
    }
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, IndexPath) in
            self.editAction(notesData: self.notesData, indexPath: IndexPath)
        }
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, IndexPath) in
            self.deleteAction(notesData: self.notesData, indexPath: IndexPath)
        }
        deleteButton.backgroundColor = .red
        editButton.backgroundColor = .blue
        return [deleteButton,editButton]
    }
    
    private func deleteAction(notesData: NotesModel,indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the Note?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) in
            notesData.notesDetails.remove(at: indexPath.row)
            self.notesTableView?.deleteRows(at: [indexPath], with: .fade)
            let count = notesData.notesDetails.count
            if count == 0 {
                self.labelText.isHidden = false
                self.noteImage.isHidden = false
                self.notesTableView.isHidden = true
            }
        }
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    func editAction(notesData: NotesModel,indexPath: IndexPath){
        let editView = storyboard?.instantiateViewController(withIdentifier: "EditNotesViewController") as! EditNotesViewController
        editView.note = notesData.notesDetails[indexPath.row]
        editView.noteEdit = notesData
        self.navigationController?.pushViewController(editView, animated: true)
        notesData.notesDetails.remove(at: indexPath.row)
        self.notesTableView?.deleteRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteView = storyboard?.instantiateViewController(withIdentifier: "NotesInfoViewController") as! NotesInfoViewController
        noteView.note = notesData.notesDetails[indexPath.row]
        self.navigationController?.pushViewController(noteView, animated: true)
    }
}
