[@@@ocaml.warning "-27"]

let game_over board winner request =
  <html>
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1> Connect 4! </h1>
    <h2> <%s winner%> wins! </h2>

    <div class="options-container">
    <table>
      <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit" class="options-selector"> Reset </button>
      </form>
    </table>
    </div>

    <div id="board" style="display: none;"><%s board%></div>
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1> Connect 4!</h1>
    <h2> Game saved! Reset to play a new game or load this one</h2>
    
    <div class="options-container">
    <table>
      <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit" class="options-selector"> Reset </button>
      </form>
    </table>
    </div>
    
    <div id="board" style="display: none;"><%s board%></div>
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
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
    <h1> Connect 4! </h1>
    <h2> Select number of players or load a game </h2>
    <div class="options-container">
    <table>
      <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="players" value="1" autofocus>
        <button type="submit" class="options-selector"> 1 </button>
      </form>
      <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="players" value="2" autofocus>
        <button type="submit" class="options-selector"> 2 </button>
      </form>
      <%s! Dream.form_tag ~action:"/load" request %>
          <input type="hidden" name="ending" autofocus>
          <button type="submit" class="options-selector"> Load </button>
      </form>
    </table>
    </div>
      <div id="board" style="display: none;">""</div>
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
    <script src="static/app.js"></script>
  </body>
  </html>

let get_difficulty ?message request =
  <html>
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
    <div id="board" style="display: none;">""</div>
    <h1> Connect 4! </h1>
    <h2> Would you like to play against the hard or easy AI? </h2>
    <div class="options-container">
    <table>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="difficulty" value="false"autofocus>
      <button type="submit" class="options-selector"> Easy </button>
    </form>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="difficulty" value="true"autofocus>
      <button type="submit" class="options-selector"> Hard </button>
    </form>
    </table>
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
  <script src="static/app.js"></script>
  </body>
  </html>
  
let player_order ?message request =
  <html>
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
    <div id="board" style="display: none;">""</div>
    <h1> Connect 4! </h1>
    <h2> Do you want to go first or second? </h2>
    <div class="options-container">
    <table>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="order" value="1"autofocus>
      <button type="submit" class="options-selector"> First </button>
    </form>
    <%s! Dream.form_tag ~action:"/" request %>
      <input type="hidden" name="order" value="2"autofocus>
      <button type="submit" class="options-selector"> Second </button>
    </form>
    </table>
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
  <script src="static/app.js"></script>
  </body>
  </html>

let game_in_progress ?message board player request =
  <html>
  <head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
  </head> 
  <body>
  <div>
    <h1> Connect 4! </h1>
    <h2> <%s player%>'s turn </h2>

    <div class="options-container">
    <table>
      <%s! Dream.form_tag ~action:"/save" request %>
        <input type="hidden" name="message" autofocus>
        <button type="submit" class="options-selector"> Save </button>
      </form>
      <%s! Dream.form_tag ~action:"/" request %>
        <input type="hidden" name="reset" autofocus>
        <button type="submit" class="options-selector"> Reset </button>
      </form>
    </table>
    </div>

    <div id="board" style="display: none;"><%s board%></div>
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
        <button class="col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="2" autofocus>
        <button class="col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="3" autofocus>
        <button class="col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="4" autofocus>
        <button class="col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="5" autofocus>
        <button class = "col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="6" autofocus>
        <button class = "col-selector"> Go Here </button>
      </form>
      <%s! Dream.form_tag ~action:"/play" request %>
        <input type="hidden" id="message" name="message" value="7" autofocus>
        <button class = "col-selector">Go Here</button>
      </form>
      <table>
    </div>
  </div>
  <script src="static/app.js"></script>
  </body>
  </html>
