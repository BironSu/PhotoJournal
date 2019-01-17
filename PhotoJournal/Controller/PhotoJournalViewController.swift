//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Biron Su on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var photos = [PhotoJournal]() {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        mainCollectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        updateImage()
        mainCollectionView.reloadData()
    }
    func updateImage() {
        photos = PhotoJournalModel.getPhotoJournal()
    }
}

extension PhotoJournalViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        
        let photo = photos[indexPath.row]
        cell.mainDate.text = photo.dateFormattedString
        cell.mainDate.layer.cornerRadius = 35
        cell.mainDate.layer.masksToBounds = true
        cell.mainTextView.text = photo.description
        cell.mainTextView.layer.cornerRadius = 10
        cell.mainTextView.isEditable = false
        cell.mainImage.image = UIImage(data: photo.imageData)
        cell.mainImage.layer.cornerRadius = 30
        cell.mainImage.layer.masksToBounds = true
        cell.editButton.tag = indexPath.row
        return cell
    }

    @IBAction func editButton(sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:
        {
            (alert: UIAlertAction!) -> Void in
            PhotoJournalModel.deletePhotoJournal(index: sender.tag)
            self.updateImage()
        })
        
        let shareAction = UIAlertAction(title: "Share", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("I don't have a phone to share button")
        })
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {return}
            destinationViewController.modalPresentationStyle = .currentContext
            destinationViewController.photo = self.photos[sender.tag]
            destinationViewController.indexNumber = sender.tag
            self.present(destinationViewController, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        //optionMenu.addAction(shareAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}
