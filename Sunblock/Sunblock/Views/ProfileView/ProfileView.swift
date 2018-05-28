//
//  ProfileView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 06.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol ProfileViewDelegate: class {

    func view(didSelectURL url: URL)
}
@IBDesignable class ProfileView: UIView{

    @IBOutlet weak private var profileImageView	: UIImageView!
    @IBOutlet weak private var nameLabel		: UILabel!
    @IBOutlet weak private var descriptionLabel	: UILabel!


    private var profile: Profile!
    weak var delegate : ProfileViewDelegate?
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

extension ProfileView{
    @IBAction func facebookButtonPressed(){
        let url = URL(string: self.profile.facebook)!
        delegate?.view(didSelectURL: url)
    }

    @IBAction func linkedInButtonPressed(){
        let url = URL(string: self.profile.linkedIn)!
        delegate?.view(didSelectURL: url)
    }
}

extension ProfileView: NibFileOwnerLoadable{}

