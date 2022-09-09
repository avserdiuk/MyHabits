//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 09.09.2022.
//

import Foundation
import UIKit

class HabitDetailsViewController : UIViewController {

    var index : Int = 0

    private lazy var table : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        //table.rowHeight = 44
        //table.backgroundColor = .red
        //tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableCellIdentifier")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")

        return table
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // указываем значение тайтла и его стиль
        self.navigationItem.title = HabitsStore.shared.habits[index].name
        self.navigationController?.navigationBar.prefersLargeTitles = false

        // добавляем инопки слева и справа от тайтла
        let modalSaveAction = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(hideModal))

        navigationItem.rightBarButtonItems = [modalSaveAction]
        navigationItem.rightBarButtonItem?.tintColor = mainPurple


        view.addSubview(table)

        NSLayoutConstraint.activate([

            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])

    }

    // функция сокрытия модального представляения
    @objc func hideModal(){
        dismiss(animated: true)
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
            cell.backgroundColor = .systemBlue
        }

        //TODO: тут нужно поставить галочку как в макете

        return cell






    }



}