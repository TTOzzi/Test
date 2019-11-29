class Score {
    var strike = 0
    var ball = 0
    var out = 0
    var hit = 0
    
    func nextHitter() {
        self.strike = 0
        self.ball = 0
    }
    
    func printScore() {
        print("\(self.strike)S \(self.ball)B \(self.out)O\n")
    }
}

func game() {
    let score = Score()
    
    print("신나는 야구 게임!")
    print("첫 번째 타자가 타석에 입장했습니다.\n")
    while score.out < 3 {
        throwBall(Int.random(in: 1...4), score)
        score.printScore()
    }
    print("최종 안타수: \(score.hit)")
    print("GAME OVER")
}

func throwBall(_ n: Int, _ s: Score) {
    switch n {
    case 1:
        s.strike += 1
        print("스트라이크!")
        if s.strike == 3 {
            s.out += 1
            if s.out < 3 {
                s.nextHitter()
                print("아웃! 다음 타자가 타석에 입석했습니다.")
            } else {
                print("아웃!")
            }
        }
    case 2:
        s.ball += 1
        print("볼!")
        if s.ball == 4 {
            s.nextHitter()
            s.hit += 1
            print("볼넷!")
        }
    case 3:
        s.hit += 1
        s.nextHitter()
        print("안타!")
    case 4:
        s.out += 1
        if s.out < 3 {
            s.nextHitter()
            print("아웃! 다음 타자가 타석에 입석했습니다.")
        } else {
            print("아웃!")
        }
    default:
        break
    }
}

game()
