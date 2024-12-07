//
//  AddEditNoteViewController.swift
//  Notes
//
//  Created by Aisha Karzhauova on 07.12.2024.
//

import UIKit
import SnapKit

class AddEditNoteViewController: UIViewController {
    var note: Note?
    
    let titleTextField = UITextField()
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        title = note == nil ? "New Note" : "Edit Note"
        
        // Save Button
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = saveButton
        
        // Title Text Field
        titleTextField.placeholder = "Enter title"
        titleTextField.font = UIFont.boldSystemFont(ofSize: 24) // Larger font
        titleTextField.borderStyle = .none // Remove borders
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Content Text View
        contentTextView.font = UIFont.systemFont(ofSize: 18) // Larger font
        contentTextView.layer.borderWidth = 0 // Remove borders
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    @objc func saveNote() {
        guard let title = titleTextField.text, !title.isEmpty else {
            // Show an alert if the title is empty
            let alert = UIAlertController(title: "Error", message: "Title cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let context = CoreDataManager.shared.context
        if let note = note {
            // Update existing note
            note.title = title
            note.content = contentTextView.text
            note.date = Date()
        } else {
            // Create a new note
            let newNote = Note(context: context)
            newNote.title = title
            newNote.content = contentTextView.text
            newNote.date = Date()
        }

        // Save the context
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save note: \(error)")
        }
    }
}
