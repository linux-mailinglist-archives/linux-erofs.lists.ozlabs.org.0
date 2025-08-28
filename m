Return-Path: <linux-erofs+bounces-931-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F009B39242
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Aug 2025 05:37:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cC6YK0RXwz3bb6;
	Thu, 28 Aug 2025 13:37:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::643"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756352277;
	cv=none; b=CuAnyto0f0H89o/XPzBpnpZySn94cdg3AmfYf9WOcwOsiKxR3gqOmqlImD7PAUJKDg61q5m+gZhJuIu6K81qKtCzbNtJF03LmDtTa45R1vV58103VI1xSEAQYm5tqGMqhD/BBs38CuN3R4kYCe5dKMztEvyGhBSr94QklAZI/KuRHm+z0vyAR6HmLY8VrOsCGTziBCdY88wDk5/bBH31SEyGTWq73LumY77EmWL9rftSsvopogCE/aZAr82wviUJKlvYjV6n0LPfD2tWl/o5OGxStVDbTmFRffigjCZLDlkwuQC5FzxI3RTSBeu5EtvgMpSv3UNF1qfFPbcYMRsRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756352277; c=relaxed/relaxed;
	bh=wH7zBLjFVA+Wb7nNt69njV/7Ijxr3EmiArgieMb6HcA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RM8pD7FYD5ujQY8g+K5wtCFUK2xdJsgTIJOBrKHysOf+49koV7n3Ktuar9ZRivJSmKlKHNGXo/wLGGKL9PjK4HtOIuHfp0blAFgxw/Ew36dXgWBid8jJ1+hXhEmfXXi+XaeAbLep0umQ6eunifILTnPuvVuul5ogjH9YXVfIRog4BnFsqcuLlWsAXKtuxwrS+L5h+l8Rgz45fB4PR+YaA55YEJW+7KX6MZd685qclqDWgfuh6WEsI2H8bne/z6/LK/KcWWHiHNpTNjkGDkwvYiP2Y1si46JG4N3QFZqQ2IsJ7x17fOj8WptyjvZT4tPhPfEkUmFnZSYpGZiqsPOUww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e5SOMEvp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=lilidayan996@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e5SOMEvp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=lilidayan996@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cC6YH41lgz30WS
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 13:37:55 +1000 (AEST)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so61168266b.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756352271; x=1756957071; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wH7zBLjFVA+Wb7nNt69njV/7Ijxr3EmiArgieMb6HcA=;
        b=e5SOMEvpb+4dpnoHSqjpNAdrxMJ3Jz24jJHr2UaVlVvYvCbXQZUaK3qpQ329l9VKM3
         cbijioOFfIs7i1v9YvZ1zNq2m7ONQlU6jzVZYaE1zVuFFQDj6OC1MrXxHJNg02afNut3
         v+Fk1RPjhL1NiTIv8WbvXneU1sj/MncZsUth5lqiAcDcWZ+OVaGPrkHndxLOV3z7Yhdf
         4rPQz5xqHdr+NsHU8XeqqE+6IxCfA1bG0LQAK8fzRW2owL/2j/6OGG2qTcV+lISeON6p
         iQOoB6o/GMdjhIgfJUycMO2DDEA7eoIWgDepU4SHlMBEW0+yjFW9sUSwNATxpon4qaky
         ejsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756352271; x=1756957071;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wH7zBLjFVA+Wb7nNt69njV/7Ijxr3EmiArgieMb6HcA=;
        b=NAWgISjmGxL9DBwvw5NTI9uFg+AEJuTKADLD8g2awDcEppFHCWA0C5nKphBrQVgjKb
         zJVa1Qox18MEq4hDcgQk9uyPBK8XI9zJjIih/r5GJvuS6HvHcymTZVG4zHy+e+XF7p5A
         2dVfFb+csK1XoVfZIFTFdDfmf7m1Jv7qzVPH4GcKs23gtccUP2JAW/Uk6HwJHI5IRB3/
         tFKafH1j0Oz5hpnxsaJ9hH0tzToU+f2nAMX9RAGV2FNLvUad5v8Mw5AbPVU0QACCfUO7
         bQjGlzAm/4MXPYqbHebZgWAeRvCC8IRDkfsDyzox7NycFCn5NE+gMBs4t04vw+wFsaFr
         DfWQ==
