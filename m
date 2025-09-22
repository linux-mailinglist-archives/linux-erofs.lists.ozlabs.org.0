Return-Path: <linux-erofs+bounces-1053-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358BB8EBD6
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 04:12:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVRSs6bk9z2yr9;
	Mon, 22 Sep 2025 12:12:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758507133;
	cv=none; b=NBhdEWApmeViMZYUzNC3vEI05P1FBXKymoxG3pu0A8sigcc2m4mvM2dvciCdIBqlSnbQ715xb2qJwZHCqWRUDGtQrP2Gxh+/YeGnfp1Eyyhj8gn9xfkAS/gFOSlqeQPze5Nu3jD6wkOPNTB8MrZqOUZzQE5AYwawtBxyOHuxaxn+CUTYSRIqGVoNAZbqVu93Ablg5+Ii+rVwRi1QYIcnHUiwUfKt/Pc0bcEG3FKCJnntpJYK8u0v5Ve8RjvxOegrz8LuwDbziyXBu55ZeN62EJ9e6Unqd/tJCsxA/hp4aJD/UWHximlKvCxV+0jESnvoIYgU7yAV5f8AYZzoVCRlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758507133; c=relaxed/relaxed;
	bh=YvWoh1NPeyc+hKw8myW6orVL2LUSq6scIjXIGMLNMeM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h2fw224/h7O/LF0d7MKyup/k1ZG9VCG+394i+UB1QqWuWxxawVCCwp4G3/enben/vDPbWMXVkDuJvpmQ9R/WzmFThqkXw6uDKkfqHNxqLyqzDQWYXmxNQkn4OTktaoSCsRmqQqrKPZXVWggXwsVJS9p5uYOAuQck7pPan67xJ8sHRFnlaLuMefiJMWZFMK2nQYGlUMKaHNI0sAk8Y437AZ1X+9YmXDqWPhIwdRQGSsF4Y6hU+D8o6LzlumjhjGm2OI+jV7sjL2OTNNn/V8cM4tppYViPGhDY/YTlrPer10ouAT7P7BchlLRKtq0RxggycqNIz339N8fIzLnPERPQDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jnfsfZmL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a42; helo=mail-vk1-xa42.google.com; envelope-from=everleighflore262@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jnfsfZmL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a42; helo=mail-vk1-xa42.google.com; envelope-from=everleighflore262@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVRSr0q1Dz2xQ3
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Sep 2025 12:12:11 +1000 (AEST)
Received: by mail-vk1-xa42.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso554518e0c.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Sep 2025 19:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758507128; x=1759111928; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvWoh1NPeyc+hKw8myW6orVL2LUSq6scIjXIGMLNMeM=;
        b=jnfsfZmLK8FCUtz2HiNFF2zcxpLhAEB9QzmNZtkQ3WJ3mLwuUpX45K/tjI3MGj9Z7f
         8Wxk7Ze/0MyvOM7UaVzITPof4Jg7IoLHW3QmaH4rtZ6I0LDZlLgz4qn2cqVxiAwuln0r
         ZQObOZX6k37siSQwwQJ2Op7F43PUp6lg6BJgnQH3IF2Mw7aqohFuFobqPqYHwv8TfgWU
         Ka50B4Gv9FxCr6RR7GuI37MeUIpZUutL/SWs/17iXP7GQskjK6Lh+2YfTXZ3wNHKo15+
         n9hGiZvGm+w5uwT5VcBhT1VJ7JFOaLFHnDqQKobHNsuJgLKGadm0YEt3dcwNW/oCDBYe
         cEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507128; x=1759111928;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvWoh1NPeyc+hKw8myW6orVL2LUSq6scIjXIGMLNMeM=;
        b=wKwCC9eRoj2IzsogIJ+JeUckWBPSkZxA5r3OtwCxxDBOMFaJYKJmo1Y7ogomMTXvO5
         YSene/Gg3LGAG42i7k1oXgVJANdQloORB5jzfzFhuEHV1l61gq/JBVoUENSajAzdbj/X
         dGLEkQXMFzzNjpoh+SngH9MJZ+9mP1cJoqUEmPGR2InBYAYilbvWQpDNSrKymh8Dv4i+
         vlJU7PcSiH81xeJyjzhytt1/iz8rk+ZNpAx9Gr1s04Fmsiv3PeTLkHzoHpgQzZmHlxaI
         8ILTDQaGpYbOC6N4kQcsOEaIaDK6FJtIDwANWLVBULSJdlIkz/WTEoE3FHulIyL/pNSM
         oziw==
