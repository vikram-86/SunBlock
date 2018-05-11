//
//  SPFSelectorSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 11.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol SPFSelectorSceneDelegate: class {
    func sceneSelected(spf: Int)
}

class SPFSelectorSceneViewController: UIViewController{

    @IBOutlet private weak var pickerView: UIPickerView!

    weak var delegate: SPFSelectorSceneDelegate?
    private var dataSource: [Int] {
        return [0,4,6,8,10,15,20,25,30,40,50]
    }
    
}

//MARK: Lifecycle

extension SPFSelectorSceneViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

// MARK: IBActions
extension SPFSelectorSceneViewController{

    @IBAction private func close(){
        self.dismiss(animated: true)
    }

    @IBAction private func select(){
        let spf = pickerView.selectedRow(inComponent: 0)
        delegate?.sceneSelected(spf: dataSource[spf])
        close()
    }
}

// MARK: UIPickerView Datasource
extension SPFSelectorSceneViewController: UIPickerViewDataSource{

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: UIPickerView Delegate
extension SPFSelectorSceneViewController: UIPickerViewDelegate{

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = SPFView()
        view.set(value: dataSource[row])
        return view
    }
}
