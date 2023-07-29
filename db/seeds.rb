User.create(
  [
    { name: 'うさぎ好き', email: 'usagi1@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: 'ベテラン', email: 'usagi2@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: '初心者', email: 'usagi3@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' }
  ]
)

Question.create(
  [
    { title: '牧草', body: '牧草はなにが好きですか？', user_id: 1 },
    { title: 'おやつ', body: 'おすすめのおやつを教えてください', user_id: 1 },
    { title: 'おもちゃ', body: 'うちはボールで遊ぶのですが、なんのおもちゃで遊んでますか？', user_id: 2 },
    { title: 'さんぽ', body: 'さんぽは行きますか？', user_id: 2 },
    { title: '食べ物', body: 'うさぎって何を食べるんですか', user_id: 3 },
    { title: '費用', body: '飼い始めるにはどれくらいの費用がかかりますか？', user_id: 3 }
  ]
)

Answer.create(
  [
    { body: 'いま３歳ですが、チモシーのカナダ産が好きでよく食べます', question_id: 1, user_id: 2 },
    { body: 'パスチャーチモシーを買っています。小さい時はパスチャーアルファルファをよく食べていました。', question_id: 1, user_id: 3 },
    { body: '乾燥ニンジンが好きです！走って食べにきます！', question_id: 2, user_id: 2 },
    { body: 'オーツヘイと乾燥りんごがお気に入りの様です😊', question_id: 2, user_id: 3 },
    { body: 'うさぎのぬいぐるみがあるのですが、隣で座ったりしています', question_id: 3, user_id: 1 },
    { body: 'ダンボールをほじほじして遊んでいます笑', question_id: 3, user_id: 3 },
    { body: '毎日1時間くらい部屋に出しています。', question_id: 4, user_id: 1 },
    { body: '外に時々さんぽに連れていきます。リードをつけて公園内を少し歩きますよ。', question_id: 4, user_id: 3 },
    { body: '毎日牧草とペレットをあげています。時々おやつもあげますよ', question_id: 5, user_id: 1 },
    { body: '牧草は切らさないようにしなくてはいけません。時期によってあげる牧草も違い、子うさぎの時はアルファルファ、成うさぎにはチモシーをあげます。', question_id: 5, user_id: 2 },
    { body: 'ホームセンターで購入しましたが、うさちゃんが5,000~10,000円。ゲージ、トイレ、家、水飲み、餌購入で15,000~20,000円くらいでしょうか。', question_id: 6, user_id: 1 },
    { body: '2〜3万円くらいかなあ', question_id: 6, user_id: 2 }
  ]
)

Reaction.create(
  [
    { body: 'カナダ産ためしてみます😄', user_id: 1, answer_id: 1 },
    { body: 'みなさんありがとうございます。あげたこと無かったので、りんごをあげてみようと思います！', user_id: 1, answer_id: 4 },
    { body: 'ぬいぐるみかわいいですね！', user_id: 2, answer_id: 5 }
  ]
)
