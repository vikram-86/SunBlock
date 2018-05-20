//
//  MainSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    // Private
    private let spfSegue	= "spfSegue"

    @IBOutlet weak var segmentView	: SegmentChooserView!
    @IBOutlet weak var spfSelectionView: SPFSelectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.appColor(.perryWinkle)
        
		LocationService.current.delegate	= self
        segmentView.delegate 				= self
        spfSelectionView.delegate 			= self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationService.current.requestLocation()
    }


}

extension MainSceneViewController{

    @objc private func selectSunscreen(){
        performSegue(withIdentifier: spfSegue, sender: nil)
    }
    
}

//MARK: Location Service Delegate
extension MainSceneViewController: LocationServiceDelegate{
    func locationServiceDidFinish(with location: UserLocation) {

        // Check location change and empty weather list

//        let client = WeatherClient()
//        client.getFeed(from: .getWeather(location)) { (result) in
//            switch result{
//            case .success(let weatherResponse):
//                guard let response = weatherResponse else { return }
//                CoreDataStack.current.createWeathers(from: response)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }

    func locationServiceDidFinishWithError(_ error: LocationError) {
        AlertService.presentAlert(with: error.errorDescription!)
    }
}

//MARK: SPFDelegate
extension MainSceneViewController: SPFDelegate{
    func selectorSelected(spf: Int) {
        print(spf)
    }
}

//MARK: SegmentChooserDelegate
extension MainSceneViewController: SegmentChooserDelegate{

    func segmentSelected(environment: Environment) {
        // Update SSE
    }
}
