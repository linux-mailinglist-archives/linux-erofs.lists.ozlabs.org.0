Return-Path: <linux-erofs+bounces-774-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F05FB1BFBC
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 07:02:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxdTR1CRcz3bkb;
	Wed,  6 Aug 2025 15:02:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::641"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754456571;
	cv=none; b=RorOsNwF5utj6yv0njLkFUbns2X3QXufx9kcjxQ6HEfzKVQwndG3Xcya13w6KHouiIi+RsfjDN3jrxkntizxqd2IHE1MBxYpym0e+O9mdjlyy/WJ8fpX4Avwi2qpW+jf7vFECYBRjkXQB5gypyWCbPCxxouKOEyYxrQSZuzu1k1SZKZ+YkEy+iS/7adJ7k+RmBgVXK7H3yMSiqEh1DwwJjIki7ABUH0A7I+k6GmQt//UuebRw3vJAIInOWaOfbhj+7Nv+wGsL6aHTkLuvBl9U5UFJ4oVc5p1CD9U0DV/APiNvaUqxQwcVuXPaBqmS0HYyk3mmx3EA5LjIja8XFd8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754456571; c=relaxed/relaxed;
	bh=XK3SVrirPH8tf0uRp6axg6iYa0NmOqWwVJm2uxQQwuQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ds47wv0B/XeCkCjS4ykkO5LlFoVd15IxhEd3lQSMrx3pfjEa3rPx6w/4WraC8H0sPf727LjcLRMyowcdpkkwen1Ubbp2vKM7M8whCJMCqJHz6+8IWmAIHcPvqF27y+8o8giAGjUXl/8/LHk3eexN3kCfVZoIN+6oBnu9loeD8LfIxt2edCXRItBa78nmjbbsNb18WsCaOmqTcy4VlXv8N6CVVVu7IzuKddCHhq6uNws6m4v01lkgU+xbYIRhNrWGiflqUvFqboJbUtySze1Dy66yXQDOmYll9z61IRcGjHQ0c/R3uTmPpDLG4dsIEDIGiaYWq+73zgClHrF8kdsEHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JDW6vGex; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=nguyenhuuphuc18382@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JDW6vGex;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=nguyenhuuphuc18382@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxdTQ0f6xz2xck
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Aug 2025 15:02:49 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-240b3335c20so39252225ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 05 Aug 2025 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754456566; x=1755061366; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XK3SVrirPH8tf0uRp6axg6iYa0NmOqWwVJm2uxQQwuQ=;
        b=JDW6vGexQB13iAJKDqZJd0V/VpBLTbSRKkfpZiMBI8O+k9fjGyTBN1jUgjL795DGra
         xbK3eeW0HTqIBbl3JXYydcAS6Pyg3G6duGvOp3pCJJUK+rLq4pXXS0Mo60pWiCZOQS6U
         zRiv5Z4vbNhmuV0vr/HJpGBOr+crryqABHt6xci/4a+pZsMUX9n7VUuNoBEMNIXWlV+m
         kNc1n440TnK1CRcgmA8x6reztK8K+oG2uQg2FPAo1n/KLtg4QNfMZMWk8zIS4Slkw3LZ
         b+Ip4S+Br2gQJ3iXus28ivOMhaFeGDyurFMyp+YqKgP08P9p0LJAdDTg8NXPP6S8wJAF
         Cm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456566; x=1755061366;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XK3SVrirPH8tf0uRp6axg6iYa0NmOqWwVJm2uxQQwuQ=;
        b=cxai7v9kNGyEdu8JNXMashc4O4+0ik2Kz3P0KmON2DATwotTsk4oPmiRYPla8PRC4t
         nXFBz4JuwW8TkPZnTvAG8XLC5S4UckCyEKSRzkF/9deggz47F17+4FjZ4VCRDaR74T/l
         bbCN/V9sdQgQE9m0IHrrI6u4akUXQkfT6GySo/QC5zs+bES1H5CjpoGdNR9TMWf5f30e
         qikhtX/pvIBbLpdmTEG5d449mPZs426DL/Zmgqr0wHlae7/HwYVeMIx/GRQ4FUasnHMt
         wwOdBMQyNR8JTv5CdL43/+smmsIVO5OSpizjHuaTeeYuqtbP6Z9c5f0ItVx/bhYsMnxo
         UiPw==
