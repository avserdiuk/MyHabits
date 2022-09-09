//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алексей Сердюк on 08.09.2022.
//

import Foundation
import UIKit

var place = ""
var habbitIndex = 999

class HabitViewController : UIViewController {

    let index = 0
    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)

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

    private lazy var labelTimeHabbitText : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в "
        label.font = UIFont(name: "Helvetica", size: 17)
        return label
    }()
    

    private lazy var labelTimeHabbitTime : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "11:00 PM"
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = mainPurple
        return label
    }()

    private lazy var timePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        return picker
    }()

    private lazy var deleteBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(deleteHabbit) , for: .touchUpInside)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(mainRed, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if place == "Detail" {
            view.backgroundColor = .white
//            habbitName = HabitsStore.shared.habits[habbitIndex].name

            setupEditNavigationBar()
            addViews()
            addConstraints()

            textfieldNameHabbit.text = HabitsStore.shared.habits[habbitIndex].name
            colorPickerButton.backgroundColor = HabitsStore.shared.habits[habbitIndex].color
            labelTimeHabbitTime.text = HabitsStore.shared.habits[habbitIndex].dateString
            timePicker.date = HabitsStore.shared.habits[habbitIndex].date

            view.addSubview(deleteBtn)

            NSLayoutConstraint.activate([
                deleteBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                deleteBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteBtn.heightAnchor.constraint(equalToConstant: 50),
            ])


            // добавляем события для алерта
            alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
                print("отмена удаления")
            }))
            alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
                HabitsStore.shared.habits.remove(at: habbitIndex)
                self.dismiss(animated: true)
            }))
            

        } else {
            view.backgroundColor = .white

            setupNavigationBar()
            addViews()
            addConstraints()


            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.string(from: timePicker.date)
            labelTimeHabbitTime.text = "\(dateFormatter.string(from: timePicker.date))"




        }
    }

    @objc func deleteHabbit(){


        self.present(alertController, animated: true, completion: nil)


       // HabitsStore.shared.habits.remove(at: habbitIndex)
       // dismiss(animated: true)
    }

    @objc func showColorPicker(){
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = colorPickerButton.backgroundColor!
        present(color, animated: true)
    }

    func addViews(){
        view.addSubview(labelNameHabbit)
        view.addSubview(textfieldNameHabbit)
        view.addSubview(labelColorHabbit)
        view.addSubview(colorPickerButton)
        view.addSubview(labelTimeHabbit)
        view.addSubview(labelTimeHabbitText)
        view.addSubview(labelTimeHabbitTime)
        view.addSubview(timePicker)

    }

    func addConstraints(){
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

            labelTimeHabbitText.topAnchor.constraint(equalTo: labelTimeHabbit.bottomAnchor, constant: 7),
            labelTimeHabbitText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            labelTimeHabbitTime.topAnchor.constraint(equalTo: labelTimeHabbit.bottomAnchor, constant: 7),
            labelTimeHabbitTime.leftAnchor.constraint(equalTo: labelTimeHabbitText.rightAnchor, constant: 0),

            timePicker.topAnchor.constraint(equalTo: labelTimeHabbitText.bottomAnchor, constant: 7),
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),

        ])
    }

    func setupNavigationBar(){

        // указываем значение тайтла и его стиль
        self.navigationItem.title = "Создать"

        // настройка навигационного бара
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

    func setupEditNavigationBar(){

        // указываем значение тайтла и его стиль
        self.navigationItem.title = "Правка"

        // настройка навигационного бара
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundGray
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // добавляем инопки слева и справа от тайтла
        let modalDismissAction = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(hideEditModal))
        let modalSaveAction = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveEditHabbit))

        navigationItem.leftBarButtonItems = [modalDismissAction]
        navigationItem.rightBarButtonItems = [modalSaveAction]
        navigationItem.leftBarButtonItem?.tintColor = mainPurple
        navigationItem.rightBarButtonItem?.tintColor = mainPurple

    }

    // функция сокрытия модального представляения
    @objc func hideEditModal(){
        dismiss(animated: true)
    }

    // функция изменения привычки после редактирования
    @objc func saveEditHabbit(){

        HabitsStore.shared.habits[habbitIndex].name = textfieldNameHabbit.text ?? " "
        HabitsStore.shared.habits[habbitIndex].date = timePicker.date
        HabitsStore.shared.habits[habbitIndex].color = colorPickerButton.backgroundColor ?? .black

        HabitsStore.shared.save()

        dismiss(animated: true)
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

    // функция изменения времени привычки после выбора времени в датапикере
    @objc func didSelect(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.string(from: timePicker.date)

        labelTimeHabbitTime.text = "\(dateFormatter.string(from: timePicker.date))"
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {

    // тут мы говорим о том что нужно поменть цвет иконки после выбора цвета
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
    }
}
