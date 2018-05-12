//
//  SegmentChooserView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 11.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

@IBDesignable class SegmentChooserView: UIView, NibFileOwnerLoadable{

    @IBOutlet private weak var firstDimmerView: UIView!
    @IBOutlet private weak var secondDimmerView: UIView!
    @IBOutlet private weak var thirdDimmerView: UIView!

    @IBInspectable var selectedIndex = 0 {
        didSet{
            updateSelection(for: selectedIndex)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         setup()
    }

    private func setup(){
        loadNibContent()
        selectedIndex = 1
    }

}

//MARK: Private functions
extension SegmentChooserView{
    private func updateSelection(for index: Int){
        UIView.animate(withDuration: 0.33) {
            if index == 0 {
                self.firstDimmerView.alpha	= 0
                self.secondDimmerView.alpha = 0.75
                self.thirdDimmerView.alpha 	= 0.75
            }else if index == 1{
                self.firstDimmerView.alpha	= 0.75
                self.secondDimmerView.alpha	= 0
                self.thirdDimmerView.alpha	= 0.75
            }else{
                self.firstDimmerView.alpha	= 0.75
                self.secondDimmerView.alpha	= 0.75
                self.thirdDimmerView.alpha	= 0
            }
        }
    }
}

//MARK: IBActions
extension SegmentChooserView{

    @IBAction private func segmentSelected(_ sender: UIButton) {
        print("\(sender.tag) is selected!")
        selectedIndex = sender.tag
    }
}
