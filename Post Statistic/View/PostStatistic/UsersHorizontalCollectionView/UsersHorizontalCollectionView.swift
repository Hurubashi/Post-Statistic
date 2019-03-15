//
//  UsersHorizontalCollectionView.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/13/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import UIKit

class UsersHorizontalCollectionView: UIView {
    
    // Outlets
    @IBOutlet weak var oneLineStatisticView: OneLineStatisticView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Variables userd to load view from nib
    private var view    : UIView!
    private var nibName : String    = "UsersHorizontalCollectionView"
    
    // Variables with data
    var users           : [User]    = []
    
    // MARK : - Loading from nib functions
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
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UserPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "UserPhotoCell")
        addSubview(view)
    }
    
}

// MARK: - CollectionView DataSource
extension UsersHorizontalCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPhotoCell", for: indexPath) as! UserPhotoCollectionCell
        if let data = users[indexPath.row].imgData {
            cell.userPhotoImg.image = UIImage(data: data)
        }
        return cell
    }


}

