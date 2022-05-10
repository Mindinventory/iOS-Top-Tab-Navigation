//
//  TopTabbarView.swift
//  CustomTopBarDemo
//
//  Created by Parth Gohel on 09/05/22.
//

import Foundation
import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    var tabbarTitleLabel: UILabel = UILabel(frame: .zero)
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        loadTitleLabel()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    private func loadTitleLabel() {
        
        tabbarTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tabbarTitleLabel)
        NSLayoutConstraint.activate([
            tabbarTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tabbarTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tabbarTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tabbarTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func configureLabel() {
        tabbarTitleLabel.textAlignment = .center
    }
    
    func configure(with title: String) {
        tabbarTitleLabel.text = title
    }
    
    func configureStyle(
        font: UIFont = UIFont.boldSystemFont(ofSize: 18),
        foregroundColor: UIColor = .white
    ){
        tabbarTitleLabel.font = font
        tabbarTitleLabel.textColor = foregroundColor
    }
}

public enum TabBarItemStyle {
    case setStyle(font:UIFont, foregroundColor: UIColor)
    case none
}

public class TopTabbarView: UIView {

   public var collectionView: TabBarCollectionView = TabBarCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    public var dataSource: [String] = [] {
        didSet {
            collectionView.numberOfTabItem = dataSource.count
        }
    }
    
    public var dotColor: UIColor = .red {
        didSet {
            collectionView.dotColor = dotColor
        }
    }

    /// Wave Height
    public var waveHeight: CGFloat = 20 {
        didSet {
            collectionView.waveHeight = waveHeight
        }
    }
    
    public var leftPadding: CGFloat = 50 {
        didSet {
            leadingConstraint?.constant = leftPadding
        }
    }
    
    public var tabBarColor: UIColor = .systemBlue {
        didSet {
            collectionView.layerFillColor = tabBarColor
            contentView.backgroundColor = tabBarColor
            backgroundColor = .clear
            (collectionView.cellForItem(at: [0,0]) as? ItemCollectionViewCell)?.tabbarTitleLabel.textColor = .red
        }
    }

    public var rightPadding: CGFloat = 50 {
        didSet {
            trailingConstraint?.constant = -rightPadding
        }
    }
    public var tabBarItemStyle: TabBarItemStyle = .none {
        didSet {
            collectionView.reloadData()
        }
    }

    public var isScaleItem: Bool = true
    public var onItemSelected: ((Int) -> Void)?
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    var contentView: UIView = UIView(frame: .zero)

    private var priviousSelectedIndex: Int = -1
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        loadCollectionView()
        loadContentView()
        configureCollectionView()
    }
}

extension TopTabbarView {
    
    private func loadContentView() {

        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -collectionView.minimalHeight),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])

        contentView.backgroundColor = .orange
        contentView.superview?.sendSubviewToBack(contentView)
    }
    
    private func loadCollectionView() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        leadingConstraint = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftPadding)
        trailingConstraint = collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rightPadding)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -collectionView.minimalHeight),
            leadingConstraint!,
            trailingConstraint!,
        ])

        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    private func configureCollectionView() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layerFillColor = tabBarColor
        contentView.backgroundColor = tabBarColor
        collectionView.numberOfTabItem = dataSource.count
    }

   private func performSpringAnimation(for cell: ItemCollectionViewCell, index: Int) {
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.collectionView.update(with: index)
            
        }, completion: { _ in
            self.collectionView.animating = false
        })
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            if self.isScaleItem {
                cell.tabbarTitleLabel.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            }
        }, completion: nil)
    }
}

extension TopTabbarView: UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout {
   public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(with: dataSource[indexPath.row])
        switch tabBarItemStyle {
        case .setStyle(let font, let foreground):
        cell.configureStyle(font: font, foregroundColor: foreground)
        case .none: break
        }
        return cell
    }
    
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/CGFloat(dataSource.count), height: collectionView.bounds.size.height)
    }

   public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell
        else { return }
        onItemSelected?(indexPath.row)
        if indexPath.row != self.priviousSelectedIndex {
            
            (collectionView as? TabBarCollectionView)?.animating = true
            
            let orderedTabBarItemViews: [UIView] = {
                let interactionViews = collectionView.subviews.filter({ $0 is ItemCollectionViewCell })
                return interactionViews.sorted(by: { $0.frame.minX < $1.frame.minX })
            }()
            
            orderedTabBarItemViews.forEach({ (objectView) in
                let objectIndex = orderedTabBarItemViews.firstIndex(of: objectView)
                if indexPath.row ==  objectIndex {}
                else if  objectIndex == priviousSelectedIndex {
                    guard let cell = collectionView.cellForItem(at: [0, priviousSelectedIndex]) as? ItemCollectionViewCell
                    else { return }
                    UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                        if self.isScaleItem {
                            cell.tabbarTitleLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                        }
                    }, completion: nil)
                }
            })
            priviousSelectedIndex = indexPath.row
            performSpringAnimation(for: cell, index: indexPath.row+1)
        }
    }
}
