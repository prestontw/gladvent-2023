import data/day3 as data
import day3
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day3.part1(data.input())
  |> should.equal(1)
}

pub fn part1_sample_test() {
  day3.part1(
    "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..",
  )
  |> should.equal(4361)
}

pub fn part2_test() {
  day3.part2(data.input())
  |> should.equal(1)
}

pub fn part2_sample_test() {
  day3.part2("")
  |> should.equal(1)
}
