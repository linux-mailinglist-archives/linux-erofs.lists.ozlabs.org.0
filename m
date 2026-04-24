Return-Path: <linux-erofs+bounces-3358-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBEZBRZR62nkKwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3358-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Apr 2026 13:16:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3745D94D
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Apr 2026 13:16:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g29H34mJPz2yhD;
	Fri, 24 Apr 2026 21:10:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1042" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777029023;
	cv=pass; b=IJRonz5yEA7Q8GZsz5Bhj/H+n4m8/bBpgTUWJm/NYoj8zr8zDtRxBqeqC4nUZDm2m8LFenNQInHx6CHmTJkTtTv6OmI8zbIh7IzUbeDMd898dyn8Q9H5wAj+frma96j4+T7k8jwbA/lYMQB0T8XhrLUkAEkFHWs7c/JjvIevUOApwLq7GZeyXLQCrO4Uufp1BINs0T6QbtwvicKZRHTShW6EN6ztL4p0qMmIVdwXVSfQoLsOCvAa+dKtYMbei5C784VOIMSG8HyrqlzlNDssQldtpynsQXsOW+9h1dH8QROCNtaQ+H8yaeYZe5KOmn4ROKFHBcNNU3plyWcP2ARyFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777029023; c=relaxed/relaxed;
	bh=iqWMO1lEhLZIco0ydaicp7BmNTEVWm1K11yFsw/8Hlk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Xq1G+5LfRT12FLjAUxyfZc4obG7EZxWb7M/z3X75+op69TLTxbKW0m0zy52p2R4BQee/mqNaH2r1gvY8qFRSZQS44ctCsTfUZiVAo1eIe6ubK5IByziJg2h0iZGRc6R4mBJxh8aaq+giBzXrF7DWTtvaham56SSVOhj7u13u2KtBhLMJuyWr8BEQqvo/2NG/7LYNlADRVFfGiEVIrwL6mPKiSF8W0yJUC82GC4N1ag0jsDNGKkRU7KUHeC+Xv0gj1iLxfgv9kfDmeYIYEIES6u/jcpz/KzKWwLAYUBJNkRzyEZ+UpGkIVxKkyXxGbXGLfGJmaF4lJsOTk+XD8iYazQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dqK1cVul; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=henssmuntean@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dqK1cVul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=henssmuntean@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g29H247L0z2yTQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Apr 2026 21:10:22 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so1040923a91.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 Apr 2026 04:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777029020; cv=none;
        d=google.com; s=arc-20240605;
        b=a9quEJED4OO1wT6VLv80eDLhwOOZEhyCNXz98Xpmm2iF9SwByucH7MmXMEO+/cC7/B
         ahXu82V/hi8aUas3AWFiZXjepdiCYgZEE37rSnU0oEHQSfLSsoJWk/blISEUd05gAjhp
         Qa8QO7DgsSLnlhj0NRThK4GxflBGW+2LkNdbCOxVOjtElfeeggXOqG7GT8SYpzPv2S68
         UqhS8zNArq9v5y+UCVjENp/N2LOUZ/llyFn6q5RHkKhqvUDbryYkfSTqa8zcigwdBNmD
         Qz0QfP8FZN1EssbfNl9PXpACWOXZWsX5fKosE2308lx4ElRl2G3OUnbzZ9EFLhtqpRhS
         efqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iqWMO1lEhLZIco0ydaicp7BmNTEVWm1K11yFsw/8Hlk=;
        fh=GyX8GJ1dyowGxzb9MEC6sI1LlQvCTl5xJ3AsyRhb4XY=;
        b=X0UWa2cx9KiiOdIvWJwP9cIIga6mEWt1/Vy9sZZkZoJlc8KqzNDhta1JgTxMOLJGuU
         L9TTrdoYdZ5+X7e/4Tsxx+6T6hzTCl3ztfR2LAEz4bkXF/3YNgI5fkdlz9FNpB/ChSWd
         jYsdYFCrX3Eub3wohte1+h5YpbMpNULmM7HqzjO6uBqyKVf38f+EGzN3m7r6nMonEft+
         BgbE2t+uSY4aaHXx/kXBb3HmcHB3A5eaWyaB2MCjq1p4r0QEmYLEIzo+Li4CXRFuglXx
         oCxunGLEidVX4U6ZpGJQp4hlEVdJN49BCZbtQNh9pLQWkQQ+Vdg7poM5ti+n83Hpn3qa
         9QEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777029020; x=1777633820; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqWMO1lEhLZIco0ydaicp7BmNTEVWm1K11yFsw/8Hlk=;
        b=dqK1cVuliF90emXWc2Xr6ktyVBe5zl6AJbWo6QXJ/iq8iwIwjEX7NnuRJ/vuRaI3Hn
         OiEUQjFm2xBSHfU5GePzjfdyO5t5j7p4oUxsoOntGMtOs3NLDP1qpcGj8r6zsO3flVg8
         KXDEC1hQnmOnW0VVH7cogRAqXyZT9ZiXGpIf9jPEFi+gbEDRJ2fIaOyw3DT4nZXeBiCz
         us/PaltIqLw6s2ziw6JU+5eROq8cATjLaoOsKe0vMJsEmQ69UDQr79MxlHwYJcn1k4eG
         1s6RhPqHoC/VXkJJiSxE+Gguwl18QyIbJ/7lfs6vU7yaeALieiizDeLkgAI5DUtjcSTf
         nnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029020; x=1777633820;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqWMO1lEhLZIco0ydaicp7BmNTEVWm1K11yFsw/8Hlk=;
        b=XNG1v0am0jt5TKGSgcMJZvy40daBeeBYQ6l9z31uL628DfvCyYkgTZ3uPi2NDpbOSk
         y/NNHzRKHrx0CBj1US5EZXWNqewSpqc2J5TE8Vy2iEvZ2/qgk9ePltbZh47JT/weUKfa
         HBV8pWe8g98OM/9u1rsGIgECUqUSI1R13VihvNPA5v+3RrRgiXbri2DbnTezLMhquc1s
         beCSJm1SGBde6TZcovneUYbUWGMBYOfMbeQPps289gTX372PGyVPh5lLP7R5dpIKeOvD
         xu3EHlapvarQkj0M04KC/6Cs/etiL0m01/IBd/qPpmtfDcsm/O72O8/DWcpMLh/jcfiG
         R2pw==