X-Gm-Message-State: AOJu0Yy5FUA+L2ImV8TX4Z68OUl+mGYW5Ph6r8IhD+UYRf8/ZVzFDDa7
	DQpHbA06lX0f6cc6Fdr2Q5h8WhafYQABlsrhLHOvrePMaarNNL1XfY4I1T1wEG+WzDJ3w1yd0Ot
	JSGi5rl6RSejnJhRkvqWPtR+kAfhiFSd2g1nsgiU=
X-Gm-Gg: ASbGncvFBjOdfit5Ij/aJqISvnhoi9xcpFMr1XudzMmrf6bKaiB52LGU0w5aPERJswP
	r8+fczKcmqGZcx/hPk9cFxGfkNNaDDtb9gHq8olTPsRFXEZ5J425Ghc4EeN1yNKIPWx5mqVW2ZU
	QA2h9ULHyPFVsrnHIjxr3+JZRb/DcttLs/psP/qRdMop2NqIewCblB98V8p1tIjf3QlCZKzwIxv
	tumdQAx1p7IxlpOBG2cOfPXGcVMMvHGW+uHaI8vZgwzIzxTxxixMY3KLhn1nGfz8lQt5rvZhbQX
	d2l9AiVwWY4WDRs5lhzlk0O+3u7+PoMECbc7kpc6rV1pYxqwJrEGBwcS56wtr6AvdQ7VcvfvpJh
	Jw+rOpJaZa2GyMNe5knRwDmlQNDW1kQ==
X-Google-Smtp-Source: AGHT+IFo8ULnJfZIRYSLiA6fnhkiccmJ+wJCLrgezVLJi7d7VbeoT+DNCNF4eEOclLJcJegOF8dN67UVD5Bu95LjsZ4=
X-Received: by 2002:a17:907:3ea7:b0:afe:bb6d:1caf with SMTP id
 a640c23a62f3a-afebb6d3f4dmr426273966b.62.1756352270590; Wed, 27 Aug 2025
 20:37:50 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: Lili Dang <lilidayan996@gmail.com>
Date: Thu, 28 Aug 2025 10:37:39 +0700
X-Gm-Features: Ac12FXzsw8SLxbSp3P1VDXeGdA371J-tXGf-Jd7jxpW3P9w4Vuvrn4lRGNfNNrs
Message-ID: <CACPx4JkRc4DPZOKJVL=ipPEHOFG237HonBc22xBSSySgDdfKMg@mail.gmail.com>
Subject: =?UTF-8?B?5qmY5a2Q5oqk6IKg5aKe5YWN55ar?=
To: linux-erofs@lists.ozlabs.org, soz.ethik@kaththeol.lmu.de, inaba@uchc.edu, 
	179308871@qq.com, wangm@xust.edu.cn
