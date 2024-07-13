return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { trig = "hi" },
    { t("Hello, world!") }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  require("luasnip").snippet(
    { trig = "foo" },
    { t("Another snippet.") }
  ),
s({trig=";a", snippetType="autosnippet"},
  {
    t("\\alpha"),
  }
),
s({trig=";b", snippetType="autosnippet"},
  {
    t("\\beta"),
  }
),
s({trig=";g", snippetType="autosnippet"},
  {
    t("\\gamma"),
  }
),
s({trig=";p", snippetType="autosnippet"},
  {
    t("\\pi"),
  }
),
s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
  {
    t("\\texttt{"), -- remember: backslashes need to be escaped
    i(1),
    t("}"),
  }
),
-- Yes, these jumbles of text nodes and insert nodes get messy fast, and yes,
-- there is a much better, human-readable solution: ls.fmt, described shortly.
s({trig="ff", dscr="Expands 'ff' into '\frac{}{}'"},
  {
    t("\\frac{"),
    i(1),  -- insert node 1
    t("}{"),
    i(2),  -- insert node 2
    t("}")
  }
),
s({trig="eq", dscr="A LaTeX equation environment"},
  fmt( -- The snippet code actually looks like the equation environment it produces.
    [[
      \begin{equation}
          <>
      \end{equation}
    ]],
    -- The insert node is placed in the <> angle brackets
    { i(1) },
    -- This is where I specify that angle brackets are used as node positions.
    { delimiters = "<>" }
  )
),
s({trig="env", snippetType="autosnippet"},
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1),  -- this node repeats insert node i(1)
    }
  )
),
s({trig="bf"},
fmta([[\textbf{<>}]],i(1))		
),
s({trig='il'},
{
t('\\item'),
		}),

s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
  fmta(
    "<>$<>$",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual),
    }
  )
),
s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta(
    "<>_{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("0")
    }
  )
),
}
  
