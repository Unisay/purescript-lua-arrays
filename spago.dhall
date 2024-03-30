{ name = "purescript-lua-arrays"
, dependencies =
  [ "bifunctors"
  , "control"
  , "foldable-traversable"
  , "functions"
  , "maybe"
  , "nonempty"
  , "partial"
  , "prelude"
  , "safe-coerce"
  , "st"
  , "tailrec"
  , "tuples"
  , "unfoldable"
  , "unsafe-coerce"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend =
    ''
    pslua \
    --foreign-path . \
    --ps-output output \
    --lua-output-file dist/Data_Array.lua \
    --entry Data.Array
    ''
}
