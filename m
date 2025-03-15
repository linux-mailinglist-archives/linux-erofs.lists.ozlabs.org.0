Return-Path: <linux-erofs+bounces-58-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967ABA62D38
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Mar 2025 14:08:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFM413Rldz2ykX;
	Sun, 16 Mar 2025 00:08:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1044"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742044097;
	cv=none; b=gVYCb6dlmMkKGimiU3Qe8sPwwUVGPWiWRxAObR6JKaIw3iUtW0EEZpTzx/lThund6A4BWaebrcDwwPxHbYIBmpZZAARUY07mx0lRsLGO5BsTMH1p2OUvlnhqFOtJJovnR6k0BnAZ3SpSU1hcZL0h1+bcvH0uur/T+8RvOMACRT34eJz5w7IyjKIUZd8Ct0+8mnM50XCHavUer6GJR5A0Y0e5u5UOzeBEpH5Sns6phH6xmT0mnZdYFhR6zi4xzZKzmft2o67IhYUCVK1QAvIQ9qQdzKpbsxDWr1zu/xiP6q8PlcR8/9u4HbefyRiyWf50Wx/byD7FvbbHOIJdAR5YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742044097; c=relaxed/relaxed;
	bh=jaj9Ff7bBvQx8IeHtaW4xhfbCLoQB3tVynC+WxYMjgQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZXNqiU+AzW6K8GZaLhReQB7rUEvPIzvZjf7Z4GaKxbtUcRFaYyPzYR3osBF3O4MkNMPkEa4/f9av3FKTfaWjxIkU9SoUCgjrh2vxKSFDmt+k9pZmfsGiz1z5zOJSZRzW0fYTKLPT4TjfmbBkE1wjTMU2YM/gMguPpfbhwSREhPQzmwBz6M+S9BvI+XbiFOCHHJqvN7gvDNtC1q70IY4hO7apRx7rM4V4SChjOKlBhmHrnP74I738TLqJ6MO6CS2qI0uEmWagAJLOZdmndvT7jGGKAsbPDPOcFVko8s8F6bd5EtgP4mujupH31cy6DNX7x/OIzkcZNIPPbRAFHK6+AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XwJB0KGW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=xiangguoliang11999@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XwJB0KGW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=xiangguoliang11999@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFM3z6gSjz2xS9
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 00:08:15 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so918060a91.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 15 Mar 2025 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742044092; x=1742648892; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaj9Ff7bBvQx8IeHtaW4xhfbCLoQB3tVynC+WxYMjgQ=;
        b=XwJB0KGWMf3qf7b3tKf2SID9RCsMY/7iyEfo1JMw5b+qHYojDCfOo08L4AIYt2FKXT
         taZiKG/+N+pSikHyf9/FAt0dZfduKCC3MfFzPviz/e4u5ajQvYTQ/j1k4JAfCyNXh4Hb
         oJaasuneiK7dUHskFXpR2HUfWv7JuK+8IF8tQzH0XSbfOcaQY7mAVeDNtj7BYcpPfr2E
         9ZIhqCwo46EBv9smhG72fl0NwYgj86N71m6rJg79p+fVTbKyp9iaIWQ+uBhs8FhJxyAf
         yHX5Xisn5sN79zBdiQlvpQu8H+G3s9zGa5Fxo59VRYocB84SvmYRfbOZPIZ94OsqAkcQ
         QIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742044092; x=1742648892;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaj9Ff7bBvQx8IeHtaW4xhfbCLoQB3tVynC+WxYMjgQ=;
        b=juMVLsRFgqXOA3McWP+ToiEaSCqvM9fAgAaiQGizvSlJycwBwMDt+lKNev6RMltWHA
         yIVEqfFgHrk969kZrGdQGF/fTcnTKDiSqJG1fPzX2xQGtTlQxfv1w8bp1z/bnADjLth8
         5frSZ44VvxgNzfeFW0TXXL8h8lR0qd0FKoPOVj+Bx+YJItHBwLGF3cm9kV80Vsmoe6lE
         6NdI0I9p2e7X8UZAimIq14H0L/ciy7Nl8rpgWaym4nz7/nLOrypV/0CDSz/vY5DIZtGg
         jOhvxTERZUpy0Ufwnwlb0UOioZubPPbsT+A8hlmMMv36EJp9ZUjXHqNLrev5gzpbE0RI
         v5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMh8KcefAdWuqSHBlSvqRi41GviIlFKOpJ2lZxuIwu+a8apvLDxUN7bzMhjHN8cnj+ioNZLe6HWfaOA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwrUk3rb/M+adsOffU0elC6QlGKbN7BnhbGVJWiVEY10F1q3cJy
	4cfGhPREvMXt4BUX2/NXoO7lfcivhO4mwQIFTLGaIlYN1ibh973qk2Nz7kcYFbw4vjFDUwQOit7
	mHLcmHIS9p9DbCseXZLWfS6KO8cg=
