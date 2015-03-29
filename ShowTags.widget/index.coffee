# Default: tagsdummy.txt in the Widgets directory
# Replace the command with 'cat /absolute/path/to/file' that should be displayed
#
# This version expects 2 tags on 1 line, separated by a tab (\t) character

command: "cat \"$(pwd)\"/ShowTags.widget/tagsdummy.txt"
command: "cat ./ShowTags.widget/tagsdummy.txt"

refreshFrequency: 60 * 60 * 24

style: """
  top: 450px
  left 150px

  top 100px
  left 1300px

  color: #fff
  font-family: Helvetica Neue
  font-size: 13px
 
  #tagblock
    background: rgba(0,0,0,0.1)
    padding 10px 10px 15px 10px
    border-radius 5px

  table
    border-collapse: collapse
    table-layout: fixed

  td
    text-align: left
    padding: 2px 2px

  thead th
      font-family Helvetica Neue
      font-size: 24px
      font-weight: 200
      text-align: left
      text-shadow: 0 0 1px rgba(#000, 0.5)

  thead
      padding-bottom: 10px
      border-bottom 1px solid #fff

  tbody td
    font-size: 13px

"""

render: -> """
  <div id="tagblock">
    <table>
      <thead>
        <tr><th colspan="2">Tags</th></tr>
      </thead>
      <tbody id="tags">
      </tbody>
    </table>
  </div>
"""

update: (output, domEl) ->
  tagslist = $(domEl).find("#tags")
  tagslist.empty()

  invalidFile = output.indexOf('No such file or directory')
  if invalidFile > 0 
      tagslist.append '<tr><td class="tag">invalid filename</td><td class="tag"></td></tr>'
  else 
    rows = output.split("\n")

    for row in rows
      tags = row.split("\t")
      if tags[1] == undefined
        tags.push('')
      tagslist.append '<tr><td class="tag">' + tags[0] + '</td><td class="tag">' + tags[1] + '</td></tr>'
