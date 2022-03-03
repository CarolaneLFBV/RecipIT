//
//  CustomSwitch.swift
//  Recipit
//
//  Created by Carolane Lefebvre on 02/03/2022.
//

import SwiftUI

@IBDesignable
class CustomSwitch: UISwitch {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetUp()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetUp()
    }
    
    private func initialSetUp() {
        self.addTarget(self, action: #selector(refreshUI), for: .valueChanged)
        self.refreshUI()
    }
    
    @objc private func refreshUI() {
        /// Be aware that this is more of a hack than a solution
        /// And can break in any upcoming release
        let targetSubview = self.subviews.first?.subviews.first
        
        if self.isOn {
            self.thumbTintColor = .red
            targetSubview?.backgroundColor = .white
        }
        else {
            self.thumbTintColor = .yellow
            targetSubview?.backgroundColor = .black
        }
    }
}