X-Forwarded-Encrypted: i=1; AJvYcCW7BoTarvpYZ059ZYcUKDZcBAao1ebPxnrodH2h/VOejg49TR4W20yDj7KvOTMKFDQfSeCfX1OUN3jASA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMeNqOZ4m+Ug4KpsVr1qg/FhCr3tItI2Zlq88K6+WBqjPEomKy
	tc9+rwyrjVDKY1f2OLL5pklkwWuBeAl55+jgFtm86VPOXoz0a6/N2W3RhRL8+BjMQhxQBhYe1tz
	KRNknrpYRE0tdU1Y59dI0D/6QUh/HY+c=
X-Gm-Gg: ASbGncvpMO6xHmoS3IgUnuR1zbQxr9tOU7ojCnOrVdeByOAzufidg9IoL51vPxJX/MG
	ejMKNQVT4aomCwPuy4RK7V1Z20syC2TaiPBR0LPZ93hUFehnCZcn1Zvrk4ztm24UmrmdWy10pwM
	5uztUlQyeFTmwf/czNZXMTnvoIuqN+GOi0tjfZhKEkyPYXYxXdJBXYAnorWVBTiKv3Eh7s1p5bF
	jSnEx3XXna0
X-Google-Smtp-Source: AGHT+IGIAFVhft8eQvVc5XtGmHoo6xKFmm12Gdn8s9KCQp+Xqp8MuX/zjvvsLl2v1n5dDkeuP9oDKBS/uBL34a5ULSk=
X-Received: by 2002:a17:903:2cf:b0:240:71ad:a454 with SMTP id
 d9443c01a7336-2429f2d9e92mr26253865ad.1.1754456565429; Tue, 05 Aug 2025
 22:02:45 -0700 (PDT)
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
From: Zheng Liwei <nguyenhuuphuc18382@gmail.com>
Date: Wed, 6 Aug 2025 12:02:33 +0700
X-Gm-Features: Ac12FXxXEih45l52A9Rod0yGz3npnxnHsc59h51wnS5x1w1agzMYxyasCnh_0mk
Message-ID: <CABMqX3inod8vrgR9_m_L+2DbDT1AqOhCYLKjO=a5v-K-u10rDQ@mail.gmail.com>
Subject: =?UTF-8?B?6IK+6ISP5b6I5oCV6L+ZNuenjemjn+eJqSDopoHnn6XpgZPkvKTogr415Liq5Z2P5Lmg?=
	=?UTF-8?B?5oOv?=
