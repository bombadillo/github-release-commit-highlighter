reqListener = (response) =>
  doc = parseDocument response.currentTarget.response
  releaseCommit = getReleaseCommit doc
  commitToHighlight = getCommitToHighlight releaseCommit
  commitRow = getCommitRow commitToHighlight
  highlightCommit commitRow

parseDocument = (htmlString) =>
  parsedDocument = document.createElement 'div'
  parsedDocument.innerHTML = htmlString
  return parsedDocument  

getReleaseCommit = (htmlDoc) =>
  latestRelease = htmlDoc.querySelector '.Label--latest'
  commit = latestRelease.nextElementSibling.querySelector 'code'
  return commit.innerHTML

getCommitToHighlight = (commitId) => 
  clipboards = document.getElementsByTagName 'clipboard-copy'  
  for clipboard in clipboards
    value = clipboard.getAttribute('value')
    if value.match '^' + commitId
      return clipboard

getCommitRow = (commitToHighlight) => 
  return commitToHighlight.closest '.commit'

highlightCommit = (commitRow) => 
  commitLinksEl = commitRow.querySelector '.commit-links-cell'
  latestReleaseLabel = document.createElement 'span'
  latestReleaseLabel.innerHTML = 'Latest Release 🦄'
  latestReleaseLabel.style = """
    padding: 6px 12px;
    border: 1px solid #ededed;
    top: 14px;
    position: absolute;
    right: -131px;
    color: green
    """
  commitLinksEl.append latestReleaseLabel

oReq = new XMLHttpRequest()
oReq.addEventListener "load", reqListener
oReq.open "GET", "https://github.com/arnoldclark/data-services-sales-customer-checker-ui/releases"
oReq.send();