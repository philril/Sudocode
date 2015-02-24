$(document).ready(function() {
  var boards

  $.ajax({
    type: "GET",
    url: "/board",
    async: false,
  }).done(function(response){
    boards = {
      board: response['board_string'],
      solvedBoard: response['solved_board']
    }
  })

  var boardArr = (function(){
    arr = boards['board'].split("")
    for (var i=0;i<arr.length;i++) {
      if (arr[i] === "-") {
        arr[i] = ""
      }
    }
    return arr
  })()
  var arr = $('form').serializeArray();

  for (var i=0;i<arr.length;i++) {
      $($('input')[i]).val(boardArr[i])
    }

  $('input').keyup(function(){
    var string = stringify()
    var solved = boards['solvedBoard']
    if (string == solved) {
    alert("You Win!")
    } else {console.log("no")}
  })

  var stringify = function(){
    var arr = $('form').serializeArray();
    var strArr = []
    for (var i=0;i<arr.length;i++) {
      strArr.push(arr[i]['value'])
    }
    return strArr.join("")
  }

});
