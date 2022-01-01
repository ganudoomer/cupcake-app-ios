//
//  Order.swift
//  cupcake-app
//
//  Created by Sree on 24/10/21.
//

import Foundation
struct DataModel: Codable {
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
}

class Order: ObservableObject,Codable {
    enum CodingKeys: CodingKey {
        case type,quantity,extraFrosting,specialRequestEnabled,addSprinkles,name,streetAddress,city,zip,data
    }
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    @Published var data = DataModel(name: "", streetAddress: "", city: "", zip: "")
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    var hasValidAddress: Bool {
        if data.name.trimmingCharacters(in: .whitespaces).isEmpty || data.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || data.city.trimmingCharacters(in: .whitespaces).isEmpty || data.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        data = try container.decode(DataModel.self, forKey: .data)
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(data, forKey: .data)
    }
    
}
