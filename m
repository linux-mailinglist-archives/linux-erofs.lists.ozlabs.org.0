Return-Path: <linux-erofs+bounces-123-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BB8A6D938
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Mar 2025 12:35:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLrbG5yHSz2yRd;
	Mon, 24 Mar 2025 22:35:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::941"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742816154;
	cv=none; b=d0xSVRPAz7W8DbUVZAJonRUEzNNX+izNdqATcwQp3zGLGHM0JceE6kYh1de7DSkg3KyIUl/W2qW2cw/h3RlzfVR77g1zDS6rcTVeJWtsoQg5stb5XdvweTQDJh21Gxl1Sh/+43cqdSOg59pMsQIYsSAIDVQNXkBKf8NKghi9VI7YNaMAlWXHUs7AoggWA+nV0x3zQVrdm3aYJHlDG6QYLeK32vDwy3/0X4tWnzHhb0qr+1xO2TAnmLsypabsC54BYvp01GiE7+IO/KS6CEVhIpnPexFQC8Z62Y06909/+PjPpNJUBWDoKOOy1PBur1d8RmirHjarZaEMyLOA4ZxYag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742816154; c=relaxed/relaxed;
	bh=PMjyfayIK85IcJ/sRPcPvbjUEr5mymtFLNhcyvoAlrg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ULB4J/dI+uJonq4X707a+7oUOTAlG2G4HK2M6qX3rBacdfbPM9vSuXn3Q4N16bqjXGuDt29Ugiw8fe/bvjQzCrrzSoE3yeYbL80sbnRIM1/eAvgEy1l5x0gt08xlwCIDztOB0NQeinegGtM1VYKH90zxuK9q9BtecOMNusvcHFD68I2mryzkGPpgEqb16QvZWlmuoBDQ6STVgHrXwXTc6OjEtf3XXZhEMpBauAHU22PmzMZkzTmTnDp0LoMhjneeHJ/5Zq/HoKgvYQPXYyBZQgbHn2FN43GjyQdXy28peyRYVR2wjJceKstb+2b4j88tT9uqMTxA7Fle08hVdAxg1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=W+8/UQeC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com; envelope-from=tbui30920@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=W+8/UQeC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com; envelope-from=tbui30920@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZLrbF0bTRz2y8p
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Mar 2025 22:35:52 +1100 (AEDT)
Received: by mail-ua1-x941.google.com with SMTP id a1e0cc1a2514c-86d75f4e9a1so1755213241.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Mar 2025 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742816150; x=1743420950; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMjyfayIK85IcJ/sRPcPvbjUEr5mymtFLNhcyvoAlrg=;
        b=W+8/UQeCzJgIeOb8OUxpeQRhpkkhSTYLck38eXtBCHhDa/YU12/gty4vvHFFPHqnPQ
         a1XJSsaH95feVhEaiAXR5aRUBh6vh39oY7pf2aVJnnxmknA+P3NhEURKIFtHbYplZ0MQ
         m1JvzS6xb5GEtyW08KeG4zDjtJYwAXi0tywowEluRzoP2B/sm5UyUR3JxYpg8lNB4vF3
         1JJDobpQxjDtm+vgRCzmwyJeO4TYMdn7kdr6Mc1aY61lSHTrsRGJe1SeLn6rw2OEnTv/
         jLdAtNsZo3vCGeo4SkATJBO7vpkOTDrJNtUOaWUH4pmT/+JOcXFzIPcWMsYsrtP0vavp
         HpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742816150; x=1743420950;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMjyfayIK85IcJ/sRPcPvbjUEr5mymtFLNhcyvoAlrg=;
        b=YnAgmRoDUAcjtuOSRowZYRqyFRc7Ldr4+UPPT6l7eDr7ygJZSe/i4NDwW+Z06Zrua2
         DcUCpXHpzRxNGHpfipRhrKt9WulV4pBflGSu0is4u1Y+6Qvi2biGsrD3cilAUlVVdXLU
         /OdS8qHsT5om2ut3thBIvf11QcWXKAjIjwmSbnOLR5u5mJhIY2brJ1UvJJLtq5vRQpb1
         zWonmS6PC1sQUwsJqZXHSwznxMDUUwLCwj4sBjMkxZw2lrHy/aXTHSaFtxWA6UIPSgzV
         U3TgJbt3TCJzPReTJU8TQkOKUQcTSxhJK8LI4gVS8XKiatwDBNz0445u3dR1sUHh9BAb
         O/wA==
X-Gm-Message-State: AOJu0Yzzx/uukc+gLkgxbJrmp/LwVKK9CHmRXr49TfY5cZiAHOckE0su
	LGFTxrkr87OsrlPcXVnb3EStRPa8aAarQGhFOe4tI9LmIcfAKxuffA2NGoNTVr+Lt8ssGGaFbjX
	vKSty6+mv59Q+Kg037nCgl7ht+hZzIe15uxs=
X-Gm-Gg: ASbGncvihNTARNApe8WsrM+Ace1bLEQoETwcI2J3iYBKQG7fcPrv5r8wDH/PR6+ZuhL
	MATzAP6tq8V8EiO9A+cT06MKSzgcAcIywqrVlNEGRFTQiO8K1g2jeB8UsXyhjzQXkp+qiYlTSAA
	R4IYASj3QOlf73hy/XUUTj+naH69iQXPhInKgfI7+jcW3pD+lssghpM5q5i8U=
