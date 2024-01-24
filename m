Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC1839E6B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 02:52:13 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fqWjVx9F;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TKRlv5YHDz3bvX
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jan 2024 12:52:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fqWjVx9F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d2c; helo=mail-io1-xd2c.google.com; envelope-from=yijianguo1299@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TKRlk68bTz2ytp
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jan 2024 12:52:00 +1100 (AEDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so203431539f.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 17:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706061117; x=1706665917; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETSpdDnpTrmuJERgH3L6ZXPtIuQV5BgJfS5d5sGK4AI=;
        b=fqWjVx9FQyH8kuStU9ZtS05b3EgCJBWKk7EcU8nZ226+3IZ73dKlJpNwmUgbNv0VP4
         X1REUptPhGCyjiJUFOpC2tI+4Tr+lpEGNIQIbFA5FHPWBrNCoocB48NCYI7srX83IWDh
         JMK60NdgWRokhGcfkvx/pr8q9NEuw+tFMzpN7i6toWVDze5cDmNBpu1x5UznNvh8iVOM
         aNB6MBQiExnBBwkxGplqD44meAfpkzX65XMxHThDnJ2uAfhr5MYvhlyjBbkw5OGQy3wQ
         klqFYck+HqSWzpfGF4b0NCdrPdbhI4GE/FP7wMY7t5LhGD+VkwwRZ/kpkdKJKQ4Q3Whb
         JRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706061117; x=1706665917;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETSpdDnpTrmuJERgH3L6ZXPtIuQV5BgJfS5d5sGK4AI=;
        b=dJnyvsaPf/iI5Sxlqlo3Cf+JodlW8ekeNNErZFg42veRUTtDqtYzUo4bQ31N6BWqTg
         aGiHHBGkfK/WKRqs+yGucmA/H2JFpRlvve50A4uQskqg6dLkwKsyfbhjwwudTCXIhxjT
         0jFPJTf9UXVcslKCC/giEtI03gBx9Ta2UCvyf9yInYYXKYwYoY5NVcqX/jOi1cZdGRBo
         0uFSM/h76GIiSaTY9E3yJg3wenH0k+cLbSOh0JXpxt3O5bnl9CP5BmQ8dkxf9EDAN4Cb
         fzr3oCE2isk9yhF2XZ467s1D0JUA/s+4EnbPsMrocUShZ7wd/7TAO7yzCd9Aqul72jJK
         x98A==
X-Gm-Message-State: AOJu0YzUpaAI+/QewsCwzRFl8bLfW76tgAQUyRde6HzCGdGrP5xSO9kU
	pXr0Ue+yM5oacm4EroOC3a4aKe/dui5rQeN63IQ91Sk7EvmwhjsOelQRMt0Op0n5rxTiS7l7hTA
	Re+wZH8KyxWZoSW2HoPSpucdFoy41ouiX
X-Google-Smtp-Source: AGHT+IGqvEFbRTmJP+JKotZOqU5zPjDdrodPEFdAUJOzWxeOK4IOxk3002+PokbLVjg1Wo1wzv5qaWdkPRk8fSVoeJQ=
X-Received: by 2002:a92:d383:0:b0:360:a44d:caf7 with SMTP id
 o3-20020a92d383000000b00360a44dcaf7mr914021ilo.9.1706061117533; Tue, 23 Jan
 2024 17:51:57 -0800 (PST)
MIME-Version: 1.0
From: Yi Jianguo <yijianguo1299@gmail.com>
Date: Wed, 24 Jan 2024 08:51:46 +0700
Message-ID: <CAGGzz-6NG-JzCUkiCrtm-=q_YNbYFERZ9oakiF=goNVNuQRsRw@mail.gmail.com>
Subject: =?UTF-8?B?5bqGNOS6v+S6uuS4iemAgA==?=
To: linux-erofs@lists.ozlabs.org, fenglinyushu@163.com, zqc007@gmail.com, 
	waihoho@cityu.edu.hk, admissions@tyk.edu.hk
Content-Type: multipart/alternative; boundary="000000000000e0348f060fa74e6f"
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

--000000000000e0348f060fa74e6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

5L2g5aW9IQ0KDQrmtLvliqjotJ/otKPkurrmsZ/luIbooajnpLrvvIzmtLvliqjnmoTnm67nmoTm
mK/mioo05Lq/5Lit5Zu95ZCM6IOe6YCA5Ye65Lit5YWx57uE57uH55qE5raI5oGv5ZGK6K+J5Yqg
5ou/5aSn5Lq677yM5ZG85ZCB5Yqg5ou/5aSn5ZCE5peP6KOU5Lq65rCR44CB54m55Yir5piv5Yqg
5ou/5aSn5Y2O5Lq677yM6K6k5riF5Lit5YWx5pys6LSo77yM6ISx56a75Lit5YWx77yM5Li66Ieq
5bex6YCJ5oup576O5aW955qE5pyq5p2l44CCDQoNCuWFseS6p+S4u+S5ieWNseWus+S4lueVjOS4
gOS4quWkmuS4lue6qu+8jOS4reWFsee9quaBtua7oeebiO+8jOe7meS4reWbveS6uumAoOaIkOS6
huiLpumavuOAgg0K5LuK5aSp55qE5b2i5Yq/5bey5aSn5bmF6YCG6L2s77yM5Lit5Zu95YWx5Lqn
5YWa5bey57uP6LWw5Yiw56m36YCU5pyr6Lev77yM5bSp5rqD5oyH5pel5Y+v5b6F44CCNOS6v+S4
reWNjuWEv+Wls+iupOa4heS6huS4reWFseeahOmCquaBtu+8jOS6huino+S6huecn+ebuO+8jOmA
ieaLqeS6huaKm+W8g+S4reWFse+8jOmAieaLqeS6huWFieaYjue+juWlveeahOacquadpeOAgg0K
5b+F5bCG57uZ5Lit5Zu956S+5Lya5bim5p2l56ev5p6B55qE5Y+Y5YyW44CCIDTkur/kuK3lm73k
urrkuInpgIDvvIzmraPmmK8yM+W5tOWPjei/q+Wus+S4reWIm+mAoOeahOaXoOaVsOS6uumXtOWl
h+i/ueS5i+S4gOOAguKAnQ0KDQrmmJPok4nlkbzlkIHmm7TlpJrnmoTljY7kurrlsL3lv6vlhazl
vIDpgIDlh7rkuK3lhbHlhZrlm6LpmJ/vvIzlnKjljoblj7LnmoTlhbPplK7ml7bliLvpgInmi6nk
vKDnu5/jgIHlloToia/vvIzmirnljrvlhb3ljbDvvIzoh6rmiJHmi6/mlZHjgIINCuWlueebuOS/
oe+8jOS6v+S4h+S4reWbveawkeS8l+enr+aegeWPguS4juaOqOWKqOeahOmAgOWFmuWkp+a9ru+8
jOato+WcqOWSjOW5s+ino+S9k+S4reWFsee9quaBtuaUv+adg++8jOato+WcqOW8gOWIm+WOhuWP
suOAgeW8gOWIm+acquadpeOAgeW8gOWIm+S4gOS4quayoeacieWFseS6p+WFmueahOaWsOS4reWb
veOAgg0K5Y6G57uP5Yqr6Zq+55qE5Lit5Y2O5aSn5Zyw77yM5b+F5bCG6L+O5p2l576O5aW955qE
5paw44CCDQoNCuiuqeaIkeS7rOadpeeci+eci+S4gOS4i+i/meevh+iuuuaWh+WIsOW6leWGmeS6
huS7gOS5iOOAgg0K5LqG6Kej5pu05aSa77yM6K+355yL6ZmE5Lu244CCDQoNCuelneS9oOW5s+Wu
ie+8gQ0K
--000000000000e0348f060fa74e6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+5L2g5aW9ITxkaXY+PGJyPjwvZGl2PjxkaXY+5rS75Yqo6LSf6LSj5Lq6
5rGf5biG6KGo56S677yM5rS75Yqo55qE55uu55qE5piv5oqKNOS6v+S4reWbveWQjOiDnumAgOWH
uuS4reWFsee7hOe7h+eahOa2iOaBr+WRiuivieWKoOaLv+Wkp+S6uu+8jOWRvOWQgeWKoOaLv+Wk
p+WQhOaXj+ijlOS6uuawkeOAgeeJueWIq+aYr+WKoOaLv+Wkp+WNjuS6uu+8jOiupOa4heS4reWF
seacrOi0qO+8jOiEseemu+S4reWFse+8jOS4uuiHquW3semAieaLqee+juWlveeahOacquadpeOA
gsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7lhbHkuqfkuLvkuYnljbHlrrPkuJbnlYzkuIDk
uKrlpJrkuJbnuqrvvIzkuK3lhbHnvarmgbbmu6Hnm4jvvIznu5nkuK3lm73kurrpgKDmiJDkuobo
i6bpmr7jgIIg5LuK5aSp55qE5b2i5Yq/5bey5aSn5bmF6YCG6L2s77yM5Lit5Zu95YWx5Lqn5YWa
5bey57uP6LWw5Yiw56m36YCU5pyr6Lev77yM5bSp5rqD5oyH5pel5Y+v5b6F44CCNOS6v+S4reWN
juWEv+Wls+iupOa4heS6huS4reWFseeahOmCquaBtu+8jOS6huino+S6huecn+ebuO+8jOmAieaL
qeS6huaKm+W8g+S4reWFse+8jOmAieaLqeS6huWFieaYjue+juWlveeahOacquadpeOAgsKgIOW/
heWwhue7meS4reWbveekvuS8muW4puadpeenr+aegeeahOWPmOWMluOAgiA05Lq/5Lit5Zu95Lq6
5LiJ6YCA77yM5q2j5pivMjPlubTlj43ov6vlrrPkuK3liJvpgKDnmoTml6DmlbDkurrpl7TlpYfo
v7nkuYvkuIDjgILigJ3CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+5piT6JOJ5ZG85ZCB5pu0
5aSa55qE5Y2O5Lq65bC95b+r5YWs5byA6YCA5Ye65Lit5YWx5YWa5Zui6Zif77yM5Zyo5Y6G5Y+y
55qE5YWz6ZSu5pe25Yi76YCJ5oup5Lyg57uf44CB5ZaE6Imv77yM5oq55Y675YW95Y2w77yM6Ieq
5oiR5ouv5pWR44CCIOWlueebuOS/oe+8jOS6v+S4h+S4reWbveawkeS8l+enr+aegeWPguS4juaO
qOWKqOeahOmAgOWFmuWkp+a9ru+8jOato+WcqOWSjOW5s+ino+S9k+S4reWFsee9quaBtuaUv+ad
g++8jOato+WcqOW8gOWIm+WOhuWPsuOAgeW8gOWIm+acquadpeOAgeW8gOWIm+S4gOS4quayoeac
ieWFseS6p+WFmueahOaWsOS4reWbveOAgiDljobnu4/liqvpmr7nmoTkuK3ljY7lpKflnLDvvIzl
v4XlsIbov47mnaXnvo7lpb3nmoTmlrDjgILCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+6K6p
5oiR5Lus5p2l55yL55yL5LiA5LiL6L+Z56+H6K665paH5Yiw5bqV5YaZ5LqG5LuA5LmI44CCPC9k
aXY+PGRpdj7kuobop6Pmm7TlpJrvvIzor7fnnIvpmYTku7bjgII8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PuelneS9oOW5s+Wuie+8gcKgwqA8L2Rpdj48L2Rpdj4NCg==
--000000000000e0348f060fa74e6f--
