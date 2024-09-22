import common
import data/day3
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/set
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

fn is_symbol(item: Item) {
  case item {
    Symbol(_) -> True
    Number(_) -> False
  }
}

fn adjacent_positions(pos) {
  let #(row, col) = pos
  [
    #(row - 1, col - 1),
    #(row - 1, col),
    #(row - 1, col + 1),
    #(row, col - 1),
    #(row, col + 1),
    #(row + 1, col - 1),
    #(row + 1, col),
    #(row + 1, col + 1),
  ]
}

pub fn part1(s: String) {
  let #(map, legend) = s |> map_and_legend
  // map over all numbers in legend,
  map
  |> dict.to_list
  |> list.filter_map(fn(item) {
    let #(pos, start) = item
    // if pos is adjacent to symbol, return start
    let adjacent_to_symbol =
      pos
      |> adjacent_positions
      |> list.any(fn(pos) {
        let item =
          map
          |> dict.get(pos)
          |> option.from_result
          |> option.then(fn(starting_pos) {
            legend |> dict.get(starting_pos) |> option.from_result
          })
        case item {
          Some(Symbol(_)) -> True
          _ -> False
        }
      })
    case adjacent_to_symbol {
      True -> Ok(start)
      _ -> Error(Nil)
    }
  })
  |> set.from_list
  |> set.to_list
  |> list.filter_map(fn(starting_pos) {
    legend
    |> dict.get(starting_pos)
    |> result.then(fn(item) {
      case item {
        Number(x) -> Ok(x)
        _ -> Error(Nil)
      }
    })
  })
  |> common.sum
}

pub fn part2(s: String) {
  let #(map, legend) = s |> map_and_legend
  legend
  |> dict.to_list
  |> list.filter_map(fn(tup) {
    let #(pos, treasure) = tup
    case treasure {
      Symbol("*") -> Ok(pos)
      _ -> Error(Nil)
    }
  })
  |> list.filter_map(fn(pos) {
    let adj_starts =
      pos
      |> adjacent_positions
      |> list.filter_map(fn(pos) { map |> dict.get(pos) })
      |> set.from_list
    let adj_items =
      adj_starts
      |> set.map(fn(start_pos) {
        legend |> dict.get(start_pos) |> result.unwrap(Symbol("?"))
      })
      |> set.to_list
    case adj_items {
      [Number(x), Number(y)] -> Ok(x * y)
      _ -> Error(Nil)
    }
  })
  |> common.sum
}

fn map_and_legend(s: String) {
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
}
