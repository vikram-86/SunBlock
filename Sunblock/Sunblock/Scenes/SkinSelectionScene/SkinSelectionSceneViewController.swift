//
//  SkinSelectionSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 29.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class SkinSelectionSceneViewController: UIViewController {
    struct SegueIdentifier{
        static let main = "main"
    }

    @IBOutlet weak var avatarView				: SkinSelectionAvatarView!
    @IBOutlet weak var infoContainerView		: UIView!
    @IBOutlet weak var seSelectionView			: SESkinSelectionView!
    @IBOutlet weak var skinSelectionView		: SkinSelectionView!
    @IBOutlet weak var labelScrollView			: UIScrollView!

    var skinTypes	: [SkinType]{
        return SkinType.allSkinTypes
    }

    var pageIndex: Int = 0{
        didSet{
            self.avatarView.updateImages(with: skinTypes[pageIndex])
            self.seSelectionView.updateButton(at: pageIndex)
            self.skinSelectionView.updateButtonView(at: pageIndex)
        }
    }
    var fromOnboarding = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelScrollView.delegate 	= self
        skinSelectionView.delegate	= self
        seSelectionView.delegate 	= self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        seSelectionView.setupColorButtons()
        avatarView.updateImages(with: .type1)
        setupLabels()
        seSelectionView.updateButton(at: pageIndex)
        skinSelectionView.setupButtonBackground()
        skinSelectionView.updateButtonView(at: pageIndex)

        if UIDevice.currentDevice == .iPhone5{

            seSelectionView.isHidden 	= false
            skinSelectionView.isHidden	= true
        }else{
            seSelectionView.isHidden	= true
            skinSelectionView.isHidden	= false
        }

        let skinType = SkinType.load()
        if let index = skinTypes.index(of: skinType){
            self.labelScrollView.setContentOffset(CGPoint(x: self.view.bounds.width * CGFloat(index), y: 0), animated: false)
        }

        UIApplication.shared.statusBarStyle = .lightContent
    }

    private func setupLabels(){
        for (index, type) in skinTypes.enumerated(){

            let x 		= self.view.bounds.width * CGFloat(index) + 30
            let y 		= CGFloat(0)
            let width 	= CGFloat(270)
            let height	= labelScrollView.bounds.height
            let label	= UILabel(frame: CGRect(x: x, y: y, width: width, height: height))


            let attributedString	= NSMutableAttributedString(string: type.skinDescription)
            let paragafStyle = NSMutableParagraphStyle()
            paragafStyle.lineHeightMultiple = 1.4
            paragafStyle.lineSpacing = 0
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragafStyle, range: NSMakeRange(0, attributedString.length))


            label.attributedText	= attributedString
            let size	: CGFloat	= UIDevice.currentDevice == .iPhone5 ? 15 : 19
            label.font				= UIFont.appFont(with: .archivoRegular, size: size)
            label.textColor			= UIColor.appColor(.dirtyPurple)


            label.numberOfLines	= 0
            label.contentMode = .top
            labelScrollView.addSubview(label)
        }
        labelScrollView.contentSize = CGSize(width:
            self.view.bounds.width * CGFloat(skinTypes.count),
                                             height: 0)
    }

    private func saveCurrentSkin(){
        let type = skinTypes[pageIndex]
        type.save()
        if fromOnboarding{
            calculateSegue()
            fromOnboarding = false
        }else{
            if let navController = self.navigationController{
                navController.popViewController(animated: true)
            }
        }
    }

    private func calculateSegue(){
        guard let _ = OnboardingStatus.load() else {
            self.navigationController?.popViewController(animated: true)
            return
        }

        performSegue(withIdentifier: SegueIdentifier.main, sender: nil)
    }
}


extension SkinSelectionSceneViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        self.pageIndex = Int(pageIndex)
    }
}

extension SkinSelectionSceneViewController: SESkinSelectionDelegate{
    func didSelectCurrentSkin() {
        saveCurrentSkin()
    }
}

extension SkinSelectionSceneViewController: SkinSelectionDelegate{
    func didChangeSkin(at index: Int) {
        let x = view.frame.width * CGFloat(index)
        let point = CGPoint(x: x, y: 0)
        labelScrollView.setContentOffset(point, animated: true)
    }

    func didSelectSkin() {
        saveCurrentSkin()
    }
}