X-Google-Smtp-Source: AGHT+IGYw0Dxlypk+T3cK2Bw2H8akR/YL+ZymYxs3Pqt4OyxGi68zAvps6VBEhc/LO9f5CPIHCTcahxl3/qmSM+PiZU=
X-Received: by 2002:a05:6102:a47:b0:4c3:c9:c667 with SMTP id
 ada2fe7eead31-4c50d629e61mr8279524137.24.1742816149368; Mon, 24 Mar 2025
 04:35:49 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
From: Tania Zhou <tbui30920@gmail.com>
Date: Mon, 24 Mar 2025 18:35:38 +0700
X-Gm-Features: AQ5f1JpOmrSUMNWCfNFMEKjgoUzIjRjmxTVDEz--9pI7To4s8ZsliXsOFq0jIPE
Message-ID: <CAEcfKKPwyyoP_Hk4wZY_+Y8+7_agEXr-aytbESptKosbmLcdpw@mail.gmail.com>
Subject: =?UTF-8?B?6aWu55So5rC05Lit6auY5rWT5bqm5rCf5YyW54mp5b2x5ZON5YS/56ul5aSn6ISR5Y+R?=
	=?UTF-8?B?6IKy?=
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000007e01af06311501c6"
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--0000000000007e01af06311501c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuWcqOe+juWbve+8jOS8sOiuoeWkp+e6pjQwJeWIsDcwJeeahOawn+WMlueJ
qeaRhOWFpemHj+adpeiHquWQq+awn+mlrueUqOawtOOAguaWsOeahOeglOeptuehruWumu+8jOav
j+WNhzEuNeavq+WFi+awn+WMlueJqeaYr+WEv+erpeWPkeiCsuWuieWFqOmXrumimOeahOWFs+mU
rumYiOWAvOOAgg0KDQrpgJrov4fniZnoho/jgIHmvLHlj6PmsLTku6Xlj4rnlKjmsJ/ljJbmsLTl
iLbmiJDnmoTpo5/nianlkozppa7mlpnmkYTlhaXmsJ/ljJbnianvvIzlj6/og73kvJrlop7liqDl
hL/nq6XlkozlrZXlpofnmoTmgLvmsJ/ljJbnianmmrTpnLLph4/vvIzigJzlubblj6/og73lvbHl
k43og47lhL/jgIHlqbTlhL/lkozlhL/nq6XnmoTnpZ7nu4/lj5HogrLigJ3jgIINCg0K5Lul5LiL
5piv5paH56ug55qE5Li76KaB5YaF5a6577yaDQpodHRwczovL3Rpbnl1cmwuY29tL2Z1LWh1YXd1
LXl1LWVydG9uZzENCg0KIOaEn+iwouS9oOmYheivu+i/meevh+aWh+eroO+8gQ0KDQotLS0NCg0K
54K55ru05ZaE5oSP77yM5Y+v5Lul54Wn5Lqu5LiW55WMDQo=
--0000000000007e01af06311501c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7Zm9udC1mYW1pbHk6JnF1
b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW0iPjxzcGFuIGNsYXNzPSJn
bWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90OyI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxiciBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIg
c3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5Zyo576O5Zu9
77yM5Lyw6K6h5aSn57qmNDAl5YiwNzAl55qE5rCf5YyW54mp5pGE5YWl6YeP5p2l6Ieq5ZCr5rCf
6aWu55So5rC044CC5paw55qE56CU56m256Gu5a6a77yM5q+P5Y2HMS415q+r5YWL5rCf5YyW54mp
5piv5YS/56ul5Y+R6IKy5a6J5YWo6Zeu6aKY55qE5YWz6ZSu6ZiI5YC844CCPC9zcGFuPjxiciBj
bGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3Nv
ZnQgWWFIZWkmcXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
OyI+6YCa6L+H54mZ6IaP44CB5ryx5Y+j5rC05Lul5Y+K55So5rCf5YyW5rC05Yi25oiQ55qE6aOf
54mp5ZKM6aWu5paZ5pGE5YWl5rCf5YyW54mp77yM5Y+v6IO95Lya5aKe5Yqg5YS/56ul5ZKM5a2V
5aaH55qE5oC75rCf5YyW54mp5pq06Zyy6YeP77yM4oCc5bm25Y+v6IO95b2x5ZON6IOO5YS/44CB
5am05YS/5ZKM5YS/56ul55qE56We57uP5Y+R6IKy4oCd44CCPC9zcGFuPjxiciBjbGFzcz0iZ21h
aWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkm
cXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTom
cXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxl
MSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5Lul5LiL
5piv5paH56ug55qE5Li76KaB5YaF5a6577yaPC9zcGFuPjxiciBjbGFzcz0iZ21haWwtYXV0by1z
dHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxz
cGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01p
Y3Jvc29mdCBZYUhlaSZxdW90OyI+PGEgaHJlZj0iaHR0cHM6Ly90aW55dXJsLmNvbS9mdS1odWF3
dS15dS1lcnRvbmcxIj5odHRwczovL3Rpbnl1cmwuY29tL2Z1LWh1YXd1LXl1LWVydG9uZzE8L2E+
PC9zcGFuPjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWls
eTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250LXNpemU6
bWVkaXVtIj7CoOaEn+iwouS9oOmYheivu+i/meevh+aWh+eroO+8gTwvcD48cCBjbGFzcz0iZ21h
aWwtYXV0by1zdHlsZTkiIHN0eWxlPSJmb250LXNpemU6MTEuNXB0O2NvbG9yOnJnYig5MSwxMDIs
MTE2KSI+LS0tPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMTQiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMTIzLDI1NSk7Zm9u
dC1zaXplOm1lZGl1bSI+54K55ru05ZaE5oSP77yM5Y+v5Lul54Wn5Lqu5LiW55WMPC9wPjwvZGl2
Pg0K
--0000000000007e01af06311501c6--

