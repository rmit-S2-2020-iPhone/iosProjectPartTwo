//
//  Storyboard.swift
//  FinStructure
//
//  Created by Rupa Divya on 4/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit
protocol Storyboard {
    static func instantiate() ->Self
}
extension Storyboard where Self: UIViewController{
    static func instantiate() ->Self{
        let id = String(describing: self)
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
