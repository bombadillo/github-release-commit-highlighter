chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) ->
  if changeInfo.status == 'complete'
    if tab.url.match '(?=.*github)(?=.*commits)'
      chrome.tabs.executeScript(null, {file: "highlightLatestRelease.js"})
