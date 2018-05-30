//
//  MainSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    @IBOutlet weak var titleLabel			: UILabel!
    @IBOutlet weak var subTitleLabel		: UILabel!
    @IBOutlet weak var uvLabel				: UILabel!
    @IBOutlet weak var uvImageView			: UIImageView!
    @IBOutlet weak var temperatureLabel		: UILabel!
    @IBOutlet weak var weatherIconImageView	: UIImageView!
    @IBOutlet weak var sseView				: SSEView!
    @IBOutlet weak var segmentView    		: SegmentChooserView!
    @IBOutlet weak var spfSelectionView		: SPFSelectionView!
    @IBOutlet weak var uvTitleLabel			: UILabel!
    @IBOutlet weak var temperatureUnitLabel	: UILabel!
    @IBOutlet weak var scrollView			: UIScrollView!


    // Private
    private struct SegueIdentifers{
        static let spfSegue    		= "spfSegue"
        static let mainToDisclaimer	= "mainToDisclaimer"
        static let mainToLocation	= "mainToLocation"

        private init(){}
    }



    private var currentEnvironment: Environment {
        return Environment.load()
    }

    private var currentSkinType: SkinType {
        return SkinType.load()
    }

    private var weathers: [Weather] = []{
        didSet{
            // Update SSE..
            updateSSE()

            // Get peak
        }
    }

    private var currentSPF: Int = 1{
        didSet{
            // Update SSE..
            updateSSE()
        }
    }

    private var currentWeather: Weather?

    private var isReloading = false

    let reachability = Reachability()!
    private var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.appColor(.perryWinkle)
        

        segmentView.delegate 				= self
        spfSelectionView.delegate 			= self

        titleLabel.isHidden 			= true
        subTitleLabel.isHidden 			= true
        uvLabel.isHidden 				= true
        uvImageView.isHidden 			= true
        temperatureLabel.isHidden 		= true
        weatherIconImageView.isHidden	= true

        let refreshControl = UIRefreshControl()
        let attributes : [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.appColor(.white)]
        refreshControl.attributedTitle  = NSAttributedString(string: "Updating weather data", attributes: attributes)
        refreshControl.tintColor = UIColor.appColor(.white)
        refreshControl.addTarget(self, action: #selector(refresh(refreshView:)), for: .valueChanged)
        scrollView.insertSubview(refreshControl, at: 0)
        self.refreshControl = refreshControl
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationService.current.delegate    = self


        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi{
                print("Reachable wia wifi")
            }else{
                print("Reacahble wia Cellular")
            }
        }

        reachability.whenUnreachable = { _ in
            AlertService.presentAlert(with: "Please turn on cellular connectivity to download new data", title: "No Connectivity")
        }

        do{
            try reachability.startNotifier()
        }catch{
            print("Unable to start notifier")
        }

        UIApplication.shared.statusBarStyle = .lightContent
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidBecomeActive), name: .UIApplicationWillEnterForeground, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let status = OnboardingStatus.load(){
            switch (status.hasCompletedOnboardin, status.locationServiceGranted){
            case (false, _):
                performSegue(withIdentifier: SegueIdentifers.mainToDisclaimer, sender: nil)
            case (true, true):
                LocationService.current.requestLocation()
            case (true, false):
                performSegue(withIdentifier: SegueIdentifers.mainToLocation, sender: nil)

            }
        }
    }

    @objc func viewDidBecomeActive(){
        updateSSE()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationService.current.delegate = nil
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .viewTouched, object: nil)

    }
}

