//
//  main.swift
//  TestStep2
//
//  Created by TTOzzi on 2019/11/29.
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
    var strike = 0
    var ball = 0
    var out = 0 {
        didSet {
            if self.out < 3 {
                print("아웃! 다음 타자가 타석에 입석했습니다.")
                self.order += 1
            } else {
                print("아웃!")
            }
            self.scoreInit()
        }
    }
    var hit = 0 {
        didSet {
            if self.ball == 4 {
                print("볼넷! 다음 타자가 타석에 입장했습니다.")
                self.order += 1
            } else {
                print("안타! 다음 타자가 타석에 입장했습니다.")
                self.order += 1
            }
            self.scoreInit()
        }
    }
    
    func scoreInit() {
        self.strike = 0
        self.ball = 0
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
        if input == "1", teams.count == 0 {
            teams = inputData()
        } else if input == "1" {
            print("이미 데이터를 입력하셨습니다.\n")
        } else if input == "2", teams.count == 0 {
            print("출력 할 데이터가 없습니다.\n")
        } else if input == "2" {
            printData(teams)
        } else if input == "3" {
            game(teamA: teams[0], teamB: teams[1])
            break
        } else {
            print("잘못된 값을 입력하셨습니다.\n")
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
        print("\(i)회 말 \(teamB.teamName) 공격\n")
        inning(team: teamB)
    }
    print("경기 종료")
}

func inning(team: Team) {
    while team.score.out < 3 {
        print("\(team.score.order)번 \(team.players[team.score.order - 1].name)") // 선수 처음 바뀔때만 출력되도록 수정 필요
        throwBall(battingAverage(who: team.players[team.score.order - 1]), team.score)
        team.score.printScore()
    }
    team.score.out = 0 // 프로퍼티 감시자가 작동함 수정 필요
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

func throwBall(_ n: Int, _ s: Score) {
    switch n {
    case 1:
        s.strike += 1
        print("스트라이크!")
        if s.strike == 3 {
            s.out += 1
        }
    case 2:
        s.ball += 1
        print("볼!")
        if s.ball == 4 {
            s.hit += 1
        }
    case 3:
        s.hit += 1
    case 4:
        s.out += 1
    default:
        break
    }
}

main()
