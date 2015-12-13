class window.AppView extends Backbone.View
  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="winner"></div>
    <div class="dealer-hand-container"></div>
    <div class="wins"><p>Wins: <%= wins %></p><p>Loses: <%= loses %></p></div>  
    <div class="money"><p>$<%= money%></div>  
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .deal': -> 
      @model.game()
      @render()
    
  initialize: ->
    @render()
    @model.on 'dealer', () =>
      loses = @model.get 'loses' 
      @model.set 'loses', ++loses
      money = @model.get 'money' 
      @model.set 'money', --money
      console.log(loses)
      @$('.winner').html '<p>You Lose!</p>'
      @$('.buttons').html '<button class="deal">New Hand</button>'
    @model.on 'tie', () =>
      @$('.winner').html "<p>It's a Tie!</p>"
      @$('.buttons').html '<button class="deal">New Hand</button>'
    @model.on 'player', () =>
      wins = @model.get 'wins' 
      @model.set 'wins', ++wins
      money = @model.get 'money' 
      @model.set 'money', money += 1.5
      @$('.winner').html '<p>You Win!</p>'
      @$('.buttons').html '<button class="deal">New Hand</button>'


  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    

