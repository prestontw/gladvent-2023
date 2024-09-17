import gleam/list
import gleam/string

pub fn lines(s: String) {
  s |> string.split("\n")
}

pub fn sum(ln) {
  ln |> list.fold(0, fn(a, b) { a + b })
}
