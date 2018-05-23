//
//  SPFSelectionView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 19.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol SPFDelegate: class{
    func selectorSelected(spf: Int)
}
@IBDesignable class SPFSelectionView: UIView, NibFileOwnerLoadable{


    //MARK: - IBOutlet
    @IBOutlet private weak var scrollContainerView				: UIView!
    @IBOutlet private weak var scrollContainerWidthContraint	: NSLayoutConstraint!
    @IBOutlet private weak var scrollView						: UIScrollView!
    @IBOutlet private weak var markerView						: UIView!
    @IBOutlet private weak var labelLeadingConstraint			: NSLayoutConstraint!
    @IBOutlet private weak var valueLabel						: UILabel!
    @IBOutlet private weak var spfLabel							: UILabel!
    @IBOutlet private weak var buttonContainerView				: UIView!
    @IBOutlet private weak var titleLabel						: UILabel!



    private var dataSource = [
        0,2,4,6,8,10,15,20,25,30,40,50
    ]

    private var xCoordinates	= [CGFloat]()
    private var labels			= [UILabel]()
    private var impact			= UISelectionFeedbackGenerator()

    private let labelWidth: CGFloat = 70
    private var shouldShowPicker 	= false
    private var value 				= 0{
        didSet{
            impact.selectionChanged()
            self.valueLabel.text = "\(value)"
            delegate?.selectorSelected(spf: (value == 0 ? 1 : value))
        }
    }

    weak var delegate : SPFDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

//MARK: Private functions
extension SPFSelectionView{
    private func setup(){
        loadNibContent()
        initializeContent()
    }

    private func initializeContent(){
        scrollContainerWidthContraint.constant = 0

        var xCoordinate = (self.frame.width / 2) - (labelWidth / 2)
        var markerOffset: CGFloat = 0
        dataSource.forEach {
            let label = UILabel(frame: CGRect(x: xCoordinate, y: 0, width: labelWidth, height: 50))
            label.text 			= "\($0)"
            label.textAlignment	= .center
            label.textColor		= UIColor.appColor(.dirtyPurple)
            label.font			= UIFont.appFont(with: .nevis, size: 50)
            
            scrollView.addSubview(label)
            labels.append(label)
            xCoordinates.append(markerOffset)
            xCoordinate += labelWidth + 10
            markerOffset += labelWidth + 10
        }

        scrollView.contentSize = CGSize(width: (self.bounds.width + 950), height: 50)
        scrollView.delegate = self
        markerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selected)))
        self.layoutIfNeeded()
    }
}

//MARK: IBAction
extension SPFSelectionView{
    @IBAction func selectSunScreen(){
        animate()
    }

    private func animate(){
        shouldShowPicker = !shouldShowPicker
        if shouldShowPicker{
            animateOut()
        }else{
            animateIn()
        }
    }

    @objc func selected(){
        animate()
    }

    // Expand scroll view
    private func animateOut(){

//        scrollContainerWidthContraint.constant = self.bounds.width
//        labelLeadingConstraint.constant    = (self.bounds.width / 2) - (labelWidth / 2)
//
//        titleLabel.isHidden = true
//        UIView.animate(withDuration: 0.33, animations: {
//            self.layoutIfNeeded()
//            self.spfLabel.alpha = 0
//            self.buttonContainerView.alpha = 0
//
//        }) { (_) in
//            self.valueLabel.isHidden = true
//        }
        let index = dataSource.index(of: value)!
        scrollView.contentOffset = CGPoint(x: xCoordinates[index], y: 0)
        scrollView.alpha = 0

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            self.labelLeadingConstraint.constant    = (self.bounds.width / 2) - (self.labelWidth / 2)
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3, animations: {
                self.layoutIfNeeded()
                self.spfLabel.alpha = 0
                self.buttonContainerView.alpha = 0
                self.titleLabel.alpha = 0
            })
			self.scrollContainerWidthContraint.constant = self.bounds.width
            UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3, animations: {
                self.layoutIfNeeded()
            })

            UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3, animations: {
                self.scrollView.alpha = 1
            })
        }) { (_) in
            self.valueLabel.isHidden = true
        }
    }

    // collapse Scrollview
    private func animateIn(){
//        scrollContainerWidthContraint.constant = 0
//        labelLeadingConstraint.constant = 40
//
//
//        UIView.animate(withDuration: 0.33, animations: {
//            self.layoutIfNeeded()
//            self.spfLabel.alpha = 1
//            self.buttonContainerView.alpha = 1
//            self.valueLabel.isHidden = false
//            }){ (_) in
//                self.titleLabel.isHidden = false
//        }

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3, animations: {
                self.titleLabel.isHidden	= false
                self.scrollView.alpha 		= 0
                self.valueLabel.isHidden	= false
            })
			self.scrollContainerWidthContraint.constant = 0
            UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3, animations: {
                self.layoutIfNeeded()
            })
			self.labelLeadingConstraint.constant = 40
            UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3, animations: {
                self.layoutIfNeeded()
                self.spfLabel.alpha = 1
                self.buttonContainerView.alpha = 1
                self.titleLabel.alpha = 1
            })
        }) { (_) in

        }
    }
}

//MARK: ScrollViewDelegate
extension SPFSelectionView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let markerFrame = CGRect(x: markerView.frame.origin.x + scrollView.contentOffset.x,
                                 y: 0, width: markerView.bounds.width, height: markerView.bounds.height)

        for label in labels{
            if label.frame.intersects(markerFrame){
                if let labelValue = Int(label.text!),
                    value != labelValue{
                    value = labelValue
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

		let offset = getOffsetPoint()
        scrollView.setContentOffset(offset, animated: true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = getOffsetPoint()
        scrollView.setContentOffset(offset, animated: true)
    }

    private func getOffsetPoint() -> CGPoint{
        guard let index = dataSource.index(of: value) else { return .zero}
        let offset = xCoordinates[index]
        return CGPoint(x: offset, y: 0)
    }
}
