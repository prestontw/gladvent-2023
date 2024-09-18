import data/day1 as data
import day1
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day1.part1(data.input())
  |> should.equal(56_397)
}

pub fn part1_sample_test() {
  day1.part1(
    "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet",
  )
  |> should.equal(142)
}

pub fn part2_test() {
  day1.part2(data.input())
  |> should.equal(55_701)
}

pub fn part2_sample_test() {
  day1.part2(
    "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen",
  )
  |> should.equal(281)
}

pub fn part2_line_test() {
  let input = "nqninenmvnpsz874"
  day1.part2(input) |> should.equal(94)
}
