EXPANDTAB_IGNORED_DIRS = [
  'ccan/',
  'ext/json/',
  'ext/psych/',
]

files = []
IO.popen(['git', 'status', '--short'], &:readlines).each do |entry|
  if md = entry.match(/\A(A|M)  (?<file>.+)\n\z/)
    file = md[:file]
    if (file.end_with?('.c') || file.end_with?('.h') || file == 'insns.def') && EXPANDTAB_IGNORED_DIRS.all? { |d| !file.start_with?(d) }
      files << file
    end
  end
end

files.each do |file|
  expandtab = false
  src = File.read(file)

  line_i = 0
  blames = IO.popen(['git', 'blame', file], &:readlines)
  src.gsub!(/^.*$/) do |line|
    blame = blames[line_i]
    line_i += 1
    if blame.match(/\A[^ ]+ #{file} +\(Not Committed Yet /) && line.start_with?("\t") # last-committed line with hard tabs
      expandtab = true
      line.sub(/\A\t+/) { |tabs| ' ' * (8 * tabs.length) }
    else
      line
    end
  end

  if expandtab
    File.write(file, src)
    IO.popen(['git', 'add', file], &:read)
  end
end
