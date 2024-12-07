//
//  NotesViewController.swift
//  Notes
//
//  Created by Aisha Karzhauova on 07.12.2024.
//

import UIKit
import SnapKit
import CoreData

class NotesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    var groupedNotes: [String: [Note]] = [:]
    var sectionTitles: [String] = []
    
    var notes: [Note] = []
    var filteredNotes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchNotes()
    }
    
    func setupUI() {
        title = "Notes"
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.placeholder = "Search notes"
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
    
    func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            notes = try CoreDataManager.shared.context.fetch(fetchRequest)
            filteredNotes = notes
            tableView.reloadData()
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
        groupNotesByDate()
        tableView.reloadData()
    }
    
    

    
    @objc func addNote() {
        let vc = AddEditNoteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter {
                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.content?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
        groupNotesByDate() // Update sections after filtering
        tableView.reloadData()
    }
    
    func groupNotesByDate() {
        groupedNotes = Dictionary(grouping: filteredNotes) { note -> String in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: note.date ?? Date())
        }
        sectionTitles = groupedNotes.keys.sorted { $0 > $1 }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sectionTitles[section]
        return groupedNotes[sectionKey]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        let sectionKey = sectionTitles[indexPath.section]
        if let notesInSection = groupedNotes[sectionKey] {
            let note = notesInSection[indexPath.row]
            cell.configure(with: note)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = filteredNotes[indexPath.row]
            CoreDataManager.shared.context.delete(noteToDelete)
            CoreDataManager.shared.saveContext()
            fetchNotes()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected note
        let selectedNote = filteredNotes[indexPath.row]
        
        // Open AddEditNoteViewController
        let vc = AddEditNoteViewController()
        vc.note = selectedNote
        navigationController?.pushViewController(vc, animated: true)
    }

}

