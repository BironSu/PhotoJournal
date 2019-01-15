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
    }
    override func viewWillAppear(_ animated: Bool) {
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
        
        let photo = PhotoJournalModel.getPhotoJournal()[indexPath.row]
        cell.mainDate.text = photo.createdAt
        cell.mainTextView.text = photo.description
        
        return cell
    }
}
