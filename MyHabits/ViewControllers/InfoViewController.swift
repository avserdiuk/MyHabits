//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 07.09.2022.
//

import Foundation
import UIKit

class InfoViewController : UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: content.frame.height)
        return scrollView
    }()

    private lazy var content : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLable : UILabel = {
        let label = UILabel()
        label.text = "Информация"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var informationLable : UILabel = {
        let label = UILabel()
        label.text = informatiosText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        addViews()
        addConstraints()
    }

    // настраиваем представление и нав бар
    func setupView(){
        view.backgroundColor = .white

        self.title = "Сегодня"

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = habbitColorGray
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // добавляем все необходимое на экран
    func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        content.addSubview(titleLable)
        content.addSubview(informationLable)
    }

    // прописываем констрейнты
    func addConstraints(){
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),

            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            content.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            titleLable.topAnchor.constraint(equalTo: content.topAnchor, constant: 22),
            titleLable.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16),

            informationLable.topAnchor.constraint(equalTo: content.topAnchor, constant: 62),
            informationLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            informationLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            informationLable.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -22),
        ])
    }
}
