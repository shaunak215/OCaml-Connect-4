[@@@ocaml.warning "-27"]

let game_over board winner request =
  <html>
  <head>
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1><%s winner%> wins!</h1>
    <div id="board" style="display: none;"><%s board%></div>
    <div>
    <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit"> Reset </button>
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
          </table>
    </div>
  </div>
  <script src="static/app.js"></script>
  </body>
  </html>

let saved board request =
  <html>
  <head>
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1>You have saved this game! Reset to start a new game or load this one back up later!</h1>
    <div id="board" style="display: none;"><%s board%></div>
    <div>
    <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit"> Reset </button>
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
          </table>
    </div>
  </div>
  <script src="static/app.js"></script>
  </body>
  </html>

let collect_players ?message request =
  <html>
  <body>
    <h1> Welcome to Connect 4! </h1>
    <h2> How many players will be playing? You can also load a game you have already saved.</h2>

    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="players" value="1" autofocus>
      <button type="submit"> 1 </button>
    </form>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="players" value="2" autofocus>
      <button type="submit"> 2 </button>
    </form>
    <%s! Dream.form_tag ~action:"/load" request %>
        <input type="hidden" name="ending" autofocus>
        <button type="submit"> Load Game </button>
      </form>
  </body>
  </html>

let player_order ?message request =
  <html>
  <body>
    <h1> Do you want to go first or second? </h1>

    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="order" value="1"autofocus>
      <button type="submit"> First </button>
    </form>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="order" value="2"autofocus>
      <button type="submit"> Second </button>
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
    <%s! Dream.form_tag ~action:"/save" request %>
        <input type="hidden" name="message" autofocus>
        <button type="submit"> Save </button>
    </form>
    <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit"> Reset </button>
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
          </table>
    </div>
    <div class="button-container">
      <table>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="1" autofocus>
        <button class="col-selector"> 1 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="2" autofocus>
        <button class="col-selector"> 2 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="3" autofocus>
        <button class="col-selector"> 3 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="4" autofocus>
        <button class="col-selector"> 4 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="5" autofocus>
        <button class = "col-selector"> 5 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="6" autofocus>
        <button class = "col-selector"> 6 </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="7" autofocus>
        <button class = "col-selector">7</button>
      </form>
      <table>
    </div>
  </div>
  <script src="static/app.js"></script>
  </body>
  </html>
