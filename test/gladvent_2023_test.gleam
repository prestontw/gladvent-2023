import common
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn memoize_fib_test() {
  // let fib =
  //   common.memoize(fn(n, fast_fib, cache) {
  //     case n {
  //       0 | 1 -> #(1, cache)
  //       n -> {
  //         let #(result, cache) = fast_fib(n - 1, cache)
  //         let #(result2, cache) = fast_fib(n - 2, cache)
  //         #(result + result2, cache)
  //       }
  //     }
  //   })

  common.fib(5) |> should.equal(8)
}
