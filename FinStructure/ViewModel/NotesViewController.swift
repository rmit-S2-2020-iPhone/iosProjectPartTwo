 //
//  ThirdViewController.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

 import UIKit
 import CoreData
 
 class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var labelText: UILabel!
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    
    var notesData = [NotesInfo](){
        didSet{
            notesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        searchBar.delegate=self
        searchBar.placeholder = "Search Notes"
        // load data
        notesData = CoreData.retrieveNotes()
    }
    
    @IBAction func addNotes(_ sender: Any) {
        let addView = storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        navigationController?.pushViewController(addView, animated: true)
    }
    
    // reload the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesData = CoreData.retrieveNotes()
        notesTableView.reloadData()
    }
    
    // number of table view rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.count
    }
    
    // table view each cell items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tCell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! NotesTableViewCell
        
        labelText.isHidden = true
        noteImage.isHidden = true
        notesTableView.isHidden = false

        tCell.notesTitleLabel?.text = notesData[indexPath.row].title
        tCell.notesTimeLabel?.text = notesData[indexPath.row].createDate?.convertToString() ?? "unknown"
        
        return tCell
    }
    
    // editing the table row items
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, IndexPath) in
            self.editAction(notes: self.notesData, indexPath: IndexPath)
        }
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, IndexPath) in
            self.deleteAction(notes: self.notesData, indexPath: IndexPath)
        }
        deleteButton.backgroundColor = .red
        editButton.backgroundColor = .blue
        return [deleteButton,editButton]
    }
    
    // delete the table view item action
    private func deleteAction(notes: [NotesInfo],indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the Note?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) in
            let noteDelete = notes[indexPath.row]
            CoreData.delete(note: noteDelete)
            self.notesData = CoreData.retrieveNotes()
            
            let count = self.notesData.count
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
    
    // edit the table view item action
    func editAction(notes: [NotesInfo],indexPath: IndexPath){
        let editView = storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        editView.notesAdd = notesData[indexPath.row]
        self.navigationController?.pushViewController(editView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let noteView = self.storyboard?.instantiateViewController(withIdentifier: "NotesInfoViewController") as! NotesInfoViewController
        
        noteView.note = notesData[indexPath.row]

        splitViewController?.showDetailViewController(noteView, sender: self)
        
        //self.navigationController?.pushViewController(noteView, animated: true)
    }
    
    // search bar action
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count != 0 {
            let request : NSFetchRequest<NotesInfo> = NotesInfo.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            notesData = CoreData.retrieveNotes(with: request)
            self.notesTableView.reloadData()
            
        } else {
            notesData = CoreData.retrieveNotes()
            self.notesTableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    // search clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        notesData = CoreData.retrieveNotes()
        self.notesTableView.reloadData()
        // hide keyboard
        searchBar.resignFirstResponder()
    }
    
    // search cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        notesData = CoreData.retrieveNotes()
        self.notesTableView.reloadData()
        searchBar.resignFirstResponder()
    }
 }
 
 // note created date
 extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
 }
 
 extension NSDate {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: (self as Date), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
 }
