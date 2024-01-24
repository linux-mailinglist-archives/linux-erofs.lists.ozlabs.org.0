Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADF839E20
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 02:18:00 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SJpYkNMp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TKR0N305Rz3bvd
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 12:17:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SJpYkNMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=laikang0495@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TKR0D3bQMz30f5
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jan 2024 12:17:46 +1100 (AEDT)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-6869d6e1d0cso8178166d6.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706059063; x=1706663863; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d1AXqen0da/MsCsJ/UFD+KjBmPNSbNUJtnBNAq+tApk=;
        b=SJpYkNMp4ZM11rw4GC/KbSjGfrtgPt/lvjfmF90WtbTghxGxYR4CHimcAirAEGH0b3
         KJmnY0mnjrsULcxfPUwpsszB9qan+8gQJ2++Xr5Hla4LZ+5iVHatmwngGJCU4GcyTYS7
         2pbb1SxP3eNglpH8+cvGPT0W6ZzYobzVgA8z2ikFqD/hf+/3l7JgrF/rpoCe4voNykAt
         H51Wuu/vSncoiJYaU+QrP7rO4/8qEWvKxnoZaOuIl6woGE9gGcKlS3zYXcomAhkfWQMO
         RC6Hu1xWcCY6RPjQMCIhNG478gtqQqZGbUfJZAgFFNUxl62UnT4D5862S2uuTO/TTF0Q
         pkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706059063; x=1706663863;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1AXqen0da/MsCsJ/UFD+KjBmPNSbNUJtnBNAq+tApk=;
        b=cbDjKw1ZPC8YTe/Q+VWJDzMTzEC2LpiSDZ8X0kBC+ANaOU0SB4C4awY5BFZGzRcpoM
         R4RmBx/YwuCzJ2SH6pDrWXIDhrmPjbHHL9p8/sHjc0UTSaM6ojwpcoHYplVKjGYA1CzC
         5eCNn5npuPSmcSNn99qwjHm5gG3pP+bHVKHG/kEljfXkpsrhQ8WqbeF+DYmgxCfeMbuO
         eQLgML4yIo+0IQoZ4uSDQDwXu6O/I/r4Z9GHAqJSHXIkbfzgdYpRy9co00uN8IXYZpq8
         nAfZKsiMMK3Ib9CBR7iOsSixeo003nOeq3Q18NUJpLFnfOuXxVc3DwpS/rD4/LPm0z6L
         FQqw==
X-Gm-Message-State: AOJu0YwlmUOAu/v8QzIAYasEJgdyQnIABs7J7kvWiE+Y61kMnVL7Z5Fi
	2pca+Y/j3bnvAHU2A6ovuGDZqwQFSKzRjg6cWAooa27YvzqOu1Tibgjg2CG9aEr3jTpF6qZhKAh
	npVHDaP2i8eA92RLzecIA4WZVMsCBNBXZD+g=
X-Google-Smtp-Source: AGHT+IFM9r+9xzzZOwnusZ+s/u8UT+OQ1Co9+26bWc7UwjdsMbWntvrStgZDRj/fd+DZnbJNl3OJpJUNZ2lA0qDVnpc=
X-Received: by 2002:a05:6214:2a4b:b0:686:aaae:a975 with SMTP id
 jf11-20020a0562142a4b00b00686aaaea975mr1280375qvb.6.1706059063251; Tue, 23
 Jan 2024 17:17:43 -0800 (PST)
MIME-Version: 1.0
From: Lai Kang <laikang0495@gmail.com>
Date: Wed, 24 Jan 2024 08:17:31 +0700
Message-ID: <CAEQysvK93HxY2xwG6Dx0gbjf+MZQZ6Zj6XmuW7nrHRdc-MpZHQ@mail.gmail.com>
Subject: =?UTF-8?B?5Y+q5pyJ6YCJ5oup5q2j5LmJ77yM5omN6IO95oul5pyJ5ZKM5bmz?=
To: linux-erofs@lists.ozlabs.org, fenglinyushu@163.com, zqc007@gmail.com, 
	waihoho@cityu.edu.hk, admissions@tyk.edu.hk
