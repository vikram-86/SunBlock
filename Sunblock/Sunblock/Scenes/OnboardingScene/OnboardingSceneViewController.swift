//
//  OnboardingSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 20.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class OnboardingSceneViewController: UIViewController {

    @IBOutlet weak var scrollView		: UIScrollView!
    @IBOutlet weak var pageController	: UIPageControl!
    @IBOutlet weak var button			: UIButton!


    lazy var titles: [String] = [
        "Disclaimer",
        "GPS location",
        "15 minutes before",
        "Reapply sun screen"
    ]

    lazy var width	: CGFloat = UIScreen.main.bounds.width

    lazy var height	: CGFloat = {
        return scrollView.bounds.height
    }()

    lazy var contents: [String] = [
        "This app is meant as guidance, please remember that your skin may react differently to direct sunlight, always follow directions on sunscreen bottle.",
        "We require your GPS location to measure the right amount of UV radiation, so that we can suggest you appropriate actions.",
        "Apply suncreen to dry skin 15 minutes  before going outdoors.",
        "Dermatologists always recommend reaplying suncreen every two hours, and after swimming or sweating, follow the directions on the bottle."
    ]

    private var pageIndex: CGFloat = 0{
        didSet{
            pageController.currentPage = Int(pageIndex)

            let buttonTitle = Int(pageIndex) == titles.count - 1 ? "accept" : "skip"
            button.setTitle(buttonTitle, for: .normal)
        }
    }

    private var hasShowedLocationAuthorization	= false
    private var hasCompletedOnboardin			= false
    private var service							= LocationService.current
	private let segueIdentifier					= "skinChooser"
    private var locationServiceGranted			= false
    private var shouldPerfomSegue				= false
    private var hasShownKey						= "hasShown"


    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        pageController.numberOfPages	= titles.count
        service.delegate 				= self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hasShowedLocationAuthorization = UserDefaults.standard.bool(forKey: hasShownKey)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if hasShowedLocationAuthorization{
            print("Hello")
        }
    }


    private func setupScrollView(){
        let height = scrollView.bounds.height
        for (i, value) in titles.enumerated(){

            let x = self.view.bounds.width * CGFloat(i)
            let contentView = OnboardingInfoView(x: x, height: height)
            let title = value
            let content = contents[i]
            contentView.setupView(title: title, content: content)
            scrollView.addSubview(contentView)
        }

        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(titles.count), height: 0)

        scrollView.isPagingEnabled	= true
        scrollView.delegate 		= self
    }


}

//MARK: -IBAction
extension OnboardingSceneViewController{
    @IBAction private func buttonPressed(sender: UIButton){
        UserDefaults.standard.set(true, forKey: "shouldSkipOnboarding")
        if sender.currentTitle == "accept"{
            hasCompletedOnboardin = true
            service.requestAuthorization()

        }else{
            hasCompletedOnboardin = false
            shouldPerfomSegue = true
            if !hasShowedLocationAuthorization{
                startSegue()
                return
            }
            service.requestAuthorization()
        }
    }

    private func startSegue(){
        let status = OnboardingStatus(hasCompletedOnboardin: hasCompletedOnboardin, locationServiceGranted: locationServiceGranted)
        status.save()
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SkinChooserSceneViewController{
            vc.fromOnboarding = true
        }
    }
}

extension OnboardingSceneViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        pageIndex = round(scrollView.contentOffset.x / view.frame.width)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if pageIndex == 1,
            !hasShowedLocationAuthorization{
            scrollView.isScrollEnabled = false
            print("Setting up gps location!")
            service.requestAuthorization()
            hasShowedLocationAuthorization = true
            UserDefaults.standard.set(hasShowedLocationAuthorization, forKey: hasShownKey)
            scrollView.isScrollEnabled = true
        }
    }

}

//MARK: - LocationServiceDelegate
extension OnboardingSceneViewController: LocationServiceDelegate{
    func locationServiceDidFinish(with location: UserLocation) {

    }

    func locationServiceDidFinishWithError(_ error: LocationError) {
        switch error{
        case .permissionGranted:
            locationServiceGranted = true

        default:
            locationServiceGranted = false
        }

        if hasCompletedOnboardin || shouldPerfomSegue{
            startSegue()
        }
    }

    func permissionChanged(_ permission: PermissionStatus) {
        
    }
}

//MARK: -
