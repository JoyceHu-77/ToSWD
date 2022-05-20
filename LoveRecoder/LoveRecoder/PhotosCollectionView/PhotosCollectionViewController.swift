//
//  ViewController.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/20.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    private let navigationBarHeight: CGFloat = 120
    private let marginLeft: CGFloat = 10
    private let bgColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    let layout = WaterFlowLayout()
    
    let photoData = PhotoData()
    
    var dataModels = [DataModel]()
    var curItemWArr = [CGFloat]()
    var curItemHArr = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        self.view.addSubview(collectView)
        self.view.addSubview(navigationBar)
        self.view.addSubview(toolBarStackView)
        loadEntityData()
    }
    
    @objc func addButtonClicked() {
        let addVC = AddInformationViewController()
        addVC.addInformationDelegate = self
        self.present(addVC, animated: true, completion: nil)
    }
    
    @objc func columnCountButtonClicked(sender: UIButton) {
        sender.isSelected.toggle()
        // TODO
    }
     
    @objc func memorialDayButtonClicked() {
        // TODO
    }
    
    func loadEntityData() {
        let entitys = photoData.fetchRequestEntity()
        entitys.forEach { entity in
            guard let imageData = entity.photoImage,
                  let image = UIImage(data: imageData),
                  let des = entity.des
            else {
                return
            }
            
            loadModelData(image: image, des: des)
        }
        collectView.reloadData()
    }
    
    func loadModelData(image: UIImage, des: String?) {
        let model = DataModel(image: image, description: des)
        self.dataModels.append(model)
        layout.dataArray = dataModels
        let imageSize = layout.getAttrsFrame(itemNum: dataModels.count - 1)
        curItemHArr.append(imageSize.itemH)
        curItemWArr.append(imageSize.itemW)
    }
    
    private lazy var collectView: UICollectionView = {
        layout.layout(dataA: dataModels, columns: 2, marginLeft: marginLeft, marginRight: 10, marginMinH: 10, marginMinV: 10)
        let frame = CGRect(x: 0, y: navigationBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - navigationBarHeight - 100)
        let collectView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectView.backgroundColor = bgColor
        collectView.delegate = self
        collectView.dataSource = self
        collectView.showsVerticalScrollIndicator = true
        collectView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ImageCollectionViewCell.self))
        return collectView
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
    
    private lazy var toolBarStackView: UIStackView = {
        let toolBarStackView = UIStackView(frame: CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 80))
        toolBarStackView.backgroundColor = bgColor
        toolBarStackView.axis = .horizontal
        toolBarStackView.alignment = .fill
        toolBarStackView.distribution = .fillEqually
        toolBarStackView.spacing = 0
        
        toolBarStackView.addArrangedSubview(columnCountButton)
        toolBarStackView.addArrangedSubview(addButton)
        toolBarStackView.addArrangedSubview(memorialDayButton)
        return toolBarStackView
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "add_round"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        return addButton
    }()
    
    private lazy var columnCountButton: UIButton = {
        let columnCountButton = UIButton()
        columnCountButton.setTitle("x2", for: .normal)
        columnCountButton.setTitle("x4", for: .selected)
        columnCountButton.setTitleColor(.black, for: .normal)
        columnCountButton.setTitleColor(.black, for: .selected)
        columnCountButton.addTarget(self, action: #selector(columnCountButtonClicked), for: .touchUpInside)
        return columnCountButton
    }()
    
    private lazy var memorialDayButton: UIButton = {
        let memorialDayButton = UIButton()
        memorialDayButton.setTitle("days", for: .normal)
        memorialDayButton.setTitleColor(.black, for: .normal)
        memorialDayButton.addTarget(self, action: #selector(memorialDayButtonClicked), for: .touchUpInside)
        return memorialDayButton
    }()
}


// MARK: - UICollectionViewDelegate
extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ImageCollectionViewCell.self), for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        let model = dataModels[indexPath.row]
        let height = curItemHArr[indexPath.row] - model.labelHeight
        cell.imageView.frame = CGRect(x: 0, y: 0, width: curItemWArr[indexPath.row], height: height)
        cell.imageView.image = model.image
        cell.descriptionLabel.text = model.labelTitle
        cell.descriptionLabel.frame = CGRect(x: 8, y: height, width: curItemWArr[indexPath.row] - 16, height: 50)
        return cell
    }
}


// MARK: - AddInformationVCDelegate
extension PhotosCollectionViewController: AddInformationVCDelegate {
    func getInformation(image: UIImage, des: String) {
        loadModelData(image: image, des: des)
        photoData.addPhotoData(image: image, des: des)
        self.collectView.reloadData()
    }
}









