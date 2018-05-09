//
//  ProfileView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 06.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

@IBDesignable class ProfileView: UIView{

    @IBOutlet weak private var profileImageView	: UIImageView!
    @IBOutlet weak private var nameLabel		: UILabel!
    @IBOutlet weak private var descriptionLabel	: UILabel!

    private var profile: Profile!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
}

//MARK: Public Interface
extension ProfileView{

    func configure(with profile: Profile){
        self.profile 			= profile
        profileImageView.image 	= profile.profileImage
        nameLabel.text 			= profile.name
        descriptionLabel.text	= profile.description
    }
}

extension ProfileView: NibFileOwnerLoadable{}
