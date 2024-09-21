import gleam/dict
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

pub fn lines(s: String) {
  s |> string.split("\n")
}

pub fn sum(ln) {
  ln |> list.fold(0, fn(a, b) { a + b })
}

pub type Grid(item) {
  Grid(number_rows: Int, max_columns: Int, data: dict.Dict(#(Int, Int), item))
}

pub fn map_or_unwrap(opt: Option(a), init: b, f: fn(a) -> b) -> b {
  opt |> option.map(f) |> option.unwrap(init)
}

pub fn then_some(b: Bool, v) {
  case b {
    True -> Some(v)
    False -> None
  }
}

pub fn then_ok(b: Bool, v, e) {
  case b {
    True -> Ok(v)
    False -> Error(e)
  }
}

pub fn grid(s: String, string_to_item: fn(String) -> Result(item, Nil)) {
  let grid_lines = s |> lines
  let number_rows = grid_lines |> list.length
  let #(max_columns, data) =
    grid_lines
    |> list.index_fold(#(0, dict.new()), fn(acc, row, row_index) {
      let #(columns, data) = acc
      let max_columns = int.max(columns, row |> string.length)

      let data =
        row
        |> string.to_graphemes
        |> list.index_fold(data, fn(data, char, char_index) {
          case string_to_item(char) {
            Ok(item) -> data |> dict.insert(#(row_index, char_index), item)
            Error(_) -> data
          }
        })

      #(max_columns, data)
    })

  Grid(number_rows, max_columns, data)
}
