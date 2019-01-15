//
//  DataPersistenceManager.swift
//  PhotoJournal
//
//  Created by Biron Su on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private static let filename = "PhotoJournalList.plist"
    
    // path to documents directory
    // ".../Documents"
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // filepath using filename to documents directory
    // ".../Documents/PhotoJournalList.plist"
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
