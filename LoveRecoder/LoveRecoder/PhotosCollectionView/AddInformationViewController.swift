//
//  AddInformationViewController.swift
//  LoveRecoder
//
//  Created by Blacour on 2022/5/20.
//

import UIKit

public protocol AddInformationVCDelegate: AnyObject {
    func getInformation(image: UIImage, des: String)
}

class AddInformationViewController: UIViewController {
    
    private let navigationBarHeight: CGFloat = 120
    private let marginLeft: CGFloat = 10
    private let bgColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    private let photoPicker = PhotoPicker()
    
    weak var addInformationDelegate: AddInformationVCDelegate?
    
    private var photoImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        view.addSubview(navigationBar)
        view.addSubview(contentView)
        view.addSubview(postButton)
        
        photoPicker.currentVC = self
        photoPicker.photoPickerDelegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    @objc func addImageButtonClicked(sender: UIButton) {
        photoPicker.goImage()
    }
    
    @objc func postButtonClicked(sender: UIButton) {
        guard let photoImage = photoImage, let des = textView.text else { return }
        addInformationDelegate?.getInformation(image: photoImage, des: des)
        dismiss(animated: true, completion: nil)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame = CGRect(x: marginLeft, y: navigationBarHeight, width: self.view.bounds.width - 20, height: 350)
        contentView.layer.cornerRadius = 20
        contentView.addSubview(textView)
        contentView.addSubview(addImageStackView)
        return contentView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.frame = CGRect(x: marginLeft, y: 10, width: self.view.bounds.width - 40, height: 200)
        textView.backgroundColor = .white
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .left
        textView.font = UIFont(name: "Helvetica-Light", size: 22)
        textView.text = "输入描述，小于25个字"
        textView.keyboardType = .default
        textView.returnKeyType = .default
        
        textView.isEditable = true //文字是否可编辑
        
        return textView
    }()
    
    private lazy var addImageStackView: UIStackView = {
        let addImageStackView = UIStackView()
        let spacing: CGFloat = 10
        let height = self.view.bounds.width / 3
        let width = height * 2 + spacing
        addImageStackView.frame = CGRect(x: marginLeft, y: 200, width: width, height: height)
        addImageStackView.axis = .horizontal
        addImageStackView.alignment = .fill
        addImageStackView.distribution = .fillEqually
        addImageStackView.spacing = spacing
        addImageStackView.addArrangedSubview(addImageButton)
        addImageStackView.addArrangedSubview(imageView)
        return addImageStackView
    }()

    private lazy var addImageButton: UIButton = {
        let addImageButton = UIButton()
        addImageButton.layer.cornerRadius = 10
        addImageButton.clipsToBounds = true
        addImageButton.setImage(UIImage(named: "add_square"), for: .normal)
        addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
        return addImageButton
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: self.view.bounds.width / 3, height: self.view.bounds.width / 3)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var postButton: UIButton = {
        let postButton = UIButton()
        let width = self.view.bounds.width / 3
        postButton.frame = CGRect(x: self.view.bounds.width - width - marginLeft, y: 380 + navigationBarHeight, width: width, height: 50)
        postButton.setTitle("add", for: .normal)
        postButton.setTitleColor(.black, for: .normal)
        postButton.backgroundColor = .white
        postButton.layer.cornerRadius = 20
        postButton.clipsToBounds = true
        postButton.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        return postButton
    }()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: navigationBarHeight)
        navigationBar.backgroundColor = bgColor
        navigationBar.addSubview(navigationBarLabel)
        return navigationBar
    }()
    
    private lazy var navigationBarLabel: UILabel = {
        let navigationBarLabel = UILabel(frame: CGRect(x: marginLeft, y: 70, width: 500, height: 30))
        navigationBarLabel.text = "HCY To SWD 💐"
        navigationBarLabel.textAlignment = .left
        navigationBarLabel.textColor = .black
        navigationBarLabel.font = UIFont.boldSystemFont(ofSize: 30)
        return navigationBarLabel
    }()
}

extension AddInformationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "输入描述，小于25个字"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension AddInformationViewController: PhotoPickerGetImage {
    func getImage(image: UIImage) {
        imageView.image = image
        photoImage = image
    }
}