X-Forwarded-Encrypted: i=1; AJvYcCU7359b2D0uP61rWLvM5f8yjEyvNQI8fyCR2TioPhI8D0SGXv210RSD7JwQy5Xg4xN5WS0OMYY8U833Tg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YybWZRJnaFYnCIzrVIXDZl2qfpXWZI1UU4JkU1v9cteUwK0SZn8
	hahZT3ATKhjfsfqt402aNu6087dVE4E+sHdbNsJCoLRuiG2YtvkHKl6wWvfqBbhsnMxH4aafP0M
	QpdX7tdBEDjq5jlVXZk/FMy37Sr/x6y0=
X-Gm-Gg: ASbGnctcd7Dsp9mhK3BwCc2I6uTexbOSEHqn1dSoEBNLW+XlsNs2+1rRvGFBt565uT6
	MaonxOhxRahgv3aOYjOQNq6JQgzAZba2MBD1btXD7J684sqKFVhj9kTeTpSF/nFu1A8vfVtwE53
	XvTLoSwtxhfBO67dFjh5FleUyd8xxF08a6UdlgpbIN8XBKB6wkAlvbMU3cX/lwyLJ62IZXVu0K2
	Xn/wXA/5r17PN2DRZZY8R5cWoxZ84Bta582V4RJCqbjnkUkkx5v1jMCU7VZOdLHPmQCb9Mvw5+r
	ulu4L4599Sls
X-Google-Smtp-Source: AGHT+IHKoG7g6Rcvk/AYqI5UUZi526FKsWl/z+zfDvKINv6CJCoepToT3SixYNHlXic+dGFyZKOtqEoXwYbxYgCizZc=
X-Received: by 2002:a05:6122:1ad5:b0:54a:1ec6:b1ab with SMTP id
 71dfb90a1353d-54a8358eba3mr3707563e0c.0.1758507128561; Sun, 21 Sep 2025
 19:12:08 -0700 (PDT)
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
From: Eva Jiang <everleighflore262@gmail.com>
Date: Mon, 22 Sep 2025 09:11:57 +0700
X-Gm-Features: AS18NWCi2B3IHyE8EJmtauJGpG-FSIeJycqTQppLZl5h6u7BtVGiDd09-tJai-8
Message-ID: <CAFLe3a+h+QQ7a3Oi3ve8wjWir_tB86gJAiLH-oZvo7X6_yM8fw@mail.gmail.com>
Subject: =?UTF-8?B?57u05LuW5ZG9ReaXoOWKqemYsueZjOOAgOacjeeUqOi/h+mHj+aBkOiHtOW/g+iEj+ihsA==?=
	=?UTF-8?B?56ut?=