Content-Type: multipart/alternative; boundary="000000000000306d9a063d64a149"
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_PHISH
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--000000000000306d9a063d64a149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuapmeWtkOWQq+acieW+iOWkmuiQpeWFu+aIkOWIhu+8jOS9huaYr+W+iOWk
muS6uuWcqOWQg+eahOaXtuWAmemDveacieaKiueZveiJsue6pOe7tOaSleS4i+adpeeahOS5oOaD
r+OAgg0KDQrkuZDmnY7kvK/otKTljZrlo6vop6Pph4ror7TvvIzov5nnp43ooqvnp7DkuLrigJzm
qZnnmq7igJ3nmoTnmb3oibLnuqTnu7Tlr4zlkKvmqZnnmq7nlJnvvIzlhbfmnInmnoHpq5jnmoTo
kKXlhbvku7flgLzjgIINCg0K5a6D5Lus5Y+v5Lul6Ziy5q2i5rCn5YyW77yM5L+d5oqk57uG6IOe
5YGl5bq377yb5Y+v5Lul5oqX54KO77yM5YeP6L275oWi5oCn54KO55eH77yb6L+Y5Y+v5Lul5pS5
5ZaE6KGA566h5YGl5bq377yM5aKe5Yqg5b6u6KGA566h5by55oCn77yM5pyJ5Yqp5LqO6ZmN5L2O
6KGA5Y6L44CCDQoNCui/meS6m+S/oeaBr+WNgeWIhuePjei0te+8jOivt+WKoeW/heafpeeci+Wu
jOaVtOWGheWuue+8gQ0KDQpodHRwczovL3VybDEuaW8vanUtemktaHUtY2hhbmctemVuZy1taWFu
LXlpDQoNCuelneS9oOWSjOS9oOeahOWutuS6uuWlvei/kO+8gQ0KDQotLS0NCg0K5q+P5LiA5Lu9
55yf55CG6YO95YC85b6X6KKr5o2N5Y2r77yM5q+P5LiA5Lu95YWs5q2j6YO95YC85b6X6KKr6L+9
5rGC44CCDQo=
--000000000000306d9a063d64a149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7Zm9udC1mYW1pbHk6JnF1
b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW0iPjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzdHJvbmc+5L2g5aW9ITwv
c3Ryb25nPjwvc3Bhbj48L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9u
dC1zaXplOm1lZGl1bSI+5qmZ5a2Q5ZCr5pyJ5b6I5aSa6JCl5YW75oiQ5YiG77yM5L2G5piv5b6I
5aSa5Lq65Zyo5ZCD55qE5pe25YCZ6YO95pyJ5oqK55m96Imy57qk57u05pKV5LiL5p2l55qE5Lmg
5oOv44CCPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5
OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTpt
ZWRpdW0iPuS5kOadjuS8r+i0pOWNmuWjq+ino+mHiuivtO+8jOi/meenjeiiq+ensOS4uuKAnOap
meearuKAneeahOeZveiJsue6pOe7tOWvjOWQq+apmeearueUme+8jOWFt+acieaegemrmOeahOiQ
peWFu+S7t+WAvOOAgjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250
LXNpemU6bWVkaXVtIj7lroPku6zlj6/ku6XpmLLmraLmsKfljJbvvIzkv53miqTnu4bog57lgaXl
urfvvJvlj6/ku6Xmipfngo7vvIzlh4/ovbvmhaLmgKfngo7nl4fvvJvov5jlj6/ku6XmlLnlloTo
oYDnrqHlgaXlurfvvIzlop7liqDlvq7ooYDnrqHlvLnmgKfvvIzmnInliqnkuo7pmY3kvY7ooYDl
jovjgII8L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUyIiBzdHlsZT0iY29sb3I6cmdiKDAs
MCwwKTtmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1l
ZGl1bSI+6L+Z5Lqb5L+h5oGv5Y2B5YiG54+N6LS177yM6K+35Yqh5b+F5p+l55yL5a6M5pW05YaF
5a6577yBPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZvbnQtZmFtaWx5
OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTpt
ZWRpdW0iPjxhIGhyZWY9Imh0dHBzOi8vdXJsMS5pby9qdS16aS1odS1jaGFuZy16ZW5nLW1pYW4t
eWkiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3VybDEuaW8vanUtemktaHUtY2hhbmctemVuZy1t
aWFuLXlpPC9hPjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTIiIHN0eWxlPSJjb2xvcjpy
Z2IoMCwwLDApO2ZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250LXNp
emU6bWVkaXVtIj7npZ3kvaDlkozkvaDnmoTlrrbkurrlpb3ov5DvvIE8L3A+PHAgY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGU5IiBzdHlsZT0iZm9udC1zaXplOjExLjVwdDtjb2xvcjpyZ2IoOTEsMTAy
LDExNikiPi0tLTwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTE0IiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDEyMywyNTUpO2Zv
bnQtc2l6ZTptZWRpdW0iPuavj+S4gOS7veecn+eQhumDveWAvOW+l+iiq+aNjeWNq++8jOavj+S4
gOS7veWFrOato+mDveWAvOW+l+iiq+i/veaxguOAgjwvcD48L2Rpdj4NCg==
--000000000000306d9a063d64a149--

