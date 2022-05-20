//
//  WaterFlowLayout.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/21.
//

import Foundation
import UIKit

class WaterFlowLayout: UICollectionViewFlowLayout {
    lazy var dataArray = [Any]()
    lazy var attrArray:NSMutableArray = NSMutableArray()
    var lie:Int = 0
    lazy var framYArray = [CGFloat](repeating: self.sectionInset.top, count: lie)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout (dataA:[Any],columns:Int,marginLeft:CGFloat,marginRight:CGFloat,marginMinH:CGFloat,marginMinV:CGFloat) {
        
        self.dataArray = dataA
        self.minimumInteritemSpacing = marginMinH
        self.minimumLineSpacing = marginMinV
        self.sectionInset = UIEdgeInsets(top: 0, left:marginLeft , bottom: 0, right: marginRight)
        self.lie = columns
        
    }
    
    override func prepare() {}
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrArray as? [UICollectionViewLayoutAttributes]
    }
    
    override var collectionViewContentSize: CGSize{
        //假设数组的第一列值最大
        var maxY = self.framYArray[0];
        for i in 0 ..< self.framYArray.count {
            if(maxY<self.framYArray[i]){
                maxY = self.framYArray[i]
            }
        }
        return CGSize(width: (self.collectionView?.bounds.size.width)!, height: maxY)
    }
    
    //计算那列的最大Y值最小
    func getMinYoftheframeY(frameYArray:[CGFloat])->(Int){
        //假设第0列的最大Y值最小
        var minIndex:Int = 0
        var minY = frameYArray[minIndex]
        for u in 0 ..< frameYArray.count {
            if(minY > frameYArray[u]){
                minY = frameYArray[u]
                minIndex = u
            }
        }
        return minIndex
    }
    
    
    
    func getAttrsFrame(itemNum: Int) -> (itemW: CGFloat, itemH: CGFloat){
        let indexpath = IndexPath(item: itemNum, section: 0)
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexpath)
        //计算每个宽度
        let allwidth = (self.collectionView?.bounds.size.width)!
        let marginleft = self.sectionInset.left
        let marginRight = self.sectionInset.right
        let totalMargin:CGFloat = ((CGFloat)(lie - 1) * self.minimumInteritemSpacing)
        let itemw:CGFloat = (allwidth - marginRight - marginleft - totalMargin) / (CGFloat)(lie)
        //计算每个高度
        let model: DataModel = self.dataArray[itemNum] as! DataModel
        var itemh: CGFloat = 0
        if let imageWidth = model.cellWidth, let imageHeight = model.cellHeight {
            itemh = imageHeight * itemw / imageWidth + model.labelHeight
        }
        //计算每个X
        //计算当前cell是第几列
        let colunm = self.getMinYoftheframeY(frameYArray: self.framYArray)
        
        let itemX = marginleft + (self.minimumInteritemSpacing + itemw) * (CGFloat)(colunm)
        
        //取出当前的列数的Y值
        let itemY = self.framYArray[colunm]
        attrs.frame = CGRect(x: itemX, y: itemY, width: itemw, height: itemh)
        self.framYArray[colunm] = self.framYArray[colunm] + itemh + self.minimumLineSpacing
        self.attrArray.add(attrs)
        
        return (itemw, itemh)
    }
    
    
    
}
