//
//  TamagotchiInfo.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/05.
//

import Foundation

struct TamagotchiInfo: Codable {
    let name: String
    let profile: String
    var imgNum: Int
    var water = 0
    var meal = 0
    
    func level() -> Int {
        var score = (meal / 5) + (water / 2)
        let level = Int(score / 10)
        if level == 0 {
            return 1
        }else if level <= 10 {return level}
        else {return 10}
    }
    
    
}
