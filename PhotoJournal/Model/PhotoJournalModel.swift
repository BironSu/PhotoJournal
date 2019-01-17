//
//  PhotoJournalModel.swift
//  PhotoJournal
//
//  Created by Biron Su on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PhotoJournalModel {
    private static let filename = "PhotoJournalList1.plist"
    static var photoJournal = [PhotoJournal]()

    private init() {}
    
    static func savePhotoJournal() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error: \(error)")
        }
    }
    static func addPhotoJournal(photo: PhotoJournal) {
        photoJournal.append(photo)
        savePhotoJournal()
        
    }
    static func deletePhotoJournal(index: Int) {
        photoJournal.remove(at: index)
        savePhotoJournal()
    }
    static func getPhotoJournal() -> [PhotoJournal] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photoJournal = try PropertyListDecoder().decode([PhotoJournal].self, from: data).sorted(by: {$0.createdAt > $1.createdAt})
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("Data does not exist...")
            }
        } else {
            print("\(filename) does not exist...")
        }
        return photoJournal
    }
}
