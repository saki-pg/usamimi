User.create([
    { name: 'うさぎ好き', email: 'usagi1@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: 'ベテラン', email: 'usagi2@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: '初心者', email: 'usagi3@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' }
])

Tag.delete_all
tags = Tag.create([
    { name: '食事' },
    { name: '健康' },
    { name: '環境' },
    { name: '行動' },
    { name: '飼い方' },
    { name: 'グッズ' }
])

Question.create([
    { title: '牧草', body: '牧草はなにが好きですか？', user_id: 1, tag_ids: [tags[0].id]},
    { title: 'おやつ', body: 'おすすめのおやつを教えてください', user_id: 1, tag_ids: [tags[0].id] },
    { title: '鳴く', body: 'うさぎは鳴かないと聞いていたのですが、近くに来た時によくぶうぶう言います。鳴くことはありますか？', user_id: 1, tag_ids: [tags[3].id] },
    { title: '多頭飼い', body: '今８歳の子を飼っているのですが、もう１匹飼いたいと思っています。多頭飼いされている方いらっしゃいますか？うさぎの仲などどうですか？？', user_id: 1, tag_ids: [tags[2].id, tags[4].id] },
    { title: 'おもちゃ', body: 'うちはボールで遊ぶのですが、なんのおもちゃで遊んでますか？', user_id: 2, tag_ids: [tags[5].id] },
    { title: 'さんぽ', body: 'さんぽは行きますか？', user_id: 2, tag_ids: [tags[1].id] },
    { title: '食べ物', body: 'うさぎって何を食べるんですか', user_id: 3, tag_ids: [tags[0].id] },
    { title: '費用', body: '飼い始めるにはどれくらいの費用がかかりますか？', user_id: 3, tag_ids: [tags[2].id] }
])


Answer.create([
    { body: 'いま３歳ですが、チモシーのカナダ産が好きでよく食べます', question_id: 1, user_id: 2 },
    { body: 'パスチャーチモシーを買っています。小さい時はパスチャーアルファルファをよく食べていました。', question_id: 1, user_id: 3 },
    { body: '乾燥ニンジンが好きです！走って食べにきます！', question_id: 2, user_id: 2 },
    { body: 'オーツヘイと乾燥りんごがお気に入りの様です😊', question_id: 2, user_id: 3 },
    { body: 'うさぎのぬいぐるみがあるのですが、隣で座ったりしています', question_id: 5, user_id: 1 },
    { body: 'ダンボールをほじほじして遊んでいます笑', question_id: 5, user_id: 3 },
    { body: '毎日1時間くらい部屋に出しています。', question_id: 6, user_id: 1 },
    { body: '外に時々さんぽに連れていきます。リードをつけて公園内を少し歩きますよ。', question_id: 6, user_id: 3 },
    { body: '毎日牧草とペレットをあげています。時々おやつもあげますよ', question_id: 7, user_id: 1 },
    { body: '牧草は切らさないようにしなくてはいけません。時期によってあげる牧草も違い、子うさぎの時はアルファルファ、成うさぎにはチモシーをあげます。', question_id: 7, user_id: 2 },
    { body: 'ホームセンターで購入しましたが、うさちゃんが5,000~10,000円。ゲージ、トイレ、家、水飲み、餌購入で15,000~20,000円くらいでしょうか。', question_id: 8, user_id: 1 },
    { body: '2〜3万円くらいかなあ', question_id: 8, user_id: 2 }
])

Reaction.create([
    { body: 'カナダ産ためしてみます😄', user_id: 1, answer_id: 1 },
    { body: 'みなさんありがとうございます。あげたこと無かったので、りんごをあげてみようと思います！', user_id: 1, answer_id: 4 },
    { body: 'ぬいぐるみかわいいですね！', user_id: 2, answer_id: 5 }
])


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
end

article1 = AdminArticle.create!(
    title: 'おやつ',
    content: 'うさぎ用のおやつはたくさん販売されていますが、砂糖などの添加がないものがおすすめです。\n
    乾燥にんじんや、乾燥パパイヤ、乾燥りんごなど好みがありますが、喜んで食べてくれます。\n\n
    食べれる薬膳もあるようです。'
)

article2 = AdminArticle.create!(
    title: 'うさぎの牧草',
    content: 'うさぎの牧草はアルファルファ（マメ科）、チモシー（イネ科）がありますが、\n
    栄養のあるアルファルファは成年前、繊維質のチモシーは成年後に適しています。\n\n

    チモシーは、刈り取り時期が違う１番草、２番草、３番草があり、３番草が１番柔らかいです。\n
    産地別でも味が違うようで、お試しキット等でうさぎの好みを知ることができます。'
)
article2.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_2.jpg')), filename: 'article_2.jpg', content_type: 'image/jpeg')


article3 = AdminArticle.create!(
    title: 'うさぎの適温',
    content: '今年の夏は暑いですね☀️\n
    うさぎを飼育する時の適正温度は、室温15～25℃・湿度40～60%位が理想といわれています。\n\n

    クーラーやうさぎのための冷感グッズ（ペット用クーラー、アルミプレート、天然石プレートなど）でぜひ対策されてみてください。'
)
article3.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_3.jpg')), filename: 'article_3.jpg', content_type: 'image/jpeg')


article4 = AdminArticle.create!(
    title: 'そろそろ換毛期',
    content: 'うさぎの換毛期は主に、夏毛に生え変わる春の4月ごろ・冬毛に生え変わる秋の10月ごろといわれています。\n
    うさぎによって抜け方も違うようですが、触るとすごい毛が抜けたり驚くことがあります。\n\n

    この時期のブラッシングにはシリコンのブラシを使っていますが、柔らかい素材で安心して使えます。\n
    床の毛の掃除はコロコロが便利ですね。'
)
article4.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_4.jpg')), filename: 'article_4.jpg', content_type: 'image/jpeg')


article5 = AdminArticle.create!(
    title: '爪切り',
    content: '爪切りの頻度は、うさぎによって差がありますが、およそ1～2ヶ月に1度は必要といわれています。\n
    伸びてくると、ひっかかったり折れたり、ケガにつながる可能性があります。\n\n

    動物病院やうさぎのペットショップで切ってくれますね。\n
    自宅でやる場合、爪切りが切りやすいものとそうでないものがあったりします。\n
    使いやすいものを探してみるとすんなり切りやすいと思います。
    '
)
article5.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_5.jpg')), filename: 'article_5.jpg', content_type: 'image/jpeg')


article6 = AdminArticle.create!(
    title: 'うさぎの歯',
    content: 'うさぎの歯は28本あり、1日に0.5cmくらいのびるようです。\n
    歯が伸びすぎてしまうと噛み合わせが悪くなり、病気に繋がってしまいます。\n\n

    固めの牧草中心の食生活をすることで予防することができます。'
)
