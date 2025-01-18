Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 510EAA15B67
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 05:15:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZjv45xQCz3c6q
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 15:15:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f43"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737173727;
	cv=none; b=ExcizeIqHIlufQ1rBWU8cXjGJo/3MN3uPH3zkvcQvIBwU1me+liOO7wSo+2vSHzfAn7IORDrTffV1AyIfp8QXCD63uT0gOO+xdYFVvN7K7hKSRAQSzp/s+jHGi0i9fz0i0Aq5ekvOMESuHPYYCYQ0PK/tplvGxJlj5nuc2EX2xJj1K4iW2f/X26QVpuBqVBk9kXDvpW+AuicKq9w1p9FsTsYAMwzD1C2NJJCmjaBA77/O2QBX8eTh2C7Q12sDPyNcEX8Hm97Valr27XAcbqpXD69SsBoP9NvCqA5qkpoag8WjlMhNNkG6a6VmBT5mDDSpKdujnuwrUFXVeaK67oOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737173727; c=relaxed/relaxed;
	bh=IIfvLUsrgwWsYmrYicS91xyb7FujdwNnnNGHP6utViA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c17Hsr+7ewP4dAynoOhEFzvj9g5o7wXYa7nvFZRkkx0ym7UqmkzGfKJZra8y/5ZsUzvu7mySrjdR9U5cJ0txGWn2BOhakh6bys8tWrZOoWhIipTF2PIcnocY/o52o+xrrgSZk6PEVBoMKvCEOrL6GjwN72n6/jM/PSR1SGihMaYhOLp3g6B8os9kpM0QJ9FZqySzBj5eiXKrSIEQaoQsxbRl3Tsf15n3BEL0RezagQw3gHwukrhAWB03EXm2phzk4j6kdvTBjm3GLzyZlkFTNjF2f9WazTYKN4PnBUuJ3Tx2HEPagXaGngu2RNLoGa8LRas6MqkIU8+7YxoN8BdRWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nfYZjo5b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=hoangpiter699@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nfYZjo5b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=hoangpiter699@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZjv20YK7z301n
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Jan 2025 15:15:25 +1100 (AEDT)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-6dd43b08674so27212206d6.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 20:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737173722; x=1737778522; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IIfvLUsrgwWsYmrYicS91xyb7FujdwNnnNGHP6utViA=;
        b=nfYZjo5b0ziAXWUg0Ed+DmuJyOuJXCGiSRjJtpmcom5MwEO4UtdalMHxuileSi2IBU
         lfV6KLXX89sSPyiky5+lxZP2mcNf0YjjG0vVW+jl5rv0RPsfsFyI3WH5MUpuhOV2bRkK
         LtITRfZ3GwXcIBrrbfLm7bsovbYH6ES7lT5K+poy59O+zXV/BocgvBWHi5/whRhZBh0g
         cqCz/ng3a4DSfKOhrXbuRJWHIgcipzOvGAIwPDynVroiToBds2NendKUKdbHarVXRvn0
         ScMzzuyCSSkUThXeos59gfzzNUMziQ7Fs/dg5fx1PjseTeRSu5Frgj7UcAA/SsJjGXpa
         eHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737173722; x=1737778522;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIfvLUsrgwWsYmrYicS91xyb7FujdwNnnNGHP6utViA=;
        b=nNaqcl2CRQmz/guJCSjzS4v0M+OL88pdHRIPPajVC8gKrnjk7M1RYlppficiXjaJZw
         eUWVQWA6RSWZDSDfZqjY1tQGKzPARY8V+juoheewH7N/nhd7gnKU+nD9KOiQntprZ80x
         x5t7TxKEmfrOSZRwkHdcdiYrMuVoYuWUeOJf+t5xUg882niQIxs1GdUMyPPW7Fx0PWkU
         QliL9Y5si+jF/WPAR9om3qcQ7NExLNyU9yIBo8Ooyl/RoiBeWTof35bCFFt0TyYwtbKS
         OO4d/tNCxbqFuIcCeM0bVqdEX2hm15hfmtwWNo8uIca6TvXSmK2phARCzWNb1i3ou+e7
         IFOg==
