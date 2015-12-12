# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    listener = @get 'playerHand'
    listener.on 'stand', () =>
      dh = @get 'dealerHand' 
      dh.at(0).flip()
      dhScore = dh.scores()
      ph = @get 'playerHand'
      phScore = ph.scores()
      while dhScore <= 17 && dhScore != 0 && phScore != 0
        dh.hit()
        dhScore = dh.scores()
      phScore = ph.scores()
      if dhScore > phScore
        alert('Dealer Wins')
      else if dhScore == phScore
        alert("It's a tie")
      else
        alert("Player wins") 
