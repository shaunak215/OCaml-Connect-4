var row = document.getElementsByTagName('tr');
var table = document.getElementsByTagName('td');

function populateBoard() {
    let cur = true;
    let board = document.getElementById('board').innerHTML;
    let heights = [5,5,5,5,5,5,5];
    for (let i = 0; i < board.length; i++) {
        let col = parseInt(board[i]) - 1;
        colHeight = heights[col];
        if (cur) {
            row[colHeight].children[col].style.backgroundColor = 'red';
            cur = false;
        } else {
            cur = true;
            row[colHeight].children[col].style.backgroundColor = 'yellow';
        }
        heights[col] = colHeight - 1;
    } 
}


populateBoard();