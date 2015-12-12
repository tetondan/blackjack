assert = chai.assert
expect = chai.expect
describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52
  it 'should shuffle every new deck', ->
    collection = new Deck()
    collection2 = new Deck()
    expect(collection.at(0)).not.to.equal(collection2.at(0))
  it "every hand should have two cards", ->
    collection = new Deck()
    player = collection.dealPlayer()
    dealer = collection.dealDealer()
    expect(dealer.length).to.equal(2)    
    expect(player.length).to.equal(2)
  it "player should not be dealer", ->
    collection = new Deck()
    player = collection.dealPlayer()
    expect(player.isDealer).to.equal(false)
  it "dealer should be dealer", ->
    collection = new Deck()
    dealer = collection.dealDealer()
    expect(dealer.isDealer).to.equal(true)