To: 2570304068@qq.com, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000bba351063f5a5897"
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--000000000000bba351063f5a5897
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuS9oOWPr+efpemBk++8jOe7tOS7luWRvUXkuI3og73pooTpmLLlv4PohI/o
obDnq60g5Y+N5aKe6aOO6ZmpIO+8nw0KDQrnoJTnqbbkurrlkZjpkojlr7nmlbDljYPlkI3lv4Po
hI/nl4XkuI7ns5blsL/nl4XmgqPov5vooYzkuLrmnJ/kuIPlubTnmoTnoJTnqbblkI7lj5HnjrDv
vIznu7Tku5blkb1F5LiN5LuF5LiN6IO96aKE6Ziy5b+D6ISP55eF5LiO55mM55eH77yM5Y+N5YCS
5Y+v6IO95aKe5Yqg5b+D6ISP6KGw56ut55qE5Y2x6Zmp44CCDQoNCuWcqOaJgOacieaOpeWPl+a1
i+ivleeahOW/l+aEv+S6uuWjq+S4re+8jOacjeeUqOe7tOS7luWRve+8peiAhe+8jOW/g+iEj+eX
heWPkeS9nOeOh+i+g+acjeeUqOWuieaFsOWJguiAhemrmOWHuueZvuWIhuS5i+WNgeS4ieOAguac
jeeUqOe7tOS7luWRve+8peWvvOiHtOeahOW/g+iEj+eXheWkp+WkmuaYr+W3puW/g+WupOWkseWO
u+WKn+iDveOAgg0KDQrngrnlh7vmn6XnnIvmm7TlpJrvvIzkuI3opoHplJnov4fku7vkvZXph43o
poHkv6Hmga/vvIENCg0KaHR0cHM6Ly9zaW1wbGV1cmwubGluay93ZWlzaGVuZ3N1LUUtZGFvemhp
LXhpbmxpLXNodWFpamllDQoNCuelneS9oOW5s+Wuie+8gQ0KDQotLS0NCg0K5Y6G5Y+y5Lya6ZOt
6K6w77yM5q2j5LmJ5rC45LiN5rKJ6buYDQo=
--000000000000bba351063f5a5897
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1z
aXplOm1lZGl1bSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9wPjxwIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPuS9oOWPr+efpemBk++8jOe7tOS7
luWRvUXkuI3og73pooTpmLLlv4PohI/oobDnq63jgIDlj43lop7po47pmakg77yfPC9wPjxwIGNs
YXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29m
dCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPueglOeptuS6
uuWRmOmSiOWvueaVsOWNg+WQjeW/g+iEj+eXheS4juezluWwv+eXheaCo+i/m+ihjOS4uuacn+S4
g+W5tOeahOeglOeptuWQjuWPkeeOsO+8jOe7tOS7luWRvUXkuI3ku4XkuI3og73pooTpmLLlv4Po
hI/nl4XkuI7nmYznl4fvvIzlj43lgJLlj6/og73lop7liqDlv4PohI/oobDnq63nmoTljbHpmanj
gII8L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1
b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1zaXplOm1lZGl1
bSI+5Zyo5omA5pyJ5o6l5Y+X5rWL6K+V55qE5b+X5oS/5Lq65aOr5Lit77yM5pyN55So57u05LuW
5ZG977yl6ICF77yM5b+D6ISP55eF5Y+R5L2c546H6L6D5pyN55So5a6J5oWw5YmC6ICF6auY5Ye6
55m+5YiG5LmL5Y2B5LiJ44CC5pyN55So57u05LuW5ZG977yl5a+86Ie055qE5b+D6ISP55eF5aSn
5aSa5piv5bem5b+D5a6k5aSx5Y675Yqf6IO944CCPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0
eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xv
cjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPueCueWHu+afpeeci+abtOWkmu+8jOS4jeim
gemUmei/h+S7u+S9lemHjeimgeS/oeaBr++8gTwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHls
ZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6
cmdiKDAsMCwwKTtmb250LXNpemU6bWVkaXVtIj48YSBocmVmPSJodHRwczovL3NpbXBsZXVybC5s
aW5rL3dlaXNoZW5nc3UtRS1kYW96aGkteGlubGktc2h1YWlqaWUiIHRhcmdldD0iX2JsYW5rIj5o
dHRwczovL3NpbXBsZXVybC5saW5rL3dlaXNoZW5nc3UtRS1kYW96aGkteGlubGktc2h1YWlqaWU8
L2E+PC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZx
dW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRp
dW0iPuelneS9oOW5s+Wuie+8gTwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTkiIHN0eWxl
PSJmb250LXNpemU6MTEuNXB0O2NvbG9yOnJnYig5MSwxMDIsMTE2KSI+LS0tPC9wPjxwIGNsYXNz
PSJnbWFpbC1hdXRvLXN0eWxlMTQiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQg
WWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMTIzLDI1NSk7Zm9udC1zaXplOm1lZGl1bSI+5Y6G5Y+y
5Lya6ZOt6K6w77yM5q2j5LmJ5rC45LiN5rKJ6buYPC9wPjwvZGl2Pg0K
--000000000000bba351063f5a5897--

