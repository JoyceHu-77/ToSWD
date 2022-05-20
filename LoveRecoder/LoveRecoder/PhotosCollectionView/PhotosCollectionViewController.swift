//
//  ViewController.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/20.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    let layout = WaterFlowLayout()
    let photoPicker = PhotoPicker()
    
    let photoData = PhotoData()
    
    //TODO
    var descriptionImage = ""
    
    var dataModels = [DataModel]()
    var curItemWArr = [CGFloat]()
    var curItemHArr = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPicker.currentVC = self
        photoPicker.photoPickerDelegate = self
        self.view.addSubview(collectView)
        self.view.addSubview(btn)
        loadEntityData()
    }
    
    lazy var btn: UIButton = { () -> UIButton in
        var value = UIButton(frame: CGRect(x: 0, y: view.frame.height / 4 + view.frame.height / 2, width: view.frame.width, height: view.frame.height / 8))
        value.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.6761153265)
        value.setTitle("open photo library", for: .normal)
        value.addTarget(self, action: #selector(createDataModel), for: .touchUpInside)
        return value
    }()
    
    lazy var collectView: UICollectionView = {
        layout.layout(dataA: dataModels, columns: 2, marginLeft: 10, marginRight: 10, marginMinH: 10, marginMinV: 10)
//        let layout = UICollectionViewFlowLayout()
        let collectView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.showsVerticalScrollIndicator = true
        collectView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ImageCollectionViewCell.self))
        return collectView
    }()
    
    @objc func createDataModel() {
        photoPicker.goImage()
    }
    
    func loadEntityData() {
        let entitys = photoData.fetchRequestEntity()
        entitys.forEach { entity in
            guard let imageData = entity.photoImage, let image = UIImage(data: imageData) else { return }
            loadModelData(image: image, des: nil)
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
        cell.descriptionLabel.text = "平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐平安喜乐"
        cell.descriptionLabel.frame = CGRect(x: 5, y: height, width: curItemWArr[indexPath.row] - 10, height: 50)
        return cell
    }
}

// MARK: - PhotoPickerGetImage
extension PhotosCollectionViewController: PhotoPickerGetImage {
    func getImage(image: UIImage) {
        loadModelData(image: image, des: nil)
        photoData.addPhotoData(image: image, des: nil)
        self.collectView.reloadData()
    }
}








