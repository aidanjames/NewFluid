//
//  ThingsManager.swift
//  ThingsManager
//
//  Created by Aidan Pendlebury on 25/07/2021.
//

import Foundation
import SwiftUI

// TODO - Check if device can open Things https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl
// TODO - Call back so my app is back in focus after adding the new todo http://x-callback-url.com


class ThingsManager {
    static let shared = ThingsManager()
    
    private init() {}
    
    
    func newToDo(title: String, date: Date = Date()) {
        let todo = TJSTodo(title: title, when: "today")

        let container = TJSContainer(items: [.todo(todo)])
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = ThingsJSONDateEncodingStrategy()
            let data = try encoder.encode(container)
            let json = String(data: data, encoding: .utf8)!
            var components = URLComponents(string: "things:///add-json")!
            let queryItem = URLQueryItem(name: "data", value: json)
            components.queryItems = [queryItem]
            let url = components.url!
            UIApplication.shared.open(url, options: [:]) { thing in
                print("We got a completion response! \(thing)")
            }
        }
        catch {
            print("There's been an error: \(error.localizedDescription)")
        }
    }
    
}
