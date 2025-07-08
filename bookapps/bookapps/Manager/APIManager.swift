//
//  APIManager.swift
//  musicplayerapp
//
//  Created by Handrata Febrianto on 26/03/25.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private init() {}

    private let baseURL = "https://airline.api.cert.platform.sabre.com"

    private var commonHeaders: HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "*/*"
        ]
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        headers.add(name: "Application-ID", value: "SWS1:OD-DigXCI:1c8f21b5b9")
        if let sessionID = UserDefaults.standard.string(forKey: "sessionId") {
            print("SessionID: \(sessionID)")
            headers.add(name: "Session-ID", value: sessionID)
        }
        
        return headers
    }

    // MARK: - Auth Token
    func requestToken(completion: @escaping (Result<String, Error>) -> Void) {
        let url = "\(baseURL)/v2/auth/token/"
        let headers: HTTPHeaders = [
            "Authorization": "Basic VmpFNlQwUk5NREpUUnpwUFJEcFBSQT09OlRVOUNNbE5IVDBRPQ==",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "*/*"
        ]

        let parameters: [String: String] = [
            "grant_type": "client_credentials"
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let tokenData):
                UserDefaults.standard.set(tokenData.access_token, forKey: "authToken")
                completion(.success(tokenData.access_token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Passenger Details
    func getPassengerDetails(recordLocator: String, lastName: String, completion: @escaping (Result<PassengerDetailResponse, Error>) -> Void) {
        let url = "\(baseURL)/v918/dcci/passenger/details?jipcc=ODCI"
        let body: [String: Any] = [
            "reservationCriteria": [
                "recordLocator": recordLocator,
                "lastName": lastName
            ],
            "outputFormat": "BPXML"
        ]

        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: commonHeaders)
            .validate()
            .responseDecodable(of: PassengerDetailResponse.self) { response in
                if let sessionID = response.response?.allHeaderFields["session-id"] as? String {
                    UserDefaults.standard.set(sessionID, forKey: "sessionId")
                }
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Save Passenger Documents
    func savePassengerDocuments(payload: [String: Any], completion: @escaping (Result<PassengerDocumentSaveResponse, Error>) -> Void) {
        let url = "\(baseURL)/v918/dcci/passenger/update?jipcc=ODCI"

        print("Body: \(payload.description)")
        AF.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: commonHeaders)
            .validate()
            .responseDecodable(of: PassengerDocumentSaveResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Pax Check-in
    func checkInPassenger(passengerIds: [String], completion: @escaping (Result<String, Error>) -> Void) {
        let url = "\(baseURL)/v918/dcci/passenger/checkin?jipcc=ODCI"
        let body: [String: Any] = [
            "returnSession": false,
            "passengerIds": passengerIds,
            "outputFormat": "BPXML",
            "waiveAutoReturnCheckIn": false
        ]

        var newHeader = commonHeaders
        newHeader.add(name: "Content-Type", value: "application/json")

        print("URL: \(url)\nHeader: \(newHeader.description)\nBody: \(body)")
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: newHeader)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let string):
                    completion(.success(string))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Boarding Pass
    func getBoardingPass(passengerFlightIds: [String], completion: @escaping (Result<String, Error>) -> Void) {
        let url = "\(baseURL)/v918/dcci/passenger/boardingpass?jipcc=ODCI"
        let body: [String: Any] = [
            "returnSession": true,
            "passengerFlightIds": passengerFlightIds,
            "outputFormat": "BPXML"
        ]

        var newHeader = commonHeaders
        newHeader.add(name: "Content-Type", value: "application/json")

        print("URL: \(url)\nHeader: \(newHeader.description)\nBody: \(body)")
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: newHeader)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let responseString):
                    completion(.success(responseString))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

