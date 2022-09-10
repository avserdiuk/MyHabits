//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 09.09.2022.
//

import Foundation
import UIKit

class HabitCollectionViewCell : UICollectionViewCell {

    private lazy var labelName : UILabel = {
        let label = UILabel()
        label.text = "Выпить стакан воды"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    private lazy var labelTime : UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        return label
    }()

    private lazy var labelCount : UILabel = {
        let label = UILabel()
        label.text = "Счетчик 0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()

    private lazy var btnStatus : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 19
        btn.layer.borderWidth = 2
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        return btn
    }()

        private lazy var imageCheck : UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named:"check")
            img.translatesAutoresizingMaskIntoConstraints = false
            img.isHidden = true
            return img
        }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .white

        contentView.addSubview(labelName)
        contentView.addSubview(labelTime)
        contentView.addSubview(labelCount)
        contentView.addSubview(btnStatus)
        contentView.addSubview(imageCheck)

        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            labelTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            labelTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            labelCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            labelCount.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            btnStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            btnStatus.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            btnStatus.heightAnchor.constraint(equalToConstant: 38),
            btnStatus.widthAnchor.constraint(equalToConstant: 38),

            imageCheck.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 57),
            imageCheck.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
            imageCheck.heightAnchor.constraint(equalToConstant: 16),
            imageCheck.widthAnchor.constraint(equalToConstant: 16),

        ])

    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)

    }

    @objc func clickBtn(){
        let index = labelName.tag

        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            print("уже трекали")
        } else {
            btnStatus.backgroundColor = UIColor(cgColor: btnStatus.layer.borderColor!)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            labelCount.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"
            imageCheck.isHidden = false

            // кидаем уведомление для обновления коллекции
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        }

    }

    func setup(index : Int) {

        labelName.tag = index
        btnStatus.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        labelName.text = HabitsStore.shared.habits[index].name
        labelName.textColor = HabitsStore.shared.habits[index].color
        labelTime.text = HabitsStore.shared.habits[index].dateString
        labelCount.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"

        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            btnStatus.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[index].color.cgColor)
            imageCheck.isHidden = false
        } else {
            btnStatus.backgroundColor = nil
            imageCheck.isHidden = true
        }
    }
}
