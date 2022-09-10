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
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "CustomProgressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "CustomHabbitCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = habbitColorLightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addViews()
        addConstraints()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData() // обновляем коллекцию при переходе на вью

        // Наблюдаем за уведомлением и если приходит нужное - обновляем коллекцию
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(methodOfReceivedNotification(notification:)),
                                               name: Notification.Name("reloadData"),
                                               object: nil)
    }

    // Настраиваем навигационный бар
    private func setupView(){

        view.backgroundColor = .white

        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = habbitColorGray

        // Создаем UIBarButtonItem с 1 контейнером по заданию
        let modalAddHabbit = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modalAddHabbit]
        navigationItem.rightBarButtonItem?.tintColor = habbitColorPurple
    }

    @objc func methodOfReceivedNotification(notification: Notification) {
        collectionView.reloadData()
    }

    private func addViews(){
        view.addSubview(collectionView)
    }

    private func addConstraints(){
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])
    }


    // вызываем модальное окно навигационным баром
    @objc func showModal(){
        callPlace = "fromNewHabbit" // ставим метку что вызов произошел именно из этого вью

        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
}

extension HabbitsViewController : UICollectionViewDataSource {

    // в нашей коллекции будет столько элементов сколько будет в массиве привычек. +1 элемент для прогресс бара
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count + 1
    }

    // собираем нулевой элемент как прогресс бар, остальные элементы как карточки привычек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomProgressCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.layer.cornerRadius = 8
            cell.setup()
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

    // при нажатии на элемент мы переходим в детальное представление (кроме 0 элемента, т.к. там прогресс бар)
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
    // настраиваем размеры для элементов по макету
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width-32 , height: 60) // прогресс бар
        }
        return CGSize(width: view.frame.width-32 , height: 130) // карточки привычки
    }
}
