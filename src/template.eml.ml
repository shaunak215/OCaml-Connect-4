[@@@ocaml.warning "-27"]

let game_over winner =
  <html>
  <body>
  <h1>Winner: <%s winner%></h1>
  <body>
  <html>

let goodbye =
  <html>
  <body>
  <h1>Goodbye!!</h1>
  <body>
  <html>

let collect_players ?message request =
  <html>
  <body>
    <h1> Please indicate how many players you have </h1>
    <h2> One to play against the AI, two to play against someone else</h2>
%   begin match message with
%   | None -> ()
%   | Some message ->
      <p>You entered: <b><%s message %>!</b></p>
%   end;

    <%s! Dream.form_tag ~action:"/" request %>
      <input name="players" autofocus>
    </form>
  </body>
  </html>

let player_order ?message request =
  <html>
  <body>
    <h1> If you would like to go first enter (1). If you want to go second enter (2). </h1>
%   begin match message with
%   | None -> ()
%   | Some message ->
      <p>You entered: <b><%s message %>!</b></p>
%   end;

    <%s! Dream.form_tag ~action:"/" request %>
      <input name="order" autofocus>
    </form>
  </body>
  </html>

let game_in_progress ?message board player request =
  <html>
  <head>
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1><%s player%>'s turn</h1>
    <div id="board" style="display: none;"><%s board%></div>
    <div>
    <%s! Dream.form_tag ~action:"/play" request %>
        <input name="message" autofocus>
      </form>
    </div>
    <div>
    <%s! Dream.form_tag ~action:"/save" request %>
        <input type="hidden" name="message" autofocus>
        <button type="submit"> Save </button>
      </form>
    </div>
    <div class="container">
      <table>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
          <tr>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
              <td class="slot"></td>
          </tr>
    </div>
  </div>
  <script src="static/app.js"></script>
  </body>
  </html>
