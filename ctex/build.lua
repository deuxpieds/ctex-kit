#!/usr/bin/env texlua

module = "ctex"

packtdszip = true

maindir         = "."
supportdir      = "../tool"
sourcefiles     = {"*.dtx", "*.ins", "ctexpunct.spa"}
unpacksuppfiles = {"ctxdocstrip.tex"}
installfiles    = {"*.sty", "*.cls", "*.clo", "*.def", "*.cfg", "*.fd", "*.tex", "*.dict"}
unpackexe       = "xetex"
unpackopts      = "-file-line-error -halt-on-error -interaction=nonstopmode"

typesetfiles    = {"ctex.tex", "ctex-code.tex"}
typesetexe      = "xelatex"
typesetopts     = "-file-line-error -halt-on-error -interaction=nonstopmode"

gbkfiles        = {"ctex-name-gbk.cfg", "*-ChineseGBK.dict"}


testfiledir     = "./test/testfiles"
testsuppdir     = "./test/support"
testdir         = "./build/check"
checkruns       = 2
stdengine       = "xetex"
checkengines    = {"pdftex", "xetex", "luatex", "uptex"}
specialformats  = {}
specialformats.latex = {
  pdftex = {binary = "latex", options = "-output-format=dvi"},
  uptex  = {binary = "euptex"}
}


tagfiles = {"*.dtx", "CHANGELOG.md"}

function update_tag(file, content, tagname, isodate)
  local gittag = "ctex-" .. tagname
  local date = string.gsub(isodate, "%-", "/")
  local url = "https://github.com/CTeX-org/ctex-kit"
  if string.match(file, "%.dtx$") then
    content = string.gsub(content, "%d%d%d%d/%d%d/%d%d v[0-9.]+",
      date .. " " .. tagname)
    content = string.gsub(content, "%d%d%d%d%-%d%d%-%d%d}{[0-9.]+",
      isodate .. "}{" .. string.gsub(tagname, "^v", ""))
  elseif string.match(file, "CHANGELOG.md") then
    local previous = string.match(content, "/compare/(.*)%.%.%.HEAD")
    content = string.gsub(content,
      "## %[Unreleased%]",
      "## [Unreleased]\n\n## [" .. gittag .."] - " .. isodate)
    content = string.gsub(content,
      "/compare/.*%.%.%.HEAD",
      "/compare/" .. gittag .. "...HEAD\n[" .. gittag .. "]: " .. url .. "/compare/"
        .. previous .. "..." .. gittag)
  end
  return content
end

tdslocations = {
  "tex/generic/ctex/*.tex",
  "tex/latex/ctex/config/*.cfg",
  "tex/latex/ctex/fd/*.fd",
  "tex/latex/ctex/engine/ctex-engine-*.def",
  "tex/latex/ctex/fontset/ctex-fontset-*.def",
  "tex/latex/ctex/scheme/ctex-scheme-*.def",
  "tex/latex/ctex/dictionary/*.dict"
}
