//
//  PhotoJournal.swift
//  PhotoJournal
//
//  Created by Biron Su on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    let createdAt: String
    let imageData: Data
    let description: String
}
