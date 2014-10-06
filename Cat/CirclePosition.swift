

import Foundation

var isVisited = [
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0]
]

var path = [
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
    [(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1),(-1,-1)],
]

class CirclePosition {
    var row:Int
    var col:Int
    var cost:Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
        cost = -100;
    }
    
    func getLeft() -> CirclePosition? {
        var newp: CirclePosition? = nil
        if col > 0 {
            newp = allCirclePositions[row][col - 1]
        }
        return newp
    }
    
    func getRight() -> CirclePosition? {
        var newp: CirclePosition? = nil
        if col > 0 {
            newp = allCirclePositions[row][col + 1]
        }
        return newp
    }
    
    func getLeftUp() -> CirclePosition? {
        var newp: CirclePosition? = nil
        if(row > 0) {
            if row % 2 == 0 {
                newp = allCirclePositions[row - 1][col]
            }
            else {
                if col == 0 {
                    newp = nil
                }
                else {
                    newp = allCirclePositions[row - 1][col - 1]
                }
            }
        }
        return newp
    }
    
    func getRightUp() -> CirclePosition? {
        var newp: CirclePosition? = nil
        if row > 0 {
            if row % 2 == 1 {
                if col >= 8 {
                    newp = nil
                }
                else {
                    newp = allCirclePositions[row - 1][col]
                }
            }
            else {
                newp = allCirclePositions[row - 1][col + 1]
            }
        }
        return newp
    }
    
    func getLeftDown() ->CirclePosition? {
        var newp: CirclePosition? = nil
        if row < 8 {
            if row % 2 == 0 {
                newp = allCirclePositions[row + 1][col]
            }
            else {
                if col < 8 {
                    newp = allCirclePositions[row + 1][col - 1]
                }
                else {
                    newp = nil
                }
            }
        }
        return newp
    }
    
    func getRightDown() -> CirclePosition? {
        var newp: CirclePosition? = nil
        if row < 8 {
            if row % 2 == 0 {
                newp = allCirclePositions[row + 1][col + 1]
            }
            else {
                if col < 8 {
                    newp = allCirclePositions[row + 1][col]
                }
                else {
                    newp = nil
                }
            }
        }
        return newp
    }
    
    func getAllConnectPositions() -> [CirclePosition] {
        var arr = [CirclePosition]()
        
        var p = getLeft()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }
    
        p = getRight()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }

        p = getLeftDown()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }
        
        p = getLeftUp()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }
        
        p = getRightDown()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }
        
        p = getRightUp()
        if let tmp = p {
            if isWall[tmp.row][tmp.col] == 0 {
                arr.append(tmp)
            }
        }
        
        return arr
    }
    
    func getNextPosition() -> (Int,Int) {
        clear()
        isVisited[row][col] = 1;
        
        var queue = [CirclePosition]()
        var tmp: CirclePosition!
        var flag = false
        
        queue.append(allCirclePositions[row][col])
        
        while queue.isEmpty == false {
            tmp = queue.first
            queue.removeAtIndex(0)
            if isBoundary(tmp) {
                println("boundary: \(tmp.row), \(tmp.col)")
                flag = true
                break
            }
            else {
                var arr: [CirclePosition] = tmp.getAllConnectPositions()
                //println("==== \(row), \(col): ")
                for var i = 0; i < arr.count; i++ {
                    var pos = arr[i]
                    if isVisited[pos.row][pos.col] == 0 {
                        isVisited[pos.row][pos.col] = 1
                        path[pos.row][pos.col].0 = tmp.row
                        path[pos.row][pos.col].1 = tmp.col
                        queue.append(pos)
                        
                    }
                }
            }
        }
        
        if flag {
            var x:Int = tmp.row
            var y:Int = tmp.col
            while path[x][y].0 != row || path[x][y].1 != col {
                var tx = path[x][y].0
                y = path[x][y].1
                x = tx
            }
            return (x, y)
        }
        
        return (-1,-1)
    }
    
    func isBoundary(test: CirclePosition!) -> Bool {
        if test.col == 0 || test.col == 8 || test.row == 0 || test.row == 8 {
            return true
        }
        return false
    }
    
    func clear() {
        for var i = 0; i < 9; i++ {
            for var j = 0; j < 9; j++ {
                isVisited[i][j] = 0
                path[i][j] = (-1,-1)
            }
        }
    }
}