X-Gm-Gg: ASbGncuG/A2xxcd0aUsuDd32O6ZmD4pNZeRDpDkJcm4uxn4qHIBN5HFjNYuoTwo6Bw5
	e4/HdPbOtL6+xYAadUYXwexkWoLc1bczWRgsx1vSpKcRXu2ZKcs1x2JZWq8X96Seu9KrN2IJrBU
	5mK+E8TRO99CJTQZlBzvWrsR7Vpg==
X-Google-Smtp-Source: AGHT+IFG+GoEzd1nuDN1hy1LW2Qqk6gYtLG4hwjWVHDCbcqlmXng7gOR07WoPBXCW9ovlDZQ7vlR5avCicfbhRxL620=
X-Received: by 2002:a17:90b:5190:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30151d80d1bmr8175791a91.33.1742044091997; Sat, 15 Mar 2025
 06:08:11 -0700 (PDT)
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
From: Guoliang Xiang <xiangguoliang11999@gmail.com>
Date: Sat, 15 Mar 2025 20:08:00 +0700
X-Gm-Features: AQ5f1JrtobFxv93dHMcvjHBoLBubWqimA4bssCFhmVGRGHuV34X-zjClXASKo4o
Message-ID: <CADUUpLKK1VmCq_FbJJA4pXFq6KMJ0HvVVxp349DqZyDvdwX2sg@mail.gmail.com>
Subject: =?UTF-8?B?5oOK5Lq655qENeWkp+mVv+Wvv+WumuW+i++8jOeci+aHguS6huiDveiuqeS9oOS4gOi+iA==?=
	=?UTF-8?B?5a2Q5LiN55Sf55eF?=
To: vertrieb.bielefeld@arroweurope.com, webadmin@geoffreybooth.com, 
	mygzwdjk@163.com, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000004965680630613f7a"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