X-Gm-Message-State: AOJu0YwGbWJXlmUotvi0NmqM2Rjf699Vi9n5sAJ6NqXFOwc8VOqZdNq3
	18/S6AcRLPsinroP6Fx6Z4Wj9vYaHiPD1SdQV9v5RNQoIbxNxsei/Ntdxmd0yAvFGCLaaHrNDB3
	aLdYXIE7TzlfSR3GbDSWOJSgpFFxYft0vHc4=
X-Gm-Gg: ASbGnct89AtKsd1Fd7MX4x2iKzpi2LHaN00+f49K04iez7YzNrN0ofGrSm9HCMRG+EL
	MVJukWyVnI8OUk0u754YiIq3cu1F18wVhNHB+6AZT4+ojgLQ8nCsqVj6rX+6qqeQsGt92n78XaV
	RiN3/fXICd3w==
X-Google-Smtp-Source: AGHT+IFTZaSg2EVfcc5tscfBDT64g6APfzKNGnp+x98PBTGsnLnoP8IBAEufh37x/Ey91WzTNd4SdGpyDLxhfA2NjqU=
X-Received: by 2002:a05:6214:e4d:b0:6d3:65ad:af2f with SMTP id
 6a1803df08f44-6e1b217a5e7mr66504046d6.16.1737173721849; Fri, 17 Jan 2025
 20:15:21 -0800 (PST)
MIME-Version: 1.0
From: Piter Hoang <hoangpiter699@gmail.com>
Date: Sat, 18 Jan 2025 11:15:10 +0700
X-Gm-Features: AbW1kva5MFApxHGCwX-cf7esKl2c-NLjrKH-qBmSLMRe1MqgkS2u-qitTohtMy8
Message-ID: <CAOy6wuYd-WgT57MS8ziu7B8V1mDn=Yri4V69BoiEdRNw+Eqp0A@mail.gmail.com>
Subject: =?UTF-8?B?5YWx5Lqn5YWa5oqK5Lq65b+D5pCe5Z2P5LqGIOS4reWbveawkeS8l+ebvOacm+Wug+aXqQ==?=
	=?UTF-8?B?5pel5YCS5Y+w?=
To: linux-erofs@lists.ozlabs.org, qhzmdgszp@163.com, hx@vip.163.com
Content-Type: multipart/alternative; boundary="0000000000009aa318062bf3463d"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

