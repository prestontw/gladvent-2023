import data/day1 as data
import day1
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day1.part1(data.input())
  |> should.equal(56_397)
}

pub fn part1_sample() {
  day1.part1(
    "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet",
  )
  |> should.equal(142)
}
