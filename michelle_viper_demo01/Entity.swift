//
//  Entity.swift
//  michelle_viper_demo01
//
//  Created by Michelle on 19/09/2017.
//  Copyright © 2017 Michelle. All rights reserved.
//

import Foundation



enum VIPERs: String {
    case one
    case two
}

extension VIPERs {
    var identifier : String {
        return self.rawValue
    }
}
