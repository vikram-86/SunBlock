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
    @IBOutlet private weak var tapButton						: UIButton!

    @IBOutlet weak var buttonViewLeadingConstraint: NSLayoutConstraint!

	// Ingen spf 0,2 eller 4
    private var dataSource = [
        0,10,15,20,25,30,35,40,45,50
    ]

    private var xCoordinates	= [CGFloat]()
    private var labels			= [UILabel]()
    private var impact			= UISelectionFeedbackGenerator()

    private var shouldShowPicker 	= false
    private var value 				= 0{
        didSet{
            impact.selectionChanged()
            self.valueLabel.text = "\(value)"
            DispatchQueue.main.async {
                if self.value >= 10{
                    let currentDevice = UIDevice.currentDevice
                    if currentDevice == .iPhone5 || currentDevice == .unknown{
                        self.buttonViewLeadingConstraint.constant = 40
                        self.layoutIfNeeded()
                    }
                }else{
                    self.buttonViewLeadingConstraint.constant = 70
                    self.layoutIfNeeded()
                }
            }

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
        //initializeContent()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(labelSelected))
        valueLabel.addGestureRecognizer(gesture)
        valueLabel.isUserInteractionEnabled = true


    }

    func initializeContent(){
        scrollContainerWidthContraint.constant = 0

        var xCoordinate		: CGFloat = 0
        var markerOffset	: CGFloat = 0
        var contentWidth	: CGFloat = 0
        dataSource.forEach {

            let content = createSliderContent(with: "\($0)", coordinateX: xCoordinate)
            xCoordinate = content.xCoordinate
            scrollView.addSubview(content.label)

            labels.append(content.label)
            if $0 == 0{
                xCoordinates.append(markerOffset)
            }else{
                markerOffset = (content.xCoordinate + (content.width / 2)) - (frame.width / 2)
                xCoordinates.append(markerOffset)
            }

            xCoordinate += content.width + 25
            contentWidth += content.width + 25
        }

        contentWidth += self.bounds.width


		//(self.bounds.width + 950)
        scrollView.contentSize = CGSize(width: contentWidth, height: 50)
        scrollView.delegate = self
        markerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selected)))
        self.layoutIfNeeded()
    }

    func userTappedOut(){
        if shouldShowPicker{

            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
            animate()
        }
    }

    private func  createSliderContent(with text: String, coordinateX: CGFloat) -> (label: UILabel, xCoordinate: CGFloat, width: CGFloat){
        // Create Label
        let label 			= UILabel()
        label.text			= text
        label.textAlignment	= .center
        label.textColor		= UIColor.appColor(.dirtyPurple)
        label.font			= UIFont.appFont(with: .nevis, size: 50)


        label.sizeToFit()

        //add Gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        var x: CGFloat
        if coordinateX == 0{
            x = (frame.width / 2) - (label.frame.width / 2)
        }else{
            x = coordinateX
        }
        // adjust label frame
        label.frame = CGRect(x: x, y: 0, width: label.frame.width, height: 50)
        return (label, x, label.frame.width)
    }
}

//MARK: IBAction
extension SPFSelectionView{
    @IBAction func selectSunScreen(){
        animate()
    }

    @objc func tapped(sender: UITapGestureRecognizer){
        guard
        	let label = sender.view as? UILabel,
        	let index = labels.index(of: label)
        else {
            return
        }
        let xCoordinate	= xCoordinates[index]
        let point 		= CGPoint(x: xCoordinate, y: 0)
        scrollView.setContentOffset(point, animated: true)
    }

    @objc func labelSelected(){
        shouldShowPicker = false
        animate()
    }

    @IBAction private func sectionTapped(){
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

        let index = dataSource.index(of: value)!
        scrollView.contentOffset = CGPoint(x: xCoordinates[index], y: 0)
        scrollView.alpha = 0
		tapButton.isHidden = true
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {

            self.labelLeadingConstraint.constant    = (self.bounds.width / 2) - (self.valueLabel.frame.width / 2)
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

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            self.valueLabel.sizeToFit()
            self.labelLeadingConstraint.constant    = (self.bounds.width / 2) - (self.valueLabel.frame.width / 2)
            self.layoutIfNeeded()
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3, animations: {
                self.titleLabel.isHidden	= false
                self.scrollView.alpha 		= 0

            })
			self.scrollContainerWidthContraint.constant = 0
            UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3, animations: {
                self.valueLabel.isHidden    = false
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
            self.tapButton.isHidden = false
        }
    }
}

//MARK: ScrollViewDelegate
extension SPFSelectionView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
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
        guard let index	= dataSource.index(of: value) else { return .zero}
        
        let offset = xCoordinates[index]
        return CGPoint(x: offset, y: 0)
    }
}
