//
//  Coordinator.swift
//  FinStructure
//
//  Created by Rupa Divya on 4/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinatoors: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
