

import UIKit

var allCirclePositions = [[CirclePosition]]()
var isWall = [[Int]]()

class ViewController: UIViewController, UIAlertViewDelegate {
    var btns = [[UIButton]]()
    var catView = UIImageView()
    var catPos: (Int, Int) = (-1,-1)

                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var bg = UIImageView()
        bg.frame = CGRectMake(0,0,320,480)
        bg.image = UIImage(named: "bg.png")
        self.view.addSubview(bg)
        
        createBtns()
        createCirclePositions()
        createCat()
        createWalls()
        
        
    }
    
    func createCirclePositions() {
        for var i = 0; i < 9; i++ {
            var rowPoss = [CirclePosition]()
            for var j = 0; j < 9; j++ {
                var pos = CirclePosition(row: i, col: j)
                rowPoss.append(pos)
            }
            allCirclePositions.append(rowPoss)
        }
    }
    
    func createBtns() {
        for var i = 0; i < 9; i++ {
            var rowBtns = [UIButton]()
            var rowInts = [Int]()
            for var j = 0; j < 9; j++ {
                var btn = UIButton()
                var btnImage = UIImage(named: "gray.png")
                btn.setImage(btnImage, forState: UIControlState.Normal)
                btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                btn.frame = getRectByPosition(i, col: j)
                rowBtns.append(btn)
                rowInts.append(0)
                self.view.addSubview(btn)
            }
            btns.append(rowBtns)
            isWall.append(rowInts)
        }
    }
    
    func createCat() {
        
        catView.frame = getCatRectByPosition(4, col: 4)
        var l = UIImage(named: "left2.png")
        var m = UIImage(named: "middle2.png")
        var r = UIImage(named: "right2.png")
        catView.animationImages = [l, m, r]
        catView.animationDuration = 1.0
        catView.startAnimating()
        isWall[4][4] = 1
        catPos = (4,4)
        
        self.view.addSubview(catView)
    }
    
    func createWalls() {
        var wallNum = (Int)(arc4random() % 30 + 10)
        while 0 < wallNum {
            let i = (Int)(arc4random() % 9)
            let j = (Int)(arc4random() % 9)
            if(isWall[i][j] == 0) {
                isWall[i][j] = 1
                btns[i][j].setImage(UIImage(named: "yellow.png"), forState: UIControlState.Normal)
                wallNum -= 1
            }
        }
    }
    
    func moveTo(row: Int, col: Int) {
        catView.frame = getCatRectByPosition(row, col: col)
        isWall[catPos.0][catPos.1] = 0
        isWall[row][col] = 1
        catPos = (row,col)
        
        if row == 0 || row == 8 || col == 0 || col == 8 {
            lose()
        }
    }
    
    func reset() {
        for var i = 0; i < 9; i++ {
            for var j = 0; j < 9; j++ {
                isWall[i][j] = 0
                catPos = (4, 4)
                moveTo(4, col: 4)
                btns[i][j].setImage(UIImage(named: "gray"), forState: UIControlState.Normal)
            }
        }
        createWalls()
    }
    
    func win() {
        let winCofirm = UIAlertView(title: "Win", message: "win", delegate: self, cancelButtonTitle: "嗯")
        winCofirm.show()
    }
    
    func lose() {
        let loseCofirm = UIAlertView(title: "Lose", message: "lose", delegate: self, cancelButtonTitle: "嗯")
        loseCofirm.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        reset()
    }

    func btnClick(btn: UIButton) {
        var pos: (Int, Int) = getPositionByRect(btn.frame)
        if isWall[pos.0][pos.1] == 0 {
            isWall[pos.0][pos.1] = 1
            btn.setImage(UIImage(named: "yellow.png"), forState: UIControlState.Normal)
            
            var cp: CirclePosition = allCirclePositions[catPos.0][catPos.1]
            var np = cp.getNextPosition()
            if np.0 != -1 && np.1 != -1 {
                moveTo(np.0, col: np.1)
                println("moveTo: \(np.0), \(np.1)")
            }
            else {
                win()
            }
        }
    }
    
    //func get
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getRectByPosition(row: Int, col: Int) ->  CGRect{
        if row % 2 == 0 {
            return CGRectMake((CGFloat)(20 + col * 28 + 14), (CGFloat)(170 + row * 28), 28, 28)
        }
        else {
            return CGRectMake((CGFloat)(20 + col * 28), (CGFloat)(170 + row * 28), 28, 28)
        }
    }
    
    func getPositionByRect(rect: CGRect) -> (Int, Int) {
        var x = (Int)(rect.minX)
        var y = (Int)(rect.minY)
        
        if x % 28 == 20 {
            return ((y - 170) / 28, (x - 20) / 28)
        }
        else {
            return ((y - 170) / 28, (x - 34) / 28)
        }
    }
    
    func getCatRectByPosition(row: Int, col: Int) ->  CGRect{
        let tmp = row - 1
        if row % 2 == 0 {
            return CGRectMake((CGFloat)(20 + col * 28 + 14), (CGFloat)(170 + tmp * 28), 28, 56)
        }
        else {
            return CGRectMake((CGFloat)(20 + col * 28), (CGFloat)(170 + tmp * 28), 28, 56)
        }
    }
}

