//
//  CellProtocol.swift
//  SimSim2ChatBot
//
//  Created by Roy's Saxy MacBook on 2/2/23.
//

import Foundation
import UIKit

protocol getNib{
    static var nib : UINib{
        get
    }
}

protocol getIdentifier{
    static var identifier : String{
        get
    }
}

extension getNib{
    static var nib : UINib{
        return UINib(nibName: String(describing: Self.self), bundle: .main)
    }
}

extension getIdentifier{
    static var identifier : String{
        return String(describing: Self.self)
    }
}

extension UITableViewCell : getNib{}
extension UITableViewCell : getIdentifier{}
