//
//  ASCollectionViewController.swift
//  AttributedStringTest
//
//  Created by shilani on 14/12/2024.
//

import UIKit

class ASCollectionViewController: UICollectionViewController {
    var textView: ReusableTextView?
    
    private var dataSource: DataSource!
    var text: AttributedText {
        didSet{
            updateSnapshot()
            textView?.attributedText = text
        }
    }
    
    
//------------------------------------------------Initialisers
    init() {
        let layout = ASCollectionViewController.layout()
        let firstText  = AttributedText()//AttributedText(text: NSMutableAttributedString(string: ""), attributes: [.bold(isActive: false),.color(isActive: false)])
        text = firstText
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//--------------------------------------------------ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.frame =  CGRect(x: 10, y: 10, width: Int(view.frame.width - 20.0), height: Int(view.frame.height - 20.0))//= view.bounds
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath:  IndexPath, itemIdentifier: Attribute) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ReusableTextView.elementKind, handler: supplementaryRegistrationHandler)
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
}



extension ASCollectionViewController{
    typealias DataSource = UICollectionViewDiffableDataSource<Int,Attribute>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int,Attribute>
    
    
//-------------------------------------------------------------CompositionalLayout
     static func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1/6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ReusableTextView.elementKind, alignment: .top)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
//----------------------------------------------------------------------Handlers
    func cellRegistrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, attribute: Attribute) {
        var contentConfiguration = cell.buttonViewConfiguration()
        contentConfiguration.attribute = attribute
        contentConfiguration.onChange = { [weak self] updatedAttribute in
            self?.text.attributes[indexPath.item] = updatedAttribute
                }
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementaryRegistrationHandler(headerLabel: ReusableTextView, elementKind: String, indexPath: IndexPath){
        textView = headerLabel
        textView?.attributedText = text
    }
    
    
//---------------------------------------------------------------------UpdateSnapshot
    func updateSnapshot(){
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(text.attributes)
        dataSource.apply(snapshot)
    }
}

//---------------------------------------------------------Add custom configuration to class cell
extension UICollectionViewCell{
    func buttonViewConfiguration()-> ButtonContentView.Configuration{
        return ButtonContentView.Configuration()
    }
}
