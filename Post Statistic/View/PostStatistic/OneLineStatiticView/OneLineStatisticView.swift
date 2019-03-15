//
//  OneLineStatisticView.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/13/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import UIKit

class OneLineStatisticView: UIView {
    
    @IBOutlet weak var statsticName: UILabel!
    
    private var view    : UIView!
    private var nibName : String    = "OneLineStatisticView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let nib = UINib(nibName: nibName, bundle: .main)
        let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView) ?? UIView()
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        statsticName.text = "Default value! Del me pls, Goshujin-sama"
        addSubview(view)
    }
    
}