--0000000000004965680630613f7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlveWQl++8nyoNCg0K5bCx6K6p5oiR5Lus5pC65omL6LiP5YWl5o6i57Si6ZW/5a+/5aWl
56eY55qE5peF56iL77yM5rSe5oKJ6YKj5Lqb5Luk5Lq65oOK5Y+555qE6ZW/5a+/5rOV5YiZ44CC
5LiA5pem6aKG5oKf5YW257K+6auT77yM5oiW6K646IO96K6p5L2g55qE5LiA55Sf6L+c56a755eF
55eb77yM6L275p2+5q2l5YWl5YGl5bq36ZW/5a+/55qE5bq35bqE5aSn6YGT44CCDQoNCuS7peS4
i+aYr+aWh+eroOeahOS4u+imgeWGheWuue+8mg0KDQrkuIDjgIHlnYfooaHohrPpo5/vvJrmnoTn
rZHplb/lr7/nmoTlnZrlrp7ln7rnn7MNCuS6jOOAgemAgumHj+i/kOWKqO+8mumTuOWwsemVv+Wv
v+eahOWdmuWunuWxj+manA0K5LiJ44CB5b+D55CG5YGl5bq377ya6Kej6ZSB6ZW/5a+/55qE5b+D
54G15a+G56CBDQrlm5vjgIHkvJjotKjnjq/looPvvJrliqnlipvplb/lr7/nmoTnu7/oibLmuK/m
ub4NCuS6lOOAgemhuuW6lOiKguW+i++8mumBteW+quiHqueEtueahOmVv+Wvv+aZuuaFpw0K6L+Z
5Lqb5L+h5oGv5Y2B5YiG54+N6LS177yM6K+35Yqh5b+F5p+l55yL5a6M5pW05YaF5a6577yBDQoq
aHR0cHM6Ly90aW55dXJsLmNvbS81LWppbmctcmVuKiA8aHR0cHM6Ly90aW55dXJsLmNvbS81LWpp
bmctcmVuPg0KDQrnpZ3lpb3vvIENCg0KLS0tDQoNCuavj+S4gOS7veecn+eQhumDveWAvOW+l+ii
q+aNjeWNq++8jOavj+S4gOS7veWFrOato+mDveWAvOW+l+iiq+i/veaxguOAgg0K
--0000000000004965680630613f7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHRhYmxlIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtZmFtaWx5
OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90Oztmb250LXNpemU6bWVkaXVtO3dpZHRoOjY5MTJw
eCI+PHRib2R5Pjx0cj48dGQgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1p
bHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxzdHJvbmc+5L2g5aW95ZCX77yfPC9zdHJv
bmc+PC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5
bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+wqA8L3RkPjwvdHI+
PHRyPjx0ZCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuWwseiuqeaIkeS7rOaQuuaJi+i4j+WFpeaOoue0oumV
v+Wvv+WlpeenmOeahOaXheeoi++8jOa0nuaCiemCo+S6m+S7pOS6uuaDiuWPueeahOmVv+Wvv+az
leWImeOAguS4gOaXpumihuaCn+WFtueyvumrk++8jOaIluiuuOiDveiuqeS9oOeahOS4gOeUn+i/
nOemu+eXheeXm++8jOi9u+advuatpeWFpeWBpeW6t+mVv+Wvv+eahOW6t+W6hOWkp+mBk+OAgjwv
dGQ+PC90cj48dHI+PHRkIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFt
aWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+wqA8L3RkPjwvdHI+PHRyPjx0ZCBjbGFz
cz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQg
WWFIZWkmcXVvdDs7aGVpZ2h0OjM1cHgiPuS7peS4i+aYr+aWh+eroOeahOS4u+imgeWGheWuue+8
mjwvdGQ+PC90cj48dHI+PHRkIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+PHAgY2xhc3M9ImdtYWlsLWF1dG8t
c3R5bGUyIiBzdHlsZT0ibGluZS1oZWlnaHQ6MzJweCI+5LiA44CB5Z2H6KGh6Iaz6aOf77ya5p6E
562R6ZW/5a+/55qE5Z2a5a6e5Z+655+zPGJyPuS6jOOAgemAgumHj+i/kOWKqO+8mumTuOWwsemV
v+Wvv+eahOWdmuWunuWxj+manDxicj7kuInjgIHlv4PnkIblgaXlurfvvJrop6PplIHplb/lr7/n
moTlv4PngbXlr4bnoIE8YnI+5Zub44CB5LyY6LSo546v5aKD77ya5Yqp5Yqb6ZW/5a+/55qE57u/
6Imy5riv5rm+PGJyPuS6lOOAgemhuuW6lOiKguW+i++8mumBteW+quiHqueEtueahOmVv+Wvv+aZ
uuaFpzwvcD48L3RkPjwvdHI+PHRyPjx0ZCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxl
PSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPui/meS6m+S/oeaBr+WN
geWIhuePjei0te+8jOivt+WKoeW/heafpeeci+WujOaVtOWGheWuue+8gTwvdGQ+PC90cj48dHI+
PHRkIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01p
Y3Jvc29mdCBZYUhlaSZxdW90OyI+PGEgaHJlZj0iaHR0cHM6Ly90aW55dXJsLmNvbS81LWppbmct
cmVuIj48c3Ryb25nPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMyIgc3R5bGU9ImNvbG9y
OnJnYigwLDEzMCwyMjkpIj5odHRwczovL3Rpbnl1cmwuY29tLzUtamluZy1yZW48L3NwYW4+PC9z
dHJvbmc+PC9hPjwvdGQ+PC90cj48dHI+PHRkIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5
bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+wqA8L3RkPjwvdHI+
PHRyPjx0ZCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuelneWlve+8gTxicj48cCBjbGFzcz0iZ21haWwtYXV0
by1zdHlsZTkiIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZjtm
b250LXNpemU6MTEuNXB0O2NvbG9yOnJnYig5MSwxMDIsMTE2KSI+LS0tPC9wPjxwIGNsYXNzPSJn
bWFpbC1hdXRvLXN0eWxlMTQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwxMjMsMjU1KSI+5q+P5LiA5Lu9
55yf55CG6YO95YC85b6X6KKr5o2N5Y2r77yM5q+P5LiA5Lu95YWs5q2j6YO95YC85b6X6KKr6L+9
5rGC44CCPC9wPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+DQo=
--0000000000004965680630613f7a--

