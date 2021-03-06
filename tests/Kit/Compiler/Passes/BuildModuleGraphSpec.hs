module Kit.Compiler.Passes.BuildModuleGraphSpec where

import Test.Hspec
import Test.QuickCheck
import Kit.Ast
import Kit.Compiler
import Kit.Compiler.Passes
import Kit.Error
import Kit.HashTable
import Kit.Parser
import Kit.Str

spec :: Spec
spec = do
  describe "tryCompile" $ do
    it "finds imports" $ do
      let exprs =
            case
                parseString "import a; import b.c; function main() {} import d;"
              of
                ParseResult e -> e
                Err         _ -> []
      m <- newMod [] ""
      ctx <- newCompileContext
      imports <- findImports ctx [] exprs
      map fst imports `shouldBe` [["a"], ["b", "c"], ["d"]]
