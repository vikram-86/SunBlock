//
//  SegmentChooserView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 11.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol SegmentChooserDelegate: class {
    func segmentSelected(environment: Environment)
}

@IBDesignable class SegmentChooserView: UIView, NibFileOwnerLoadable{

    @IBOutlet private weak var firstDimmerView: UIView!
    @IBOutlet private weak var secondDimmerView: UIView!
    @IBOutlet private weak var thirdDimmerView: UIView!

    @IBOutlet weak var firstLabel	: UILabel!
    @IBOutlet weak var secondLabel	: UILabel!
    @IBOutlet weak var thirdLabel	: UILabel!


    private var environtment = Environment.city
    weak var delegate	: SegmentChooserDelegate?

    @IBInspectable var selectedIndex = 0 {
        didSet{
            updateSelection(for: selectedIndex)
            self.environtment = Environment.init(value: selectedIndex)
            self.environtment.save()
            self.delegate?.segmentSelected(environment: self.environtment)
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
                self.firstLabel.alpha 		= 1

                self.secondDimmerView.alpha = 0.75
                self.secondLabel.alpha		= 0

                self.thirdDimmerView.alpha 	= 0.75
                self.thirdLabel.alpha		= 0

            }else if index == 1{
                self.firstDimmerView.alpha	= 0.75
                self.firstLabel.alpha		= 0

                self.secondDimmerView.alpha	= 0
				self.secondLabel.alpha		= 1

                self.thirdDimmerView.alpha	= 0.75
                self.thirdLabel.alpha		= 0

            }else{
                self.firstDimmerView.alpha	= 0.75
                self.firstLabel.alpha		= 0

                self.secondDimmerView.alpha	= 0.75
                self.secondLabel.alpha		= 0

                self.thirdDimmerView.alpha	= 0
                self.thirdLabel.alpha		= 1
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