//MARK: - SSE
extension MainSceneViewController{
    private func updateSSE(){
        guard let weather = weathers.first else{
            AlertService.presentAlert(with: "Weather list is empty")
            return
        }

        currentWeather = weather
        let sse = SSEController(weather: weather, environment: currentEnvironment, skinType: currentSkinType, spf: currentSPF)
		let subtitleContent = calculatePeak()
        let subtitleText = "Max. UV level is \(subtitleContent.uv) at \(subtitleContent.time)"
        DispatchQueue.main.async {
            self.titleLabel.text                 = sse.title
            self.subTitleLabel.text              = subtitleText
            self.uvLabel.text                    = sse.uvIndex
            self.uvImageView.image               = sse.uvIcon
            self.temperatureLabel.text           = sse.temperature
            self.weatherIconImageView.image      = sse.weatherIcon

            self.view.backgroundColor            = sse.headerColor



            self.uvTitleLabel.isHidden                = false
            self.temperatureUnitLabel.isHidden        = false
            self.titleLabel.isHidden                  = false
            self.subTitleLabel.isHidden               = false
            self.uvLabel.isHidden                     = false
            self.uvImageView.isHidden                 = false
            self.temperatureLabel.isHidden            = false
            self.weatherIconImageView.isHidden        = false

            self.sseView.configure(with: sse.sse)
        }
        UIView.animate(withDuration: 1, animations: {
            self.view.backgroundColor = sse.headerColor
        })
    }

    private func calculatePeak()->(uv: Int, time: String){
        var currentPeakUV	= 0
        var time	: Int64 = 0
        var index           = 0

        for (weatherIndex, weather) in weathers.enumerated() {
            if Int(weather.uvIndex) > currentPeakUV{
                time = weather.time
                index = weatherIndex
                currentPeakUV = Int(weather.uvIndex)
            }
        }

        let timeString = Date.timeString(for: Double(time))
        return (currentPeakUV, timeString)
    }
}

extension MainSceneViewController{

    @objc private func selectSunscreen(){
        performSegue(withIdentifier: SegueIdentifers.spfSegue, sender: nil)
    }

    @objc func refresh(refreshView: UIRefreshControl){
        LocationService.current.requestLocation()
        refreshView.endRefreshing()
    }
    
}

//MARK: Location Service Delegate
extension MainSceneViewController: LocationServiceDelegate{
    func locationServiceDidFinish(with location: UserLocation) {

        if let lastLocation = UserLocation.load(){
            if lastLocation != location{
                // Clear Persistance
                location.save()
                CoreDataStack.current.clearStorage()
                // Load new weather data from Net
                loadWeathersFromNet(for: location)
            }else{
                // Get list of weather for current location,
                if let weathers = Weather.loadWeathersFromPersistance(),
                    !weathers.isEmpty{
                    let downloadTime = UserDefaults.standard.integer(forKey: "downloadTime")
                    if Date.isCurrentDay(from: Double(downloadTime)){
                        self.weathers = weathers
                    }else{
                        CoreDataStack.current.clearStorage()
                        loadWeathersFromNet(for: location)
                    }
                    // Take the first weather and Update SSE
                }else{
                    CoreDataStack.current.clearStorage()
                    loadWeathersFromNet(for: location)
                }
            }
        }else{
            location.save()
            loadWeathersFromNet(for: location)
        }
    }

    private func loadWeathersFromNet(for location: UserLocation){
        let client = WeatherClient()
        client.getFeed(from: .getWeather(location)) { (result) in
            switch result{
            case .success(let response):
                guard let response = response else {
                    AlertService.presentAlert(with: "Could not download new weather data, please try again later")
                    return
                }
                let currentWeathers = CoreDataStack.current.createWeathers(from: response)
                self.weathers = currentWeathers
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "downloadTime")
            case .failure(let error):
                AlertService.presentAlert(with: error.localizedDescription)
            }
        }
    }

    func locationServiceDidFinishWithError(_ error: LocationError) {
        AlertService.presentAlert(with: error.errorDescription!)
    }

    func permissionChanged(_ permission: PermissionStatus) {
        if permission == .granted{
            LocationService.current.requestLocation()
        }
    }
}

//MARK: SPFDelegate
extension MainSceneViewController: SPFDelegate{
    func selectorSelected(spf: Int) {
        currentSPF = spf
    }
}

//MARK: SegmentChooserDelegate
extension MainSceneViewController: SegmentChooserDelegate{

    func segmentSelected(environment: Environment) {
        // Update SSE
        environment.save()
        updateSSE()
    }
}
