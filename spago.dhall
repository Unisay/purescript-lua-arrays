{ name = "purescript-lua-arrays"
, dependencies =
  [ "foldable-traversable"
  , "functions"
  , "nonempty"
  , "partial"
  , "prelude"
  , "st"
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
