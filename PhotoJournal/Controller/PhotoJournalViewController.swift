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
        mainCollectionView.dataSource = self
        updateImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateImage()
        mainCollectionView.reloadData()
    }
    func updateImage() {
        photos = PhotoJournalModel.getPhotoJournal()
        
    }
}

extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        
        let photo = PhotoJournalModel.getPhotoJournal()[indexPath.row]
        cell.mainDate.text = photo.dateFormattedString
        cell.mainDate.layer.cornerRadius = 30
        cell.mainDate.layer.masksToBounds = true
        cell.mainTextView.text = photo.description
        cell.mainImage.image = UIImage(data: photo.imageData)
        cell.mainImage.layer.cornerRadius = 30
        
        cell.mainImage.layer.masksToBounds = true
        
        return cell
    }
}
