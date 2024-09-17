import common
import data/day1
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string

pub fn main() {
  io.println("part1 answer:" <> { day1.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { day1.input() |> part2 |> int.to_string })
}

pub fn part1(s: String) {
  s
  |> common.lines
  |> list.map(calibration_values)
  |> common.sum
}

fn calibration_values(line) {
  let chars = line |> string.to_graphemes
  let assert #(Some(first), Some(last)) = {
    use acc, char <- list.fold(chars, #(None, None))
    int.parse(char)
    |> result.map(fn(num) { #(option.or(acc.0, Some(num)), Some(num)) })
    |> result.unwrap(acc)
  }
  first * 10 + last
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.map(fn(line) {
    line
    |> string.replace(each: "one", with: "onee")
    |> string.replace(each: "two", with: "twoo")
    |> string.replace(each: "three", with: "threee")
    |> string.replace(each: "five", with: "fivee")
    |> string.replace(each: "seven", with: "sevenn")
    |> string.replace(each: "eight", with: "eightt")
    |> string.replace(each: "nine", with: "ninee")
    |> string.replace(each: "one", with: "1")
    |> string.replace(each: "two", with: "2")
    |> string.replace(each: "three", with: "3")
    |> string.replace(each: "four", with: "4")
    |> string.replace(each: "five", with: "5")
    |> string.replace(each: "six", with: "6")
    |> string.replace(each: "seven", with: "7")
    |> string.replace(each: "eight", with: "8")
    |> string.replace(each: "nine", with: "9")
    |> calibration_values
  })
  |> common.sum
}
