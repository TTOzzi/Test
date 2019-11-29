class Score {
    var strike = 0
    var ball = 0
    var out = 0
    var hit = 0
}

func game() {
    let score = Score()
    while score.out < 3 {
        throwBall(Int.random(in: 1...4), score)
    }
}

func throwBall(_ n: Int, _ s: Score) {
    switch n {
    case 1:
        s.strike += 1
        print("스트라이크!")
        if s.strike == 3 {
            s.strike = 0
            s.ball = 0
            s.out += 1
            print("아웃!")
        }
    case 2:
        s.ball += 1
        print("볼!")
        if s.ball == 4 {
            s.strike = 0
            s.ball = 0
            print("볼넷!")
        }
    case 3:
        s.hit += 1
        s.strike = 0
        s.ball = 0
        print("안타!")
    case 4:
        s.out += 1
        s.strike = 0
        s.ball = 0
        if s.out < 3 {
            print("아웃! 다음 타자가 타석에 입석했습니다.")
        } else {
            print("아웃!")
        }
    default:
        break
    }
}

game()
