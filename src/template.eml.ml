let game_over winner =
  <html>
  <body>
  <h1>Winner: <%s winner%></h1>
  <body>
  <html>

let game_in_progress ?message board player request =
  <html>
  <body>
  <h1>board: <%s board%></h1>
  <h1><%s player%>'s turn</h1>
%   begin match message with
%   | None -> ()
%   | Some message ->
      <p>You entered: <b><%s message %>!</b></p>
%   end;

    <%s! Dream.form_tag ~action:"/" request %>
      <input name="message" autofocus>
    </form>

  </body>
  </html>