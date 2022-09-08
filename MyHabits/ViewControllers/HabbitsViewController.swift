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

        setupNavigationBar()

    }

    // Настраиваем навигационный бар
    func setupNavigationBar(){

        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundGray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // Создаем UIBarButtonItem с 1 контейнером по заданию
        let modalAddHabbit = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modalAddHabbit]
        navigationItem.rightBarButtonItem?.tintColor = mainPurple
    }

    // вызываем модальное окно навигационным баром
    @objc func showModal(){
        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
}
