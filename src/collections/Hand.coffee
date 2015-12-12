class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if @scores() == 0
      @stand() 
    @last()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    if @minScore() + 10 * @hasAce() >= 22 && @minScore() >= 22
      0
    else if @minScore() + 10 * @hasAce() >= 22
      @minScore()
    else 
      @minScore() + 10 * @hasAce() 

  stand: ()->
    @trigger 'stand', @