To: hftu@nju.edu.cn, 42798555@qq.com, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000005b3a64063bab4055"
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_PHISH
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--0000000000005b3a64063bab4055
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCui2hei/h+S5neaIkOeahOi9u+W6puiCvuiEj+eXheaCo+iAheS4jeefpemB
k+iHquW3seiCvuiEj+aciemXrumimO+8jOeUmuiHs+iCvuiEj+WKn+iDveS4p+Wksei/h+WNiu+8
jOWkmuaVsOS6uuS7jea1keeEtuS4jeinieOAguiCvuiEj+eWvueXhemAmuW4uOWIsOaZmuacn+aJ
jeWHuueOsOaYjuaYvueXh+eKtu+8jOWboOatpOiiq+ensOS4uuKAnOayiem7mOeahOadgOaJi+KA
neOAgg0KDQrkvaDlj6/nn6XpgZPvvIzogr7ohI/lvojmgJXnmoQ256eN6aOf54mp77yM5b6I5aSa
5Lq65Yeg5LmO5aSp5aSp6YO95ZCD77yM5L2G5Y205LiN55+l6YGT5a6D5bey5Y2x5a6z5Yiw5YGl
5bq344CCDQoNCuS4gOOAgemrmOebkOmjn+eJqQ0K5LqM44CB6auY57OW6aWu6aOfDQrkuInjgIHl
pKfph4/mkYTlhaXpq5jojYnphbjpo5/niakNCi4uLg0KDQrngrnlh7vmn6XnnIvmm7TlpJrvvIzk
uI3opoHplJnov4fku7vkvZXph43opoHkv6Hmga/vvIENCg0KaHR0cHM6Ly91cmwxLmlvL3NoZW56
YW5nLWhlbi1wYS02LXNoaXd1DQoNCuelneS9oOS4h+S6i+WmguaEj++8gQ0KDQotLS0NCg0K55yf
55u45pyA57uI5Lya5pi+546w77yM5YWs5LmJ57uI5bCG5a6e546w44CCDQo=
--0000000000005b3a64063bab4055
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7Zm9udC1mYW1pbHk6JnF1
b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW0iPjxzcGFuIGNsYXNzPSJn
bWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90OyI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxiciBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIg
c3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+6LaF6L+H5Lmd
5oiQ55qE6L275bqm6IK+6ISP55eF5oKj6ICF5LiN55+l6YGT6Ieq5bex6IK+6ISP5pyJ6Zeu6aKY
77yM55Sa6Iez6IK+6ISP5Yqf6IO95Lin5aSx6L+H5Y2K77yM5aSa5pWw5Lq65LuN5rWR54S25LiN
6KeJ44CC6IK+6ISP55a+55eF6YCa5bi45Yiw5pma5pyf5omN5Ye6546w5piO5pi+55eH54q277yM
5Zug5q2k6KKr56ew5Li64oCc5rKJ6buY55qE5p2A5omL4oCd44CCPC9zcGFuPjxiciBjbGFzcz0i
Z21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFI
ZWkmcXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWls
eTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0
eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5L2g
5Y+v55+l6YGT77yM6IK+6ISP5b6I5oCV55qENuenjemjn+eJqe+8jOW+iOWkmuS6uuWHoOS5juWk
qeWkqemDveWQg++8jOS9huWNtOS4jeefpemBk+Wug+W3suWNseWus+WIsOWBpeW6t+OAgjwvc3Bh
bj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHls
ZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0i
Z21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFI
ZWkmcXVvdDsiPuS4gOOAgemrmOebkOmjn+eJqTwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8t
c3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48
c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtN
aWNyb3NvZnQgWWFIZWkmcXVvdDsiPuS6jOOAgemrmOezlumlrumjnzwvc3Bhbj48YnIgY2xhc3M9
ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlh
SGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuS4ieOAgeWkp+mHj+aRhOWFpemrmOiN
iemFuOmjn+eJqTwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDsiPi4uLjwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8t
c3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48
c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtN
aWNyb3NvZnQgWWFIZWkmcXVvdDsiPueCueWHu+afpeeci+abtOWkmu+8jOS4jeimgemUmei/h+S7
u+S9lemHjeimgeS/oeaBr++8gTwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBz
dHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9
ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlh
SGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxhIGhyZWY9Imh0dHBzOi8vdXJsMS5p
by9zaGVuemFuZy1oZW4tcGEtNi1zaGl3dSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vdXJsMS5p
by9zaGVuemFuZy1oZW4tcGEtNi1zaGl3dTwvYT48L3NwYW4+PC9wPjxwIHN0eWxlPSJjb2xvcjpy
Z2IoMCwwLDApO2ZvbnQtZmFtaWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90Oztmb250LXNp
emU6bWVkaXVtIj48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuelneS9oOS4h+S6i+WmguaEj++8gTwv
c3Bhbj48L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGU5IiBzdHlsZT0iZm9udC1zaXplOjEx
LjVwdDtjb2xvcjpyZ2IoOTEsMTAyLDExNikiPi0tLTwvcD48cCBzdHlsZT0iY29sb3I6cmdiKDAs
MCwwKTtmb250LWZhbWlseTomcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7Zm9udC1zaXplOm1l
ZGl1bSI+PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48L3NwYW4+PC9wPjxwIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMTQiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDs7Y29sb3I6cmdiKDAsMTIzLDI1NSk7Zm9udC1zaXplOm1lZGl1bSI+55yf55u45pyA57uI5Lya
5pi+546w77yM5YWs5LmJ57uI5bCG5a6e546w44CCPC9wPjwvZGl2Pg0K
--0000000000005b3a64063bab4055--

