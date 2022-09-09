//
//  HabbitsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 07.09.2022.
//

import Foundation
import UIKit

class HabbitsViewController : UIViewController {

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "CustomProgressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "CustomHabbitCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = backgroundLightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])

//          HabitsStore.shared.habits.removeAll()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData()
        print("перерисовка")
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
        place = "NewHabbit"
        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
}


extension HabbitsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        // собираем нулевой элемент как прогресс бар

        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomProgressCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            cell.setup()
            cell.layer.cornerRadius = 8
            return cell
        }

        // для всех остальных элементов делаем по кастомную ячейку привычки

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomHabbitCell", for: indexPath) as? HabitCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.layer.cornerRadius = 8
        cell.setup(index: indexPath.row - 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            habbitIndex = indexPath.row - 1
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.index = indexPath.row - 1
            navigationController?.pushViewController(habitDetailsViewController, animated: false)
        }


    }
}

extension HabbitsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 0 {
            return CGSize(width: view.frame.width-32 , height: 60)
        }

        return CGSize(width: view.frame.width-32 , height: 130)
    }
}
