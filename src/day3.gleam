import common
import data/day3
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string

pub fn main() {
  io.println("part1 answer:" <> { day3.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { day3.input() |> part2 |> int.to_string })
}

type Treasure {
  Treasure(value: Int, position: #(Int, Int))
}

type Item {
  Symbol(String)
  Number(Int)
}

pub fn part1(s: String) {
  s
  |> common.lines
  |> list.index_fold(#(dict.new(), dict.new()), fn(acc, line, row_index) {
    let #(startings_map, legend) = acc
    let chars = line |> string.to_graphemes

    let #(pending_treasure, startings_map, legend) = {
      use acc, char, col_index <- list.index_fold(chars, #(
        None,
        startings_map,
        legend,
      ))
      let #(current_start, startings_map, legend) = acc
      case char |> int.parse, current_start {
        Ok(num), Some(treasure) -> {
          let treasure = Treasure(..treasure, value: treasure.value * 10 + num)
          let startings_map =
            startings_map
            |> dict.insert(#(row_index, col_index), treasure.position)
          #(Some(treasure), startings_map, legend)
        }
        Ok(num), None -> {
          let treasure = Treasure(value: num, position: #(row_index, col_index))
          let startings_map =
            startings_map
            |> dict.insert(#(row_index, col_index), #(row_index, col_index))
          #(Some(treasure), startings_map, legend)
        }
        Error(_), Some(treasure) -> {
          let legend =
            legend |> dict.insert(treasure.position, Number(treasure.value))
          // if char is non-period, insert it as a value
          case char != "." {
            True -> {
              #(
                None,
                startings_map
                  |> dict.insert(#(row_index, col_index), #(
                    row_index,
                    col_index,
                  )),
                legend |> dict.insert(#(row_index, col_index), Symbol(char)),
              )
            }
            False -> #(None, startings_map, legend)
          }
        }
        Error(_), None -> {
          case char != "." {
            True -> {
              #(
                None,
                startings_map
                  |> dict.insert(#(row_index, col_index), #(
                    row_index,
                    col_index,
                  )),
                legend |> dict.insert(#(row_index, col_index), Symbol(char)),
              )
            }
            False -> #(None, startings_map, legend)
          }
        }
      }
    }

    pending_treasure
    |> common.map_or_unwrap(#(startings_map, legend), fn(treasure) {
      #(
        startings_map
          |> dict.insert(
            #(row_index, { line |> string.length } - 1),
            treasure.position,
          ),
        legend |> dict.insert(treasure.position, Number(treasure.value)),
      )
    })
  })
  |> io.debug
  3
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}
