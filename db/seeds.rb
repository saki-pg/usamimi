User.delete_all
users = User.create!([
    { name: 'うさぎ好き', email: 'usagi1@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: 'ベテラン', email: 'usagi2@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' },
    { name: '初心者', email: 'usagi3@sample.com', password: 'aaaaaa', password_confirmation: 'aaaaaa' }
])

Tag.delete_all
tags = Tag.create!([
    { name: '食事' },
    { name: '健康' },
    { name: '環境' },
    { name: '行動' },
    { name: '飼い方' },
    { name: 'グッズ' }
])

Question.delete_all
questions = Question.create!([
    { title: '牧草', body: '牧草はなにが好きですか？', user: users[0], tag_ids: [tags[0].id] },
    { title: 'おやつ', body: 'おすすめのおやつを教えてください', user: users[0], tag_ids: [tags[0].id] },
    { title: '鳴く', body: 'うさぎは鳴かないと聞いていたのですが、近くに来た時によくぶうぶう言います。鳴くことはありますか？', user: users[0], tag_ids: [tags[3].id] },
    { title: '多頭飼い', body: '今８歳の子を飼っているのですが、もう１匹飼いたいと思っています。多頭飼いされている方いらっしゃいますか？うさぎの仲などどうですか？？', user: users[0], tag_ids: [tags[2].id, tags[4].id] },
    { title: 'おもちゃ', body: 'うちはボールで遊ぶのですが、なんのおもちゃで遊んでますか？', user: users[1], tag_ids: [tags[5].id] },
    { title: 'さんぽ', body: 'さんぽは行きますか？', user: users[1], tag_ids: [tags[1].id] },
    { title: '食べ物', body: 'うさぎって何を食べるんですか', user: users[2], tag_ids: [tags[0].id] },
    { title: '費用', body: '飼い始めるにはどれくらいの費用がかかりますか？', user: users[2], tag_ids: [tags[2].id] }
])

Answer.delete_all
answers = Answer.create!([
    { body: 'いま３歳ですが、チモシーのカナダ産が好きでよく食べます', question: questions[0], user: users[1] },
    { body: 'パスチャーチモシーを買っています。小さい時はパスチャーアルファルファをよく食べていました。', question: questions[0], user: users[2] },
    { body: '乾燥ニンジンが好きです！走って食べにきます！', question: questions[1], user: users[1] },
    { body: 'オーツヘイと乾燥りんごがお気に入りの様です😊', question: questions[1], user: users[2] },
    { body: 'うさぎのぬいぐるみがあるのですが、隣で座ったりしています', question: questions[4], user: users[0] },
    { body: 'ダンボールをほじほじして遊んでいます笑', question: questions[4], user: users[2] },
    { body: '毎日1時間くらい部屋に出しています。', question: questions[5], user: users[0] },
    { body: '外に時々さんぽに連れていきます。リードをつけて公園内を少し歩きますよ。', question: questions[5], user: users[2] },
    { body: '毎日牧草とペレットをあげています。時々おやつもあげますよ', question: questions[6], user: users[0] },
    { body: '牧草は切らさないようにしなくてはいけません。時期によってあげる牧草も違い、子うさぎの時はアルファルファ、成うさぎにはチモシーをあげます。', question: questions[6], user: users[1] },
    { body: 'ホームセンターで購入しましたが、うさちゃんが5,000~10,000円。ゲージ、トイレ、家、水飲み、餌購入で15,000~20,000円くらいでしょうか。', question: questions[7], user: users[0] },
    { body: '2〜3万円くらいかなあ', question: questions[7], user: users[1] }
])

Reaction.delete_all
reactions = Reaction.create!([
    { body: 'カナダ産ためしてみます😄', user: users[0], answer: answers[0] },
    { body: 'みなさんありがとうございます。あげたこと無かったので、りんごをあげてみようと思います！', user: users[0], answer: answers[3] },
    { body: 'ぬいぐるみかわいいですね！', user: users[1], answer: answers[4] }
])

AdminUser.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |user|
    user.password = ENV['ADMIN_PASSWORD']
    user.password_confirmation = ENV['ADMIN_PASSWORD']
end

article1 = AdminArticle.create!(
    title: 'おやつ',
    content: 'うさぎ用のおやつはたくさん販売されていますが、砂糖などの添加がないものがおすすめです。<br>
    乾燥にんじんや、乾燥パパイヤ、乾燥りんごなど好みがありますが、喜んで食べてくれます。<br><br>
    食べれる薬膳もあるようです。'
)

article2 = AdminArticle.create!(
    title: 'うさぎの牧草',
    content: 'うさぎの牧草はアルファルファ（マメ科）、チモシー（イネ科）がありますが、<br>
    栄養のあるアルファルファは成年前、繊維質のチモシーは成年後に適しています。<br><br>
    チモシーは、刈り取り時期が違う１番草、２番草、３番草があり、３番草が１番柔らかいです。<br>
    産地別でも味が違うようで、お試しキット等でうさぎの好みを知ることができます。'
)
article2.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_2.jpg')), filename: 'article_2.jpg', content_type: 'image/jpeg')
article2.save

article3 = AdminArticle.create!(
    title: 'うさぎの適温',
    content: '今年の夏は暑いですね☀️<br>
    うさぎを飼育する時の適正温度は、室温15～25℃・湿度40～60%位が理想といわれています。<br><br>
    クーラーやうさぎのための冷感グッズ（ペット用クーラー、アルミプレート、天然石プレートなど）でぜひ対策されてみてください。'
)
article3.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_3.jpg')), filename: 'article_3.jpg', content_type: 'image/jpeg')
article3.save

article4 = AdminArticle.create!(
    title: 'そろそろ換毛期',
    content: 'うさぎの換毛期は主に、夏毛に生え変わる春の4月ごろ・冬毛に生え変わる秋の10月ごろといわれています。<br>
    うさぎによって抜け方も違うようですが、触るとすごい毛が抜けたり驚くことがあります。<br><br>
    この時期のブラッシングにはシリコンのブラシを使っていますが、柔らかい素材で安心して使えます。<br>
    床の毛の掃除はコロコロが便利ですね。'
)
article4.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_4.jpg')), filename: 'article_4.jpg', content_type: 'image/jpeg')
article4.save

article5 = AdminArticle.create!(
    title: '爪切り',
    content: '爪切りの頻度は、うさぎによって差がありますが、およそ1～2ヶ月に1度は必要といわれています。<br>
    伸びてくると、ひっかかったり折れたり、ケガにつながる可能性があります。<br><br>
    動物病院やうさぎのペットショップで切ってくれますね。<br>
    自宅でやる場合、爪切りが切りやすいものとそうでないものがあったりします。<br>
    使いやすいものを探してみるとすんなり切りやすいと思います。'
)
article5.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'article_5.jpg')), filename: 'article_5.jpg', content_type: 'image/jpeg')
article5.save

article6 = AdminArticle.create!(
    title: 'うさぎの歯',
    content: 'うさぎの歯は28本あり、1日に0.5cmくらいのびるようです。<br>
    歯が伸びすぎてしまうと噛み合わせが悪くなり、病気に繋がってしまいます。<br><br>
    固めの牧草中心の食生活をすることで予防することができます。'
)
