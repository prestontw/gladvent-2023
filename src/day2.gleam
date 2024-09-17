import common
import data/day2
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regex
import gleam/result
import gleam/string

pub fn main() {
  io.println("part1 answer:" <> { day2.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { day2.input() |> part2 |> int.to_string })
}

type Pull {
  Pull(green: Int, red: Int, blue: Int)
}

type Game {
  Game(id: Int, rounds: List(Pull))
}

pub fn part1(s: String) {
  let reg = line_regex()
  s
  |> common.lines
  |> list.map(fn(line) {
    let matches = regex.scan(reg, line)
    let assert [match] = matches
    let assert [id, body] = match.submatches
    let id = id |> option.unwrap("0") |> int.parse |> result.unwrap(0)
    let rounds =
      body
      |> option.unwrap("")
      |> string.split(";")
      |> list.map(fn(pull) {
        pull
        |> string.split(",")
        |> list.map(fn(pull) {
          let assert [count, color] = pull |> string.trim |> string.split(" ")
          #(color, count |> int.parse |> result.unwrap(0))
        })
        |> list.fold(Pull(red: 0, green: 0, blue: 0), fn(pull, count) {
          case count.0 {
            "red" -> Pull(..pull, red: count.1)
            "green" -> Pull(..pull, green: count.1)
            "blue" -> Pull(..pull, blue: count.1)
            _ -> pull
          }
        })
      })
    Game(id, rounds)
  })
  |> list.filter_map(fn(game) {
    let okay =
      game.rounds
      |> list.all(fn(pull) {
        pull.red <= 12 && pull.green <= 13 && pull.blue <= 14
      })
    case okay {
      True -> Ok(game.id)
      False -> Error(Nil)
    }
  })
  |> common.sum
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}

fn line_regex() {
  let assert Ok(reg) = regex.from_string("Game (\\d+): (.+)")
  reg
}
