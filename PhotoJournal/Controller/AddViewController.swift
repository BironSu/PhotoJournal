//
//  AddViewController.swift
//  PhotoJournal
//
//  Created by Biron Su on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var photo: PhotoJournal!
    
    private var imagePickerViewController: UIImagePickerController!
    private var descriptionText = "Description..."
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTextView: UITextView!
    var imageHolder: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        setupTextViews()
    }
    private func setupTextViews() {
        addTextView.delegate = self
        addTextView.text = descriptionText
        addTextView.textColor = .lightGray
    }
    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
    }
    @IBAction func Save(_ sender: UIBarButtonItem) {
        guard let description = addTextView.text else {fatalError("Description is nil")}
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timestamp = isoDateFormatter.string(from: date)
        if let imageData = imageHolder.jpegData(compressionQuality: 0.5) {
            let photoJournal = PhotoJournal.init(createdAt: timestamp, imageData: imageData, description: description)
            PhotoJournalModel.addPhotoJournal(photo: photoJournal)
            PhotoJournalModel.savePhotoJournal()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .photoLibrary
        showImagePickerController()
    }
    private func showImagePickerController() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        showImagePickerController()
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addImage.image = image
            imageHolder = image
        } else {
            print("Original Image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if addTextView.text == descriptionText {
            addTextView.text = ""
            addTextView.textColor = .black
        }
    }
}