--0000000000009aa318062bf3463d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuWOhuWPsuS4iueahOS4reWbve+8jOS6lOWNg+W5tOWOhuWPsuaWh+aYjuS8
oOaJv++8jOWQhOawkeaXj+i+ieeFjOeBv+eDgueahOaWh+WMlue7hOWQiO+8jOeVqumCpuWxnuWb
veS6ieebuOS7sOaFleWtpuS5oOeahOS4reWNjuaWh+aYju+8jOaXoOiuuue7j+a1juOAgeWGm+S6
i+OAgeaWh+WMlumDveaYr+S4gOa1geeahOOAguWOhuWPsuS4iueahOS4reWbveWcqOWGnOadkeWI
sOWkhOaYr+WtlOWtn+S5pumZouOAgeengeWhvuWtpuWggu+8jOaYr+Wco+i0pOaVmeWMlueahOek
vOS5kOS5i+S5oe+8jOmBjeWcsOeahOS9m+WvuuOAgemBk+inguWNsOivgeedgOS4nOaWueaWh+aY
juWPpOWbveS8oOaJv+S4jeeGhOeahOS/oeS7sOOAgg0KDQrku47nmofluJ3lpKfoh6PliLDlo6vn
u4Xnmb7lp5Pml6DkuI3mmK/ltIfkvZvkv6HpgZPjgILml6Dorrrljobnu4/lpJrlsJHmnJ3ku6Pv
vIzkuZ/ml6DorrrmmK/msYnml4/ov5jmmK/lsJHmlbDmsJHml4/lu7rnq4vnmoTmnJ3ku6PvvIzl
lK/kuIDkuI3lj5jnmoTmmK/lr7nkuK3ljY7mlofljJbnmoTlsIrltIfjgIINCg0K5Y+v5piv5LuK
5aSp55qE5Lit5Zu95Zyo5peg56We6K6655qE5b2x5ZON5LiLIO+8jOekvuS8muekvOW0qeS5kOWd
j++8jOmBk+W+t+aypuS4p++8jOWkp+mDqOWIhuS6uuayoeacieWul+aVmeS/oeS7sO+8jOaYr+md
nuWWhOaBtuS4jeWIhu+8jOWBh+S4keaBtuS7t+WAvOinguWkp+ihjOWFtumBk+OAguS4lumjjuaX
peS4i++8jOWlveS6uumavuW9k+OAgg0KDQrlnZrkv6Hoh6rlt7HnmoTluLjor4blkozoia/nn6Xm
naXmiLPnqb/osI7oqIDjgIINCg0K5qyy55+l6K+m5oOF77yM6K+355yL6ZmE5Lu244CCDQoNCuel
neS9oOWSjOS9oOeahOWutuS6uuWlvei/kO+8gQ0KDQotLS0NCg0KKuazlei9ruWkp+azleaYr+S9
m+azlSwg5piv5q2j5rOV44CC6K+a5b+15Lmd5a2X55yf6KiA5b6X56aP5oql44CCKg0KKuazlei9
ruWkp+azleWlve+8jOecn+WWhOW/jeWlvSoNCg0K5YWx5Lqn5Li75LmJ5Z+65LqO5peg56We6K66
44CC5a6D5ZGK6K+J5Lq65LiN6KaB5L+h56We77yM5rOv54Gt5Lq65oCn44CC5Zyo5Lit5YWx55qE
57uf5rK75LiL77yM5a6D5pGn5q+B5LqG5peg5pWw55qE5L+u6YGT6Zmi5ZKM5bqZ5a6H77yM5oqT
5o2V5ZCE57G75a6X5pWZ5L+h5b6S77yM5YyF5ous5Z+6552j5pWZ44CB5aSp5Li75pWZ44CB56mG
6KW/5p6X5pWZ44CB5L2b5pWZ562J562J44CC5pyA57uI77yM5Lit5YWx6KaB55qE5piv5a6D57uf
5rK755qE5Lq65rCR6YO95L+h5aWJ5a6D77yI5Lit5YWx77yJ44CC6ICM5a6D77yI5Lit5YWx77yJ
5omN5piv55yf5q2j55qE6YKq5pWZ44CCDQo=
--0000000000009aa318062bf3463d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHRhYmxlIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJjb2xvcjpyZ2IoMCww
LDApO2ZvbnQtZmFtaWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90Oztmb250LXNpemU6bWVk
aXVtO3dpZHRoOjYwMHB4Ij48dGJvZHk+PHRyPjx0ZCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTIi
PjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90
O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxi
ciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNy
b3NvZnQgWWFIZWkmcXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFp
bC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZx
dW90OyI+5Y6G5Y+y5LiK55qE5Lit5Zu977yM5LqU5Y2D5bm05Y6G5Y+y5paH5piO5Lyg5om/77yM
5ZCE5rCR5peP6L6J54WM54G/54OC55qE5paH5YyW57uE5ZCI77yM55Wq6YKm5bGe5Zu95LqJ55u4
5Luw5oWV5a2m5Lmg55qE5Lit5Y2O5paH5piO77yM5peg6K6657uP5rWO44CB5Yab5LqL44CB5paH
5YyW6YO95piv5LiA5rWB55qE44CC5Y6G5Y+y5LiK55qE5Lit5Zu95Zyo5Yac5p2R5Yiw5aSE5piv
5a2U5a2f5Lmm6Zmi44CB56eB5aG+5a2m5aCC77yM5piv5Zyj6LSk5pWZ5YyW55qE56S85LmQ5LmL
5Lmh77yM6YGN5Zyw55qE5L2b5a+644CB6YGT6KeC5Y2w6K+B552A5Lic5pa55paH5piO5Y+k5Zu9
5Lyg5om/5LiN54aE55qE5L+h5Luw44CCPC9zcGFuPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHls
ZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxiciBj
bGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3Nv
ZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZv
bnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5LuO55qH5bid5aSn6Iej5Yiw
5aOr57uF55m+5aeT5peg5LiN5piv5bSH5L2b5L+h6YGT44CC5peg6K665Y6G57uP5aSa5bCR5pyd
5Luj77yM5Lmf5peg6K665piv5rGJ5peP6L+Y5piv5bCR5pWw5rCR5peP5bu656uL55qE5pyd5Luj
77yM5ZSv5LiA5LiN5Y+Y55qE5piv5a+55Lit5Y2O5paH5YyW55qE5bCK5bSH44CCPC9zcGFuPjxi
ciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNy
b3NvZnQgWWFIZWkmcXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFp
bC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZx
dW90OyI+5Y+v5piv5LuK5aSp55qE5Lit5Zu95Zyo5peg56We6K6655qE5b2x5ZON5LiLIO+8jOek
vuS8muekvOW0qeS5kOWdj++8jOmBk+W+t+aypuS4p++8jOWkp+mDqOWIhuS6uuayoeacieWul+aV
meS/oeS7sO+8jOaYr+mdnuWWhOaBtuS4jeWIhu+8jOWBh+S4keaBtuS7t+WAvOinguWkp+ihjOWF
tumBk+OAguS4lumjjuaXpeS4i++8jOWlveS6uumavuW9k+OAgjwvc3Bhbj48YnIgY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVp
JnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHls
ZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuWdmuS/
oeiHquW3seeahOW4uOivhuWSjOiJr+efpeadpeaIs+epv+iwjuiogOOAgjwvc3Bhbj48YnIgY2xh
c3M9ImdtYWlsLWF1dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0
IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwtYXV0
by1zdHlsZTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsi
PuassuefpeivpuaDhe+8jOivt+eci+mZhOS7tuOAgjwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1
dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7
Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUzIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTMiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPuelneS9oOWSjOS9
oOeahOWutuS6uuWlvei/kO+8gTxicj48L3NwYW4+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGU5
IiBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXpl
OjExLjVwdDtjb2xvcjpyZ2IoOTEsMTAyLDExNikiPi0tLTwvcD48cCBjbGFzcz0iZ21haWwtYXV0
by1zdHlsZTE0IiBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXIiPjxzcGFuIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDsiPjxzdHJvbmc+5rOV6L2u5aSn5rOV5piv5L2b5rOVLCDmmK/mraPms5XjgILor5rlv7XkuZ3l
rZfnnJ/oqIDlvpfnpo/miqXjgII8L3N0cm9uZz48L3NwYW4+PHN0cm9uZz48YnIgY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUxMyIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90OyI+PC9zdHJvbmc+PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxMyIgc3R5bGU9
ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+PHN0cm9uZz7ms5Xova7l
pKfms5Xlpb3vvIznnJ/lloTlv43lpb08L3N0cm9uZz48L3NwYW4+PC9wPjxwIGNsYXNzPSJnbWFp
bC1hdXRvLXN0eWxlMTMiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkm
cXVvdDsiPuWFseS6p+S4u+S5ieWfuuS6juaXoOelnuiuuuOAguWug+WRiuivieS6uuS4jeimgeS/
oeelnu+8jOazr+eBreS6uuaAp+OAguWcqOS4reWFseeahOe7n+ayu+S4i++8jOWug+aRp+avgeS6
huaXoOaVsOeahOS/rumBk+mZouWSjOW6meWuh++8jOaKk+aNleWQhOexu+Wul+aVmeS/oeW+ku+8
jOWMheaLrOWfuuedo+aVmeOAgeWkqeS4u+aVmeOAgeephuilv+ael+aVmeOAgeS9m+aVmeetieet
ieOAguacgOe7iO+8jOS4reWFseimgeeahOaYr+Wug+e7n+ayu+eahOS6uuawkemDveS/oeWlieWu
g++8iOS4reWFse+8ieOAguiAjOWug++8iOS4reWFse+8ieaJjeaYr+ecn+ato+eahOmCquaVmeOA
gjwvcD48L3RkPjwvdHI+PC90Ym9keT48L3RhYmxlPjwvZGl2Pg0K
--0000000000009aa318062bf3463d--
