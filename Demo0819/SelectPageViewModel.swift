//
//  SelectPageViewModel.swift
//  Demo0819
//
//  Created by 維衣 on 2023/10/23.
//

import Foundation

class Select﻿PageViewModel{
    var currentIndex: Int = 0
    var escapeRoomIntrodutions: [[String: String]] = []
    
    init(introductions: [[String:String]]) {
        escapeRoomIntrodutions = introductions
    }
    
    func currentIntrodution() -> [String: String] {
        return escapeRoomIntrodutions[currentIndex]
    }

}
