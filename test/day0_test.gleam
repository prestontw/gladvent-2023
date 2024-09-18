import data/day0 as data
import day0
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day0.part1(data.input())
  |> should.equal(1)
}

pub fn part1_sample_test() {
  day0.part1("")
  |> should.equal(1)
}

pub fn part2_test() {
  day0.part2(data.input())
  |> should.equal(1)
}

pub fn part2_sample_test() {
  day0.part2("")
  |> should.equal(1)
}
