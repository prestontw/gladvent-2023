import common
import data/day0
import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  io.println("part1 answer:" <> { day0.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { day0.input() |> part2 |> int.to_string })
}

pub fn part1(s: String) {
  s
  |> common.lines
  |> list.length
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}
