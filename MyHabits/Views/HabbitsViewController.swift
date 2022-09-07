//
//  HabbitsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 07.09.2022.
//

import Foundation
import UIKit

class HabbitsViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Создаем UIBarButtonItem с 1 контейнером по заданию
        let modal = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modal]
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 161/255.0, green: 22/255.0, blue: 204/255.0, alpha: 1)
    }

    @objc func showModal(){

    }
}
