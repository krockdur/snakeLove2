



function write_score(score)
  local file = io.open(FILE_SCORE, "a")
  file:write(score)
  file:close()
end
