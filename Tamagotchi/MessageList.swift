//
//  MessageList.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/06.
//

import UIKit

struct Message {
    
    var name = UserDefaults.standard.string(forKey: "userName")
    
    let growMessage: [String] = ["nickname님 배고파용", "좋은 하루 보내세요, nickname님", "감사해요 nickname님!!", "오늘은 기분이 좋아용!", "행복한 기분이에용!", "nickname님도 행복했으면 좋겠어용", "오늘 하루 어떠셨나요?", "nickname님 덕분에 행복해용"]
    
    let maxMessage: [String] = ["nickname님 덕분에 다 컸어요!", "배불러용ㅠㅠ", "저 이제 다 컸어요! 고마워요 nickname님^_^"]
    let levelUPMessage: [String] = ["nickname님이 밥이랑 물 준 덕분에 이렇게 성장했어용!!", "저 많이 컸어용 고마워요 nickname님>_<", "nickname님이 돌봐주셔서 너무 행복해용"]
    
}
