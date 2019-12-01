//
//  main.swift
//  TestStep3
//
//  Created by TTOzzi on 2019/12/01.
//  Copyright © 2019 TTOzzi. All rights reserved.
//

import Foundation

struct Hitter {
    let number: Int
    let name: String
    var h: Double
}

struct Team {
    let teamName: String
    var players: [Hitter]
    let score = Score()
}

class Score {
    var order = 1 {
        didSet {
            if self.order == 3 {    // 9 명 기준으로 변경 필요
                order = 1
            }
        }
    }
    var strike = 0 {
        didSet {
            if strike != 0 {
                print("스트라이크!")
            }
        }
    }
    var ball = 0 {
        didSet {
            if ball != 0 {
                print("볼!")
            }
        }
    }
    var out = 0 {
        didSet {
            if out < 3, out != 0 {
                print("아웃! 다음 타자가 타석에 입석했습니다.")
            } else if out != 0 {
                print("아웃!")
            }
            self.order += 1
            self.scoreInit()
        }
    }
    var hit = 0 {
        didSet {
            if self.ball == 4 {
                print("볼넷! 다음 타자가 타석에 입장했습니다.")
                self.order += 1
            } else if hit != 0{
                print("안타! 다음 타자가 타석에 입장했습니다.")
                self.order += 1
            }
            if hit >= 4 {
                self.s += 1
            }
            self.scoreInit()
        }
    }
    var s = 0
    
    func scoreInit() {
        self.strike = 0
        self.ball = 0
    }
    
    func nextInning() {
        self.out = 0
        self.hit = 0
    }
    
    func printScore() {
        print("\(self.strike)S \(self.ball)B \(self.out)O\n")
    }
}

func main() {
    var teams = [Team]()
    while true {
        print("신나는 야구시합\n1. 데이터 입력\n2. 데이터 출력\n3. 시합 시작")
        print("메뉴 선택 (1 - 3)")
        let input = readLine()!
        switch input {
        case "1":
            if teams.count == 0 {
                teams = inputData()
            } else {
                print("이미 데이터를 입력하셨습니다.")
            }
        case "2":
            if teams.count == 0 {
                print("출력 할 데이터가 없습니다.")
            } else {
                printData(teams)
            }
        case "3":
            if teams.count == 0 {
                print("데이터를 먼저 입력해주세요")
            } else {
                game(teamA: teams[0], teamB: teams[1])
                return
            }
        default:
            print("잘못된 값을 입력하셨습니다.")
        }
    }
}

func inputData() -> [Team] {
    var ret = [Team]()
    for i in 1...2 {
        print("\(i)팀의 이름을 입력하세요>")
        let teamName = readLine()!
        var players = [Hitter]()
        for j in 1...2 {    // 9명으로 변경 필요
            print("\(j)번 타자 정보 입력>")
            let input = readLine()!.components(separatedBy: ", ")
            players.append(Hitter(number: j, name: input[0], h: Double(input[1])!))
        }
        ret.append(Team(teamName: teamName, players: players))
    }
    print("팀 데이터 입력이 완료되었습니다\n")
    return ret
}

func printData(_ team: [Team]) {
    team.forEach {
        print("\($0.teamName) 팀 정보")
        $0.players.forEach {
            print("\($0.number)번 \($0.name), \($0.h)")
        }
        print("\n")
    }
}

func game(teamA: Team, teamB: Team) {
    print("\(teamA.teamName) VS \(teamB.teamName)의 시합을 시작합니다.\n")
    for i in 1...6 {
        print("\(i)회 초 \(teamA.teamName) 공격\n")
        inning(team: teamA)
        scoreBoard(teamA: teamA, teamB: teamB)
        print("\(i)회 말 \(teamB.teamName) 공격\n")
        inning(team: teamB)
        scoreBoard(teamA: teamA, teamB: teamB)
    }
    print("""
        경기 종료
        \(teamA.teamName) VS \(teamB.teamName)
        \(teamA.score.s) : \(teamB.score.s)
        Thank you!
        """)
}

func scoreBoard(teamA: Team, teamB: Team) {
    print("""
    
    \(teamA.teamName) VS \(teamB.teamName)
    \(teamA.score.s) : \(teamB.score.s)
    
    """)
}

func inning(team: Team) {
    print("\(team.score.order)번 \(team.players[team.score.order - 1].name)")
    while team.score.out < 3 {
        throwBall(battingAverage(who: team.players[team.score.order - 1]), team)
        team.score.printScore()
    }
    team.score.nextInning()
}

func battingAverage(who p: Hitter) -> Int {
    let randNum = Int.random(in: 0...999)
    let h = Int(p.h * 1000)
    switch randNum {
    case 0..<h: // 안타
        return 3
    case h..<(h + 100): // 아웃
        return 4
    case (h + 100)..<((h + 100) + (1000 - h) / 2 - 50): // 스트라이크
        return 1
    default: // 볼
        return 2
    }
}

func throwBall(_ n: Int, _ t: Team) {
    switch n {
    case 1:
        t.score.strike += 1
        if t.score.strike == 3 {
            t.score.out += 1
            if t.score.out < 3 {
                print("\(t.score.order)번 \(t.players[t.score.order - 1].name)")
            }
        }
    case 2:
        t.score.ball += 1
        if t.score.ball == 4 {
            t.score.hit += 1
            print("\(t.score.order)번 \(t.players[t.score.order - 1].name)")
        }
    case 3:
        t.score.hit += 1
        print("\(t.score.order)번 \(t.players[t.score.order - 1].name)")
    case 4:
        t.score.out += 1
        if t.score.out < 3 {
            print("\(t.score.order)번 \(t.players[t.score.order - 1].name)")
        }
    default:
        break
    }
}

main()
