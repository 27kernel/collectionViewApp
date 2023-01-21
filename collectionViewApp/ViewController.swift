//
//  ViewController.swift
//  collectionViewApp
//
//  Created by Ruslan Baigeldiyev on 21.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate {
    var collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var label = UILabel()
    var tableView = UITableView()
    var images = [UIImage(named: "model3"), UIImage(named: "modelS"), UIImage(named: "modelX"), UIImage(named: "modelY"), UIImage(named: "cybertrack"), UIImage(named: "image6"), UIImage(named: "image7"), UIImage(named: "image8"), UIImage(named: "image9"), UIImage(named: "image10"), UIImage(named: "image11")]
    var selectedImage: UIImage?
    var selectedImageName: String?
    
    /*
    var images = [(image: UIImage, name: String)]()
    images = [(UIImage(named: "model3")!, "model3"), (UIImage(named: "modelS")!, "modelS"), (UIImage(named: "modelX")!, "modelX"), (UIImage(named: "modelY")!, "modelY"), (UIImage(named: "cybertrack")!, "cybertrack")]
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView1()
        setupCollectionView2()
        setupLabel()
        setupTableView()
        
        view.backgroundColor = .black
    }

    func setupCollectionView1() {
        collectionView1.register(CollectionView1Cell.self, forCellWithReuseIdentifier: "cell1")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.backgroundColor = .black
        


        let layout = collectionView1.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 119, height: 180)
        //layout.minimumLineSpacing = 10
        //layout.collectionView?.isPagingEnabled = true
        
        
        collectionView1.isScrollEnabled = true
        collectionView1.showsHorizontalScrollIndicator = false
        collectionView1.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        
        view.addSubview(collectionView1)
        
        collectionView1.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalTo(view).offset(1)
            make.height.equalTo(350)
        }
    }

    func setupCollectionView2() {
        collectionView2.register(CollectionView2Cell.self, forCellWithReuseIdentifier: "cell2")
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.backgroundColor = .black
        
        view.addSubview(collectionView2)
        
        collectionView2.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView1.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(300)
            //make.width.equalTo(-500)
        }
        //let layout = collectionView2.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.itemSize = collectionView2.bounds.size
        let layout = collectionView2.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:selectedImage?.size.width ?? 400, height: (selectedImage?.size.height ?? 200))
    }
    
    func setupLabel() {
        label.text = "Tap to picture"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        //label.font = UIFont(name: "Bolt", size: 40)
        label.font = label.font.withSize(25)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView2.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(50)
        }
    }

    func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return images.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionView1Cell
            cell.configure(with: images[indexPath.item]! )
            return cell
        } else {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionView2Cell
            if let selected = selectedImage {
                cell.configure(with: selected, imageName: "")
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView1 {
            let cell = collectionView1.cellForItem(at: indexPath) as! CollectionView1Cell
            selectedImage = cell.imageView.image
            selectedImageName = "Picture: \(indexPath.item + 1)"
            collectionView2.reloadData()
        } else {
            let cell = collectionView2.cellForItem(at: indexPath) as! CollectionView2Cell
            selectedImageName = cell.imageName
        }
        label.text = selectedImageName
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.configure(with: collectionView1, collectionView2: collectionView2, label: label)
        return cell
    }
}

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {

    }
    
    func configure(with collectionView1: UICollectionView, collectionView2: UICollectionView, label: UILabel) {
        
    }
}

class CollectionView1Cell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
}

class CollectionView2Cell: UICollectionViewCell {
    let imageView = UIImageView()
    var imageName: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()
    {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with image: UIImage, imageName: String) {
        imageView.image = image
        self.imageName = imageName
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
