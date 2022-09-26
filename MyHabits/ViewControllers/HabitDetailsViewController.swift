//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 09.09.2022.
//

import Foundation
import UIKit

class HabitDetailsViewController : UIViewController {

    var index : Int = 0 // переменная для понимания с какой привычкой мы работаем

    private lazy var table : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        view.addSubview(table)
        addConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if mark == 1 {
            self.navigationController?.popViewController(animated: true)
            mark = 0
        }
    }

    func setupView(){
        view.backgroundColor = .white

        // указываем значение тайтла и его стиль
        self.navigationItem.title = HabitsStore.shared.habits[index].name
        self.navigationController?.navigationBar.prefersLargeTitles = false

        // добавляем инопку справа от тайтла
        let modalSaveAction = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showModal))

        navigationItem.rightBarButtonItems = [modalSaveAction]
        navigationItem.rightBarButtonItem?.tintColor = habbitColorPurple
    }

    // функция открытия модального представляения
    @objc func showModal(){
        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        callPlace = "fromDetail"
        self.present(navController, animated:true, completion: nil)
    }

    // прописываем констрейнты
    func addConstraints(){
        NSLayoutConstraint.activate([

            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])
    }
}

extension HabitDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}

extension HabitDetailsViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        cell.backgroundColor = .white
        let text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.textLabel?.text = text

        
        if HabitsStore.shared.habit(HabitsStore.shared.habits[index], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
            img.image = UIImage(systemName: "checkmark")
            cell.accessoryView = img
        }

        return cell

    }
}
