//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 09.09.2022.
//

import Foundation
import UIKit

class ProgressCollectionViewCell : UICollectionViewCell {


    private lazy var label : UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()

    private lazy var labelProgress : UILabel = {
        let label = UILabel()
        label.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()

    private lazy var progressBar : UIProgressView = {
        let bar = UIProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.progress = HabitsStore.shared.todayProgress
        bar.tintColor = habbitColorPurple
        return bar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        contentView.addSubview(label)
        contentView.addSubview(labelProgress)
        contentView.addSubview(progressBar)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),

            labelProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelProgress.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(){
        labelProgress.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        progressBar.progress = HabitsStore.shared.todayProgress
    }

}
