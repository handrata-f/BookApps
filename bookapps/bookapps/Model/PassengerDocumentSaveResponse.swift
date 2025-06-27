//
//  PassengerDocumentSaveResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

struct PassengerDocumentSaveResponse: Codable {
    let results: [PassengerUpdateResult]
}

struct PassengerUpdateResult: Codable {
    let update: PassengerUpdate
    let status: [UpdateStatus]
}

struct PassengerUpdate: Codable {
    let value: String
    let context: String
    let operation: String
}

struct UpdateStatus: Codable {
    let type: String
}
