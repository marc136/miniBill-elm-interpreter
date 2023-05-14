module EndToEnd exposing (suite)

import Eval
import Expect
import Test exposing (Test, describe, test)
import Value exposing (Value(..))


suite : Test
suite =
    describe "Some end to end tests"
        [ helloWorldTest
        , sumTest
        , fibonacciTest
        , recordTest
        , customTypeTest
        , standardLibraryTest
        ]


helloWorldTest : Test
helloWorldTest =
    evalTest "Hello world"
        "\"Hello, World\""
        (String "Hello, World")


sumTest : Test
sumTest =
    evalTest "2 + 3"
        "2 + 3"
        (Int 5)


fibonacciTest : Test
fibonacciTest =
    evalTest "Fibonacci"
        "let fib n = if n <= 2 then 1 else fib (n - 1) + fib (n - 2) in fib 7"
        (Int 13)


recordTest : Test
recordTest =
    evalTest "Record"
        "{ a = 13, b = 'c'}.b"
        (Char 'c')


customTypeTest : Test
customTypeTest =
    evalTest "Custom type"
        """let
    foo = Just []
in
case foo of
    Nothing -> -1
    Just [ x ] -> 1
"""
        (Int 0)


standardLibraryTest : Test
standardLibraryTest =
    evalTest "Stdlib"
        "List.isEmpty [()]"
        (Bool False)


evalTest : String -> String -> Value -> Test
evalTest name expression result =
    test name <|
        \_ ->
            Eval.eval expression
                |> Expect.equal (Ok result)