Content-Type: multipart/alternative; boundary="0000000000006e57b8060fa6d4b7"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000006e57b8060fa6d4b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

5L2g5aW9IQ0KDQrkuozpm7bkuozkuozlubTkuozmnIjkuozljYHkuIPml6XvvIznur3nuqbkuInl
pKfljY7kurrnpL7ljLrkuYvkuIDnmoTluIPpsoHlhYvmnpflhavlpKfpgZPkuIrpvJPkuZDpvZDp
uKPjgIINCui/keWNg+WQjeWtpuWRmOWcqOi/memHjOS4vuihjOebm+Wkp+a4uOihjO+8jOW6huel
neS4ieS6v+S5neWNg+S4h+S4reWbveS6uumAgOWHuuS4reWFseWFmuOAgeWbouOAgemYn+e7hOe7
h++8jOWQjOaXtuWRvOWQgeeri+WNs+WBnOatouS4reWFseWvueeahOi/q+Wus+OAgiDkuInnmb7l
jY7kurrnjrDlnLrkuInpgIDjgIINCg0K5ri46KGM5b2T5pel77yM6Ziz5YWJ54G/54OC77yM5YWr
5aSn6YGT5LiK5b2p6b6Z6aOe6Iie77yM6YaS54uu6IW+6LeD77yM6ZSj6byT6b2Q5ZSx77yM5b2p
5peX6aOY5oms77yM5qiq5bmF5bGV5p2/77yM6Iqx6Ii56IWw6byT77yM5ri46KGM6Zif5LyN5LuO
6LW354K556ys5Zub5Y2B5LiA6KGX5Yiw57uI54K556ys5LqU5Y2B5Lmd6KGX77yM5LiA55u057u1
5bu25LqG5Y2B5YWr5p2h6KGX77yM6KaG55uW5LqG5biD6bKB5YWL5p6X5pyA57mB5Y2O55qE5Y2O
5Lq656S+5Yy644CC5Zy66Z2i5q6K6IOc5aOu6KeC77yM6ZyH5pK85Lq65b+D44CC5LyX5aSa5rCR
5LyX56uZ5Zyo6KGX5aS05LiA55255a2m5ZGY55qE5Lqu5Li96aOO6YeH77yM5ouN54Wn44CB5b2V
5YOP44CB5o6l55yf55u46LWE5paZ5ZKM5bCP6I6y6Iqx44CCDQoNCuingueci+a4uOihjCDljY7k
urrop4nphpIg5LiJ55m+5Lq6546w5Zy65LiJ6YCADQrmsJHkvJflnKjop4LnnIvmuLjooYznmoTo
v4fnqIvkuK3vvIznurfnurfpgJrov4fpgIDlhZrkuYnlt6Xlip7nkIbigJzpgIDlhZrjgIHpgIDl
m6LjgIHpgIDpmJ/igJ3vvIzmja7lhajnkIPpgIDlhZrmnI3liqHkuK3lv4Pnu5/orqHvvIzlvZPl
pKnmnIkzMDnkurrlo7DmmI7igJzkuInpgIDigJ3vvIzlhbbkuK0yNOS6uumAgOWHuuWFseS6p+WF
muOAgeWFsemdkuWbouOAgeWwkeWFiOmYn++8mzc35Lq66YCA5YWx6Z2S5Zui5ZKM5bCR5YWI6Zif
77ybMjA45Lq66YCA5Ye65bCR5YWI6Zif44CCDQoNCueptuern+ecn+ebuOWmguS9le+8jOiuqeaI
keS7rOadpeeci+eci+S4gOS4i+i/meevh+iuuuaWh+WIsOW6leWGmeS6huS7gOS5iOOAgg0KDQrm
rLLnn6Xor6bmg4XvvIzor7fnnIvpmYTku7bjgIINCuelneS9oOW5s+Wuie+8gQ0K
--0000000000006e57b8060fa6d4b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+5L2g5aW9ITxkaXY+PGJyPjwvZGl2PjxkaXY+5LqM6Zu25LqM5LqM5bm0
5LqM5pyI5LqM5Y2B5LiD5pel77yM57q957qm5LiJ5aSn5Y2O5Lq656S+5Yy65LmL5LiA55qE5biD
6bKB5YWL5p6X5YWr5aSn6YGT5LiK6byT5LmQ6b2Q6bij44CCIOi/keWNg+WQjeWtpuWRmOWcqOi/
memHjOS4vuihjOebm+Wkp+a4uOihjO+8jOW6huelneS4ieS6v+S5neWNg+S4h+S4reWbveS6uumA
gOWHuuS4reWFseWFmuOAgeWbouOAgemYn+e7hOe7h++8jOWQjOaXtuWRvOWQgeeri+WNs+WBnOat
ouS4reWFseWvueeahOi/q+Wus+OAgiDkuInnmb7ljY7kurrnjrDlnLrkuInpgIDjgILCoDwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+5ri46KGM5b2T5pel77yM6Ziz5YWJ54G/54OC77yM5YWr5aSn
6YGT5LiK5b2p6b6Z6aOe6Iie77yM6YaS54uu6IW+6LeD77yM6ZSj6byT6b2Q5ZSx77yM5b2p5peX
6aOY5oms77yM5qiq5bmF5bGV5p2/77yM6Iqx6Ii56IWw6byT77yM5ri46KGM6Zif5LyN5LuO6LW3
54K556ys5Zub5Y2B5LiA6KGX5Yiw57uI54K556ys5LqU5Y2B5Lmd6KGX77yM5LiA55u057u15bu2
5LqG5Y2B5YWr5p2h6KGX77yM6KaG55uW5LqG5biD6bKB5YWL5p6X5pyA57mB5Y2O55qE5Y2O5Lq6
56S+5Yy644CC5Zy66Z2i5q6K6IOc5aOu6KeC77yM6ZyH5pK85Lq65b+D44CC5LyX5aSa5rCR5LyX
56uZ5Zyo6KGX5aS05LiA55255a2m5ZGY55qE5Lqu5Li96aOO6YeH77yM5ouN54Wn44CB5b2V5YOP
44CB5o6l55yf55u46LWE5paZ5ZKM5bCP6I6y6Iqx44CCPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj7op4LnnIvmuLjooYzjgIDljY7kurrop4nphpLjgIDkuInnmb7kurrnjrDlnLrkuInpgIDCoDwv
ZGl2PjxkaXY+5rCR5LyX5Zyo6KeC55yL5ri46KGM55qE6L+H56iL5Lit77yM57q357q36YCa6L+H
6YCA5YWa5LmJ5bel5Yqe55CG4oCc6YCA5YWa44CB6YCA5Zui44CB6YCA6Zif4oCd77yM5o2u5YWo
55CD6YCA5YWa5pyN5Yqh5Lit5b+D57uf6K6h77yM5b2T5aSp5pyJMzA55Lq65aOw5piO4oCc5LiJ
6YCA4oCd77yM5YW25LitMjTkurrpgIDlh7rlhbHkuqflhZrjgIHlhbHpnZLlm6LjgIHlsJHlhYjp
mJ/vvJs3N+S6uumAgOWFsemdkuWbouWSjOWwkeWFiOmYn++8mzIwOOS6uumAgOWHuuWwkeWFiOmY
n+OAgjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+56m256uf55yf55u45aaC5L2V77yM6K6p5oiR
5Lus5p2l55yL55yL5LiA5LiL6L+Z56+H6K665paH5Yiw5bqV5YaZ5LqG5LuA5LmI44CCPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj7mrLLnn6Xor6bmg4XvvIzor7fnnIvpmYTku7bjgII8L2Rpdj48
ZGl2PuelneS9oOW5s+Wuie+8gcKgPC9kaXY+PC9kaXY+DQo=
--0000000000006e57b8060fa6d4b7--
