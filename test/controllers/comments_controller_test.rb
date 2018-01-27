require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include CommentsHelper

  test "should get index" do
    get comments_url
    assert_response :success
  end

  test "should work comment grabber" do
    post get_comments_comments_url, xhr: true, params: {ifq_url: "https://www.ilfattoquotidiano.it/2018/01/27/lecce-i-figli-di-immigrati-nati-in-italia-e-residenti-in-citta-avranno-la-cittadinanza-onoraria-il-sindaco-un-atto-doveroso/4119175/"}
    assert JSON.parse(@response.body)["comments"].count > 0
    assert_response :success
  end

  test "should parse comments" do

    comments = parse_comments <<-eos
      { "next_link": "", "prev_link": "", "max_pages": 1, "page_num": 1, "comment_count": "30", "comments": [ { "children": [ { "children": [], "id": "25820234", "content": "Condivido in pieno!", "karma": "0", "date": 1517042381, "author": "salvi54", "user_id": "185042", "avatar": "https://secure.gravatar.com/avatar/b46736dbd9b2b36cb8d3628f8f30fdda?s=48&d=identicon&r=g", "approved": 1, "upvote": "", "user_lvl": 0, "comment_by_post_autor": false } ], "id": "25819808", "content": "La Boldrini ha dimostrato una grande presunzione e una notevole scarsità di idee, tuttavia il mio profondo disgusto per lei deriva dalla parzialita con cui ha svolto il suo ruolo, oltre che alla sensazione che sia molto legata al denaro. La Lega ha gioco facile ad additarla come bersaglio perchè la presidenta ci ha messo del suo.", "karma": "0", "date": 1517015926, "author": "Marf", "user_id": "99678", "avatar": "https://secure.gravatar.com/avatar/f6ad01a493cf5316c68499611d435036?s=48&d=identicon&r=g", "approved": 1, "upvote": "1", "user_lvl": 1, "comment_by_post_autor": false }, { "children": [], "id": "25819483", "content": "Si puo dire lo stesso che a me Boldrini non piace neanche un po? Posso scrivere che non mi sento di difenderla dopo la sua presidenza? Posso dire che non amo questa stella del firmamento che e' arrivata come per magia negli scranni piu alti, al servizio di noi ltaliani, a cui ha fatto giuramento? E poi ti rifila certi discorsi? ", "karma": "0", "date": 1517002368, "author": "MauroAsia", "user_id": "336235", "avatar": "https://secure.gravatar.com/avatar/343e0e903f721a602d90f29e9fd79998?s=48&d=identicon&r=g", "approved": 1, "upvote": "3", "user_lvl": 1, "comment_by_post_autor": false }, { "children": [], "id": "25817289", "content": "Salvini-Boldrini non commentini", "karma": "0", "date": 1516981192, "author": "GENNARO", "user_id": "291520", "avatar": "https://secure.gravatar.com/avatar/5aa9b82da7195274368c2ba1367820c8?s=48&d=identicon&r=g", "approved": 1, "upvote": "", "user_lvl": 1, "comment_by_post_autor": false }, { "children": [], "id": "25820582", "content": "Bene, le prove sono state eseguite... ", "karma": "0", "date": 1517046124, "author": "m_bun", "user_id": "385531", "avatar": "https://secure.gravatar.com/avatar/67c5528b57137ad335b93cfc4d010f63?s=48&d=identicon&r=g", "approved": 1, "upvote": "", "user_lvl": 0, "comment_by_post_autor": false }, { "children": [], "id": "25820552", "content": "Bene, le prove sono state fatte...", "karma": "0", "date": 1517045921, "author": "m_bun", "user_id": "385531", "avatar": "https://secure.gravatar.com/avatar/67c5528b57137ad335b93cfc4d010f63?s=48&d=identicon&r=g", "approved": 1, "upvote": "", "user_lvl": 0, "comment_by_post_autor": false }, { "children": [], "id": "25820197", "content": "Costoro che hanno bruciato i fantocci di Boldrini e company, sono dei satiri e vanno assolti. Così ha deciso un Magistrato zelante quando hanno processato i 5 cani di Pomigliano che hanno impiccato il busto di Marchionne. Quindi non gridiamo allo scandalo, quando anche la Giustizia Italiana ammette queste vaccate. La legge buona o cattiva deve valere per tutti. A le persone che fanno queste cose fanno schifo.. nè più nè meno che i boia di Pomigliano. Ma più di loro fa schifo certa magistratura che infetta anche Giudici corretti nel loro lavoro.", "karma": "0", "date": 1517041669, "author": "Antonio Gallinari", "user_id": "364387", "avatar": "https://secure.gravatar.com/avatar/02c38dbd4f7c5c9df7b0bf71415457bf?s=48&d=identicon&r=g", "approved": 1, "upvote": "", "user_lvl": 0, "comment_by_post_autor": false } ] }
    eos
    assert comments.count == 7
  end

  test "should get comments id" do
    id = get_comments_id("https://www.ilfattoquotidiano.it/2018/01/27/lecce-i-figli-di-immigrati-nati-in-italia-e-residenti-in-citta-avranno-la-cittadinanza-onoraria-il-sindaco-un-atto-doveroso/")
    assert_equal id, "4119175"
  end

  test "get comments from ifq api should work" do
    comments1 = get_unparsed_comments("4119175")
    comments2 = get_unparsed_comments(4119175)

    p_comm1 = JSON.parse(comments1)
    p_comm2 = JSON.parse(comments2)

    assert_equal p_comm1["comments"].count, p_comm2["comments"].count 
    assert_equal comments1, comments2
  end
end
