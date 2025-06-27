//
//  TokenResponse.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
