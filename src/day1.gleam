import data/day1
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string

pub fn main() {
  io.println("day1 answer:" <> { day1.input() |> part1 |> int.to_string })
}

pub fn part1(s: String) {
  s
  |> string.split("\n")
  |> list.map(fn(line) {
    let chars = line |> string.to_graphemes
    let assert #(Some(first), Some(last)) = {
      use acc, char <- list.fold(chars, #(None, None))
      int.parse(char)
      |> result.map(fn(num) { #(option.or(acc.0, Some(num)), Some(num)) })
      |> result.unwrap(acc)
    }
    first * 10 + last
  })
  |> list.reduce(fn(a, b) { a + b })
  |> result.unwrap(0)
}
