//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 08.09.2022.
//

import Foundation
import UIKit

class HabitViewController : UIViewController {

    private lazy var labelNameHabbit : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        return label
    }()

    private lazy var textfieldNameHabbit : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont(name: "Helvetica", size: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var labelColorHabbit : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        return label
    }()

    private lazy var colorPickerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(showColorPicker) , for: .touchUpInside)
        return button
    }()

    private lazy var labelTimeHabbit : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВРЕМЯ"
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        return label
    }()

    private lazy var labelTimeHabbit2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в: "
        label.font = UIFont(name: "Helvetica", size: 17)
        return label
    }()

    private lazy var timePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()

        view.addSubview(labelNameHabbit)
        view.addSubview(textfieldNameHabbit)
        view.addSubview(labelColorHabbit)
        view.addSubview(colorPickerButton)
        view.addSubview(labelTimeHabbit)
        view.addSubview(labelTimeHabbit2)
        view.addSubview(timePicker)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.string(from: timePicker.date)

        labelTimeHabbit2.text = "Каждый день в \(dateFormatter.string(from: timePicker.date))"

        NSLayoutConstraint.activate([

            labelNameHabbit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            labelNameHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            textfieldNameHabbit.topAnchor.constraint(equalTo: labelNameHabbit.bottomAnchor, constant: 7),
            textfieldNameHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textfieldNameHabbit.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            labelColorHabbit.topAnchor.constraint(equalTo: textfieldNameHabbit.bottomAnchor, constant: 15),
            labelColorHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            colorPickerButton.topAnchor.constraint(equalTo: labelColorHabbit.bottomAnchor, constant: 7),
            colorPickerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),

            labelTimeHabbit.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            labelTimeHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            labelTimeHabbit2.topAnchor.constraint(equalTo: labelTimeHabbit.bottomAnchor, constant: 7),
            labelTimeHabbit2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            timePicker.topAnchor.constraint(equalTo: labelTimeHabbit2.bottomAnchor, constant: 7),
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),


        ])

    }

    @objc func showColorPicker(){
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = colorPickerButton.backgroundColor!
        present(color, animated: true)

    }

    func setupNavigationBar(){

        // указываем значение тайтла и его стиль
        self.navigationItem.title = "Создать"

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundGray
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // добавляем инопки слева и справа от тайтла
        let modalDismissAction = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(hideModal))
        let modalSaveAction = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabbit))

        navigationItem.leftBarButtonItems = [modalDismissAction]
        navigationItem.rightBarButtonItems = [modalSaveAction]
        navigationItem.leftBarButtonItem?.tintColor = mainPurple
        navigationItem.rightBarButtonItem?.tintColor = mainPurple

    }

    // функция сокрытия модального представляения
    @objc func hideModal(){
        dismiss(animated: true)
    }

    // функция создания привычки
    @objc func saveHabbit(){

        let newHabbit = Habit(
            name: textfieldNameHabbit.text ?? " ",
            date: timePicker.date,
            color: colorPickerButton.backgroundColor ?? .black)

        let store = HabitsStore.shared
        store.habits.append(newHabbit)

        dismiss(animated: true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
    }
}
