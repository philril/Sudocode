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

  //set up board (refactor into its own function?)
  var boardArr = (function(){
    var arr = boards['board'].split("")
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
  //End set up board

  $('input').keyup(function(){
    solve();
    displayPercent();
    percentBar();
  })

  $('#solve').on('click', function(){
    var sBoard = boards['solvedBoard'].split("")
    for (var i=0;i<arr.length;i++) {
      $($('input')[i]).val(sBoard[i])
    }
    solve();
    displayPercent();
    percentBar();
  })

  function percentBar(){
    var percent = parseInt(percentDone());
    console.log(percent)
    var i = 0
    while (i<=percent) {
      $('.percentCell#'+i).css("background-color","red");
      i++;
    }
  }

  function percentDone(){
    var arr = $('form').serializeArray();
    var counter = 0
    for (var i=0;i<arr.length;i++) {
      if (arr[i]['value'] !== "") {
        counter +=1
      }
    }
    return Math.floor(((counter/81)*100))
  }

  function displayPercent(){
    var percent = percentDone() + "% complete"
    $('#percent').html(percent)
  }

  function solve(){
    var string = stringify()
    var solved = boards['solvedBoard']
    if (string == solved) {
    alert("Solved!")
    } else {console.log("no")}
  }

  function stringify(){
    var arr = $('form').serializeArray();
    var strArr = []
    for (var i=0;i<arr.length;i++) {
      strArr.push(arr[i]['value'])
    }
    return strArr.join("")
  }

});