X-Forwarded-Encrypted: i=1; AFNElJ96ubPDvL3+/09g/y6aTpOgj/CUCb0HaDpnZ/F5AOn14kHt8rGz8MFOYFTaHx/UQiznKE663Qk56wG/wQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyexQ6ZT/IyLAaHGwQoOV6pQaoLjtSetE/zJDdbx3l/0Xl2OSH2
	iPXSi7a+AbRWY0cNIkyqbXWxpNfGF6GTXvsg1vHqqyiuJYTrfUfnUagxrzcLIn6mSZpElaI9FFX
	MWfPC/vnvMlWXFmiwkcJZu9mGdYRlf4I=
X-Gm-Gg: AeBDievWQ1hxRMY3M90mWMyW3UVX1s6PuQBFwMoVA+b+ZTe0mNQ+znPCBB0aJ7PBlAA
	KNF7MeNniuJi9AuwXtTxCd3fEHRT1e8NhC9UGKatYhJ+h27sxVLtPX1QlEy6/yyJl80mjsY18Vg
	3Dm0/SB8qK+G6SJZYU6pHQGG4y9N5R2iSa5MENCFosrg5C2PGUEJ+J62HhzS6H5Ur2zbn15wwnp
	cNJ7EkcDY/nvWGq9LafUokkJRLNOUrlhyNjgaLoz9VCeQWL3ZKmZKPxNTw2dIRd2E5UPzk7ksho
	S7bSEXfZ9hMH+R1fu/u7HcFaDZ4ccrvg4jnsjoVg2axWgYB2pdngMFsAa76g3AxWmoWXxoYzGbk
	krBqW1av/g6MB0WIiL5ZNOC+Mjgk6VwVK77vgGcoYwgHEVjpXk87UDHsqVKWd2fkhXj9nkUWpyi
	aiz6tGHmDo3oDcj9lwoYw01u0PgwM8F0yeKFZn7cYQaNsSC5ySm7phTFhFW1BFHv5PKOhWGoU0f
	W73WUdqD9f7+qSK
