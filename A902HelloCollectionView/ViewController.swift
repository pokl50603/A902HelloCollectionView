//
//  ViewController.swift
//  A902HelloCollectionView
//
//  Created by shengyuan on 2022/10/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var theImages:[UIImage?] = []
    @IBOutlet weak var theCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theImages = [UIImage(named: "image1"),
                    UIImage(named: "image2"),
                    UIImage(named: "image3"),
                    UIImage(named: "image4"),
                    UIImage(named: "image5"),
                    UIImage(named: "image6")]
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        setItemInLine(number: 3)
        
    }
    
    @IBAction func changeItemInLine(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
    
        switch value{
        case 0:
            setItemInLine(number: 3)
        case 1:
            setItemInLine(number: 4)
        case 2:
            setItemInLine(number: 5)
        default:
            break
        }
    }
    
    
    func setItemInLine(number:Int){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 10
        
        let screecsize = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: screecsize.width / CGFloat(number) - 10,
                                 height: screecsize.width / CGFloat(number) - 10)
        theCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
//MARK:collectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "abcdefg", for: indexPath) as! MyCollectionViewCell
        cell.theImageView.image = theImages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "提示", message: "放大嗎？", preferredStyle: .alert)
        let cancelaAction = UIAlertAction(title: "取消", style: .default)
        alert.addAction(cancelaAction)
        
        let okAction = UIAlertAction(title: "確定", style: .default){(_) in
            print("有按到 ＯＫ")

            
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "theShowImage")
            as! ShowImageViewController
            nextVC.callBack = {
                let alert = UIAlertController(title: nil, message: "謝謝你的參選", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "知道了", style: .default))
                self.present(alert, animated: true)
            }
            
            self.present(nextVC, animated: true){
                nextVC.theImageView.image = self.theImages[indexPath.row]
            }
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
}

