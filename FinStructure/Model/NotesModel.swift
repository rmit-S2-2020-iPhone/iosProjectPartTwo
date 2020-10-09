//
//  NotesModel.swift
//  FinStructure
//
//  Created by Rupa Divya on 26/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation

struct Note {
    let title: String
    let date: String
    let text: String
}

class NotesModel {
    //Notes array
    var notesDetails: [Note] = []
}
