//
//  UserSettings.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 18.05.2023.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
        
    @Published var id: String {
        didSet {
            UserDefaults.standard.set(id, forKey: Keys.id)
        }
    }
        
    @Published var password: String {
        didSet {
            UserDefaults.standard.set(password, forKey: Keys.password)
        }
    }
    
    @Published var loggedIn : Bool!
    @Published var newUserData: [String: Any] = [:]
    @Published var myInfo: [String: Any] =
    UserDefaults.standard.dictionary(forKey: Keys.myInfo) ?? [:] {
        didSet {
            UserDefaults.standard.set(self.myInfo, forKey: Keys.myInfo)
        }
    }

    @Published var name: String =
    UserDefaults.standard.object(forKey: Keys.name)  as? String ?? "" {
        didSet {
            UserDefaults.standard.set(self.name, forKey: Keys.name)
        }
    }
    
    @Published var url: String =
    UserDefaults.standard.object(forKey: Keys.url)  as? String ?? "" {
        didSet {
            UserDefaults.standard.set(self.url, forKey: Keys.url)
        }
    }

    init() {
        _id = .init(initialValue: UserDefaults.standard.object(forKey: Keys.id) as? String ?? "")
        _password = .init(initialValue: UserDefaults.standard.object(forKey: Keys.password) as? String ?? "")
        loggedIn = !id.isEmpty ? true : false
        _myInfo = .init(initialValue: UserDefaults.standard.object(forKey: Keys.myInfo) as? [String: Any] ?? [:])
    }
        
    func login() {
        // login request... on success:
        self.loggedIn = true
    }

    func logout() {
        // login request... on success:
        self.loggedIn = false
    }

    private struct Keys {
        static let id = "id"
        static let password = "password"
        static let myInfo = "myInfo"
        static let isChild = "isChild"
        static let name = "name"
        static let url = "url"
    }
    
    func store(dictionary: [String: String], key: String) {
        var data: Data?
        let encoder = JSONEncoder()
        do {
            data = try encoder.encode(dictionary)
        } catch {
            print("failed to get data")
        }
        UserDefaults.standard.set(data, forKey: key)
    }

    func fetchDictionay(key: String) -> [String: String]? {
        let decoder = JSONDecoder()
        do {
            
            if let storedData = UserDefaults.standard.data(forKey: key) {
                let newArray = try decoder.decode([String: String].self, from: storedData)
                print("new array: \(newArray)")
                return newArray
            }
        } catch {
            print("couldn't decode array: \(error)")
        }
        return nil
    }

}
