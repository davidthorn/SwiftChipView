//
//  ChipViewModel.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

protocol ChipViewModelProtocol {
    var title: String { get }
    func calculateSize() -> CGSize
}

struct ChipViewModel: ChipViewModelProtocol {
    let title: String
    func calculateSize() -> CGSize {
        let nsString = NSString(string: title)
        return nsString.size(withAttributes: nil)
    }
}