X-Received: by 2002:a17:90a:dfd0:b0:35b:e5cf:20fc with SMTP id
 98e67ed59e1d1-361404b25f2mr32005945a91.26.1777029019843; Fri, 24 Apr 2026
 04:10:19 -0700 (PDT)
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
From: Kendrick Mai <henssmuntean@gmail.com>
Date: Fri, 24 Apr 2026 18:10:07 +0700
X-Gm-Features: AQROBzA22D78rqhHN7zOuKjbu8Vte0PCtg3LIelSjo0TWpF-JoWkdxxdVSQt2UA
Message-ID: <CAAM8bfGrXERA1CuDJ20yOMC78bNXvaNsWUOKt9wjKcUqh+WT6A@mail.gmail.com>
Subject: =?UTF-8?B?5L2g55+l6YGT5ZCX77yf6Iqx55Sf5Y6f5p2l5piv5Liq5a6d77yB?=
To: lwgsy@126.com, cecimak@ricacorp.com, wkhan1956@gmail.com, 
	heliya@ecust.edu.cn, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000007bbd65065032cf64"
X-Spam-Status: No, score=2.3 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: CDF3745D94D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.71 / 15.00];
	FUZZY_DENIED(10.81)[1:0eb469065b:0.81:txt];
	MAILLIST(-0.19)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	TAGGED_FROM(0.00)[bounces-3358-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[126.com,ricacorp.com,gmail.com,ecust.edu.cn,lists.ozlabs.org];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:lwgsy@126.com,m:cecimak@ricacorp.com,m:wkhan1956@gmail.com,m:heliya@ecust.edu.cn,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[henssmuntean@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henssmuntean@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2404:9400:21b9:f100::1:c];
	NEURAL_SPAM(0.00)[1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=2];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam: Yes

--0000000000007bbd65065032cf64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuivtOi1t+adpeS9oOWPr+iDveS4jeefpemBk++8jOiKseeUn+WFtuWunuaY
r+aegeWlveeahOakjeeJqeibi+eZvei0qOadpea6kO+8jOS4gOebjuWPuOeahOiKseeUn++8iOWk
p+e6puaYr+S4gOaKiu+8ieWQq+acieavj+WkqeaJgOmcgDEzJSDnmoTom4vnmb3otKjjgILlroPo
v5jlkKvmnInlgaXlurfohILogqrvvIzlkIzml7bnorPmsLTljJblkIjnianlkKvph4/kvY7jgIIN
Cg0K5ZCM5pe277yM6Iqx55Sf5piv57u055Sf57SgQjPvvIjng5/phbjvvInlkKvph4/mnIDkuLDl
r4znmoTntKDpo5/kuYvkuIDvvIzlroPov5jmnInlhbblroNC5peP57u055Sf57Sg44CB57u055Sf
57SgReS7peWPiumUjOOAgemUsOOAgemVgeetieOAguiKseeUn+S4reS5n+WQq+acieW8gum7hOmF
ru+8jOi/meenjeWcqOWkp+ixhuS4reWQq+mHj+S4sOWvjOeahOiQpeWFu+e0oO+8jOWvueS6jui6
q+S9k+acieiuuOWkmuebiuWkhOOAgg0KDQrpgqPkuYjliLDlupXoirHnlJ/opoHmgI7kuYjlkIPv
vIzmiY3og73mkYTlhaXlj4zlgI3mipfmsKfljJbnianlkaLvvJ8NCg0K6K+35LuU57uG6ZiF6K+7
77yM5oiR5Lus57K+5b+D5Li65oKo5YeG5aSH5LqG6L+Z5Lqb5a6d6LS15L+h5oGv77yBDQoNCmh0
dHBzOi8vc3Vtby5hZC9odWEtc2hlbmcteXVhbi1sYWktc2hpLWdlLWJhb2hwDQoNCuaEn+iwouS9
oOmYheivu+i/meevh+aWh+eroO+8gQ0KDQotLS0NCg0K55yf55CG5LiN5oOn5pe26Ze077yM5YWJ
5piO57uI5bCG5Yiw5p2lDQo=
--0000000000007bbd65065032cf64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29s
b3I6cmdiKDAsMCwwKSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxiciBjbGFzcz0i
Z21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFI
ZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48YnIgY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVp
JnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+PHNwYW4gY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVp
JnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+6K+06LW35p2l5L2g5Y+v
6IO95LiN55+l6YGT77yM6Iqx55Sf5YW25a6e5piv5p6B5aW955qE5qSN54mp6JuL55m96LSo5p2l
5rqQ77yM5LiA55uO5Y+455qE6Iqx55Sf77yI5aSn57qm5piv5LiA5oqK77yJ5ZCr5pyJ5q+P5aSp
5omA6ZyAMTMlIOeahOibi+eZvei0qOOAguWug+i/mOWQq+acieWBpeW6t+iEguiCqu+8jOWQjOaX
tueis+awtOWMluWQiOeJqeWQq+mHj+S9juOAgjwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8t
c3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2Zv
bnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+PGJyIGNsYXNzPSJnbWFpbC1hdXRvLXN0
eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250
LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0
eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250
LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPuWQjOaXtu+8jOiKseeUn+aYr+e7tOeUn+e0
oEIz77yI54Of6YW477yJ5ZCr6YeP5pyA5Liw5a+M55qE57Sg6aOf5LmL5LiA77yM5a6D6L+Y5pyJ
5YW25a6DQuaXj+e7tOeUn+e0oOOAgee7tOeUn+e0oEXku6Xlj4rplIzjgIHplLDjgIHplYHnrYnj
gILoirHnlJ/kuK3kuZ/lkKvmnInlvILpu4Tpha7vvIzov5nnp43lnKjlpKfosYbkuK3lkKvph4/k
uLDlr4znmoTokKXlhbvntKDvvIzlr7nkuo7ouqvkvZPmnInorrjlpJrnm4rlpITjgII8L3NwYW4+
PGJyIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01p
Y3Jvc29mdCBZYUhlaSZxdW90Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxi
ciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNy
b3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48c3Bh
biBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNy
b3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj7pgqPk
uYjliLDlupXoirHnlJ/opoHmgI7kuYjlkIPvvIzmiY3og73mkYTlhaXlj4zlgI3mipfmsKfljJbn
ianlkaLvvJ88L3NwYW4+PGJyIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250LXNpemU6bWVkaXVtO2NvbG9y
OnJnYigwLDAsMCkiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpy
Z2IoMCwwLDApIj48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpy
Z2IoMCwwLDApIj7or7fku5Tnu4bpmIXor7vvvIzmiJHku6znsr7lv4PkuLrmgqjlh4blpIfkuobo
v5nkupvlrp3otLXkv6Hmga/vvIE8L3NwYW4+PGJyIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIg
c3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250LXNpemU6
bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1l
ZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1l
ZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48YSBocmVmPSJodHRwczovL3N1bW8uYWQvaHVhLXNoZW5n
LXl1YW4tbGFpLXNoaS1nZS1iYW9ocCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vc3Vtby5hZC9o
dWEtc2hlbmcteXVhbi1sYWktc2hpLWdlLWJhb2hwPC9hPjwvc3Bhbj48YnIgY2xhc3M9ImdtYWls
LWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1
b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+PGJyIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxzcGFuIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPuaEn+iwouS9oOmYheivu+i/meev
h+aWh+eroO+8gTwvc3Bhbj48ZGl2PjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5
bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztmb250LXNpemU6bWVk
aXVtO2NvbG9yOnJnYigwLDAsMCkiPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlOSIgc3R5bGU9
ImZvbnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMS41cHQ7
Y29sb3I6cmdiKDkxLDEwMiwxMTYpIj4tLS08L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
NCIgc3R5bGU9ImNvbG9yOnJnYigwLDEyMywyNTUpIj7nnJ/nkIbkuI3mg6fml7bpl7TvvIzlhYnm
mI7nu4jlsIbliLDmnaU8L3A+PC9zcGFuPjwvZGl2PjwvZGl2Pg0K
--0000000000007bbd65065032cf64--

