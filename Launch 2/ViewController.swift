//
//  ViewController.swift
//  Launch 2
//
//  Created by Игорь Солодянкин on 06.03.2023.
//

import UIKit

class ViewController: UIViewController {

    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let button = UIButton()
    private let titleLabel = UILabel()
    
    let stepText = [
        "Приложение подберет для вас рецепты вкусных блюд с учетом продуктов, которые есть в вашем холодильнике\n\nТри простых шага для вкусного обеда",
        "Отметьте галочками продукты, которые есть у вас в холодильнике",
        "Выберите понравившееся блюдо и ознакомьтесь с рецептурой. При необходимости докупите недостающие продукты. Список продуктов составит приложение",
        "Приготовьте блюдо, следуя инструкции, и насладитесь вкусом. У вас получилось :)",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        setupImageView()
        setupTitleLabel()
        setupScrollView()
        setupButton()
        setupPageControl()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * stepText.count, height: 300)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        setupTextView(title: stepText[0], position: 0)
        setupTextView(title: stepText[1], position: 1)
        setupTextView(title: stepText[2], position: 2)
        setupTextView(title: stepText[3], position: 3)
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Launch")
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTextView(title: String, position: CGFloat) {
        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textView)
        textView.text = title
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isEditable = false

        let screenWidth = UIScreen.main.bounds.width
        textView.frame = CGRect(x: screenWidth * position + 37, y: 0, width: screenWidth - 120, height: 200)
//
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: view.topAnchor),
//            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.5765403509, green: 0.7691472173, blue: 0.3339438438, alpha: 1)
        pageControl.tintColor = #colorLiteral(red: 0.4159630239, green: 0.4159630239, blue: 0.4159630239, alpha: 1)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: button.topAnchor, constant: -50),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        getNoReadyButton()
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Easy Recipes"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 42)
        titleLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40)
        ])
    }
    
    private func getReadyButton() {
        button.setTitle("Готов готовить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5765403509, green: 0.7691472173, blue: 0.3339438438, alpha: 1)
    }
    
    private func getNoReadyButton() {
        button.setTitle("Пропустить", for: .normal)
        button.backgroundColor = .clear
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
        if pageControl.currentPage == 3 {
            getReadyButton()
        } else {
            getNoReadyButton()
        }
    }
}

