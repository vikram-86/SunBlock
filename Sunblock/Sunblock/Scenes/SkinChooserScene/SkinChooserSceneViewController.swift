//
//  SkinChooserSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 15.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class SkinChooserSceneViewController: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var collectionView	: UICollectionView!
    @IBOutlet var skinColorButtons		: [MainButton]!
    @IBOutlet weak var buttonContainer	: UIView!

    struct SegueIdentifiers{
        static let disclaimer 			= "disclaimerSegue"
        static let disclaimerToLocation	= "disclaimerToLocation"
        static let disclaimerToMain		= "disclaimerToMain"
        static let location				= "location"
        static let locationToMain		= "locationToMain"
        static let main					= "main"
    }

    private lazy var source    : [SkinType] = {
        return SkinType.allSkinTypes
    }()

    private lazy var skinButtonColors: [ColorNames] = {
        return [ColorNames.lightMustard, ColorNames.lightPeach,
                ColorNames.blush,ColorNames.sandbrown,
                ColorNames.copper, ColorNames.cocoa ]
    }()

    var fromOnboarding = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource 			= self
        collectionView.delegate 			= self
        buttonContainer.setRoundedCorners	= true

        if UIDevice.isIPhone5{
            buttonContainer.isHidden = true
        }
        setupButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(fromOnboarding)
    }

    @IBAction func SkinButtonPressed(_ sender: MainButton) {

        guard
            let index = skinButtonColors.index(of: sender.currentBackgroundName)
        else{ return }

        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }

    @IBAction private func selectButtonPressed(_ sender: Any) {
        guard
            let cell = collectionView.visibleCells.first,
        	let index = collectionView.indexPath(for: cell)
        else{
            return
        }

        let type = source[index.item]
        type.save()
        if fromOnboarding{
            calculateSegue()
            fromOnboarding = false

        }else{
            if let navController = self.navigationController{
                navController.popViewController(animated: true)
            }
        }
        
        // Save current skintype to persistance
    }
}

//MARK: -Private functions
extension SkinChooserSceneViewController{
    private func setupButtons(){
        for (index,button) in skinColorButtons.enumerated(){
            button.cornerRadius = button.frame.width * 0.5
            button.currentBackgroundName = skinButtonColors[index]

        }
    }

    private func calculateSegue(){
        guard let _ = OnboardingStatus.load() else {
            self.navigationController?.popViewController(animated: true)
            return
        }

        performSegue(withIdentifier: SegueIdentifiers.main, sender: nil)
    }
}

// MARK: -UICollectionView DataSource
extension SkinChooserSceneViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(for: indexPath) as SkinTypeCell
        cell.configureCell(with: source[indexPath.row])
        return cell
    }
}


//MARK: -UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension SkinChooserSceneViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width 	= UIScreen.main.bounds.width
        let height	= UIScreen.main.bounds.height
        return CGSize(width: width, height: height)
    }

}
