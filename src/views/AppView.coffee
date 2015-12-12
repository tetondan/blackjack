class window.AppView extends Backbone.View
  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="winner"></div>
    <div class="dealer-hand-container"></div>
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
      @$('.winner').html '<p>You Lose!</p>'
      @$('.buttons').html '<button class="deal">New Hand</button>'
    @model.on 'tie', () =>
      @$('.winner').html "<p>It's a Tie!</p>"
      @$('.buttons').html '<button class="deal">New Hand</button>'
    @model.on 'player', () =>
      @$('.winner').html '<p>You Win!</p>'
      @$('.buttons').html '<button class="deal">New Hand</button>'


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

