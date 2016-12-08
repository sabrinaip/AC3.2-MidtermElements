//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Sabrina Ip on 12/8/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import Foundation

internal enum jsonSerialization: Error {
    case response(jsonData: Any)
}

class Element {
    var name: String
    var symbol: String
    var number: Int
    var weight: Double
    var meltingPoint: Int?
    var boilingPoint: Int?
//    var density: Double
//    var crustPercent: Double
//    var discoveryYear: String
//    var group: Int
//    var electrons: String
//    var ionEnergy: Double
    
//    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?, density: Double, crustPercent: Double, discoveryYear: String, group: Int, electrons: String, ionEnergy: Double) {
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int?, boilingPoint: Int?) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
//        self.density = density
//        self.crustPercent = crustPercent
//        self.discoveryYear = discoveryYear
//        self.group = group
//        self.electrons = electrons
//        self.ionEnergy = ionEnergy
    }
    
    static func getElements(data: Data) -> [Element]? {
        var elements = [Element]()
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response = jsonData as? [[String: Any]] else {
                throw jsonSerialization.response(jsonData: jsonData)
            }
            for eachElement in response {
                guard let name = eachElement["name"] as? String,
                let symbol = eachElement["symbol"] as? String,
                let number = eachElement["number"] as? Int,
                let weight = eachElement["weight"] as? Double else {
                    continue
                }
                let meltingPoint = eachElement["melting_c"] as? Int
                let boilingPoint = eachElement["boiling_c"] as? Int
                let newElement = Element(name: name, symbol: symbol, number: number, weight: weight, meltingPoint: meltingPoint, boilingPoint: boilingPoint)
                elements.append(newElement)
            }
            
        } catch let jsonSerialization.response(jsonData: jsonData) {
                print("PARSE ERROR: \(jsonData)")
        } catch {
            print(error)
        }
        return elements
    }
}
