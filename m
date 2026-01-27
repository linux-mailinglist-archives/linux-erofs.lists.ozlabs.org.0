Return-Path: <linux-erofs+bounces-2219-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJIlJOwyeGlRowEAu9opvQ
	(envelope-from <linux-erofs+bounces-2219-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jan 2026 04:37:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A763F8FA59
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jan 2026 04:37:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0W2028SJz2xcB;
	Tue, 27 Jan 2026 14:23:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::244" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769484184;
	cv=pass; b=gXpAiMjQQclL/E6e9YRzCi0iSa9xgXQs7YulJyPN8Dva3kelNQGbqQ292cEzk/VPxZgqYTjd7cbMW/kXOGtnDsz9YON6dw5sb41tBhlKa5kS03P1LstyizlvICvZOZXSXbRLslpwcYuIAEQfdgQc472yHRE7rbEcF7MSbdXGQYdSM4kuLH391zPyN3GXjE6v7qrykJzEC7ChcApBWHJkJVB0L0xAZODBehNrZdQa6r8/+jKBthPKNbjDYV5TjXgsWzMb5qZx9te5n2boLNZqylSadqOpDqJTwU//vYLYzyQNrxaK6HVfUfLUsi6bDss3utFu8FIWtS9bs6f6UrLCRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769484184; c=relaxed/relaxed;
	bh=xXDGAwrlFbPhOF7yQzq3sIxpFlr2TpQhUx6aTrtQBbE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UY0IuHBM+v0fi+J27VEKtk3sH8aLMgWNo9EXy6s6B4cceafOiGIlTRRLKFoaFsGV1AxHK0zkg9C2gYPn2zItZOV1dTwtqdFcGnkq+DLNJCswJ8LV/oQSoa0MWsUCZpvZRceP1yOBJ+8reQZYGvcHQt92EnYd1bfUQlRD0RvAS5zxAITaMI4rFMGHd1B8HApVsaD/lhebrxnSUp3+UQ9hv54iJzu4PVIFmosvVdmMh4HQ8eVDyIEqUbEbqf1H8j6yhAtQL/4bAyNrfrEk1LcSXRoS3BeMLtoLvh/cJTWNx+cjER/Iq5twtj4CtKS4fwyDrOViu/1hKevBnv+971du6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RfekXIfR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=nelsonmv692d@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RfekXIfR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=nelsonmv692d@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0W1x5mydz2xJF
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jan 2026 14:23:00 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-45c7f3a9676so4053522b6e.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jan 2026 19:23:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769484178; cv=none;
        d=google.com; s=arc-20240605;
        b=B989Sb7/ipPxD9S8SuBGZAIHsVpLl90s98pGvrV9tfY4aqCB+1WkcEV+vY82qFnimS
         SRGGaZ7N2Z16hg6iQuCVM1XyfWzHTxYDgOH/ZqVd54WgCRrLFxHdANY3esAvCs6kNxF5
         PhLDlWwir0MnQkEBvrBDuBsOc01i7LHkYvTJGu7MtIM/SENQKP/JKAGJr0pFPNLYl79E
         oe/nKo5K7mAzIwsTuyKHwr9Q+1b0uDjcuMX5OIJYehaGC66LMCNrQy73jf4BpUYW6DHh
         DxORK6GeZL9wzcXXuQfySoMyuKgyGmGxcIRvKbkmcAQv19IE7S2EoYjHNVlujvxWxfgB
         uzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xXDGAwrlFbPhOF7yQzq3sIxpFlr2TpQhUx6aTrtQBbE=;
        fh=o4M9HsD2NkZUn+xXpryVEPZnqQ3B64SBBz9sPLrYkGc=;
        b=U9ZWTUPjoGxMX6TFuoAyck5BdryP4H8aBZVC6JNDbvVmlNU06PcHPYCAF0hwdd+aZG
         QmXV/EU5YIIAfs6MRDCg4tVyJMGDMetmm4EOS4+63NXfkmg+OopxkxFVU0ixfix8zLP6
         7XT7jAr1LvV05Jht7C3DyCprKKRoomf1QbzqKdtJm3Q8Yw2qIaosNY/FyUS1PagRPOQO
         GFCW8zsNl8az/a6q9Zieq8vjqn3A55BCgsUz+7AGym7C0hsNDcyli42mueUabibWZEOH
         2B113U7fecI6zgLGwve+zUxq9IYcNf2wQ9aoJYARNi+Rly1GbqHSAXkVbLlY+gApsVb6
         vGTA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769484178; x=1770088978; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xXDGAwrlFbPhOF7yQzq3sIxpFlr2TpQhUx6aTrtQBbE=;
        b=RfekXIfR6rt8EPSy9e9qjAYJfDwGaz/4HdW6q8RkLW6DqkBhUw29TaAxWTpp+q8rio
         i1E6hC9lUaob0LdnckV9uzdKixNxZ09diTHr1mNkfnIhFYN1T50Hf4vIA1uK40rWsc1R
         m8+s9bNC9OgZFJoAeLuW+9jEj7enkxwkoBHBRC+qwyUBNywOd4MxLP+hRtzsUAVIyBFr
         cPdywWKeqBFjmjaf9gNCuc/sCyyJg1KMlrAbZnS6ZAkzIimozez5laSIk4cv1GsEg87q
         2xeDHVCF6x1W+yT1HnVIOP0Upo98WzEyuc6YhWZ8/m5dzu8HweV6PwoLRD1j5Mbfae9x
         4a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484178; x=1770088978;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXDGAwrlFbPhOF7yQzq3sIxpFlr2TpQhUx6aTrtQBbE=;
        b=rnFpw9zmb9xF2dsw9sC2xeikdq774JaZmEf1TfhstTBMp8WAP1uFhT40Y7Sy/Mnl51
         oL45q2unNHAtHDMRBSAppZGgIS/m2H9pt5qyNwA71jfP0I5yDCvPFEa03TSakQmATOJ7
         oITfihsqpf7syACwYIxhyYJ7jf4aEQxhDxm7XaIpbc2lyuBENh3irH4egC0Y1N6JSo30
         Z/jjGM6kMsP64m54dtRUsW4j1E3dDUimW3et67BOR7RTtZwbAEaHFjacd/Mw5byXjYdC
         KZwdTgWfqtx6sp7YyOUMYk+yPvcijcgeeO6R64VrO1ul7j9/bBc3jE1eNvcMxCRKmlj0
         Gb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl3mxfbMkqB4wJYhS6cLPJqeWJd3zEdE51FgFMotxnXoZ/Jf1XzFBYuZsjzO8RmCA/eA5MNuGE8cIVXA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwrexN3sOue7q1B4VXypOn/9eSc8uk5PGgNZvC69AMASoWvxAjc
	dLFSZzzjsx6iaV2gI6CNR7UPYkKbGvrspB48Bnw06BeJmXxmfRmiZOiUs5Bcl6/kUdjpc/p/yIG
	4zdKfTSfsSmkTxf0VyCdrSHZFoFdukEA=
X-Gm-Gg: AZuq6aIkVh8UEw2ONDUKHVIrjYfovHYz36xwyaimHMej77pMFTIr6/GXdblIK/xWslV
	hiO+4QibocWGgBq3sCjkRbaMGRooz1QrA8Qtu8InNc5jelWoPOVafFzGxDobGRPFSUe9dV2QzZF
	YrmqbjGdPu1rWtBA9DdgQ1hygVXAtQv+BYMMht1///fe0t+3e5CzYiFpv6f5/tTHQTYmF71X8qi
	3F+/rNNGjdqsVkZUltvsjDEzrxSitobXBdJ8P31m7eRzh9qr1+BRbLFv9c80AesB41C4TqJt2KV
	79rmvHtNvc6mlkJjyo86q16QBBeqSprpCoYa/XllkF/af1mSNpic5K3LmA2pCDGZU5btSGuKLX7
	rw7yfruJDH124Zf9jG+YnvyNjWqO2HMPYMnHXsXQi
X-Received: by 2002:a05:6808:250b:b0:44f:f025:303e with SMTP id
 5614622812f47-45efc123232mr169916b6e.6.1769484177716; Mon, 26 Jan 2026
 19:22:57 -0800 (PST)
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
From: Jose Zhang <nelsonmv692d@gmail.com>
Date: Tue, 27 Jan 2026 10:22:45 +0700
X-Gm-Features: AZwV_QjkcXA6wsJU2X6tHkH59vEE8EnebG15ZUDTYHZ4Y9ClJaFEyxX39ntx3CE
Message-ID: <CABLTnXFpcQJB6iaccarDSC6=f5OUg_ATXTswu4YVR9=BnTZKwg@mail.gmail.com>
Subject: =?UTF-8?B?5aSn6ZmG5Y+R546w5LqU5Y2B5LqM56eN6Ie055mM5qSN54mp5ZG85ZCB5rCR5LyX5Yqg?=
	=?UTF-8?B?5Lul5riF55CG?=
To: gsjingjixueyuan@163.com, linux-erofs@lists.ozlabs.org, 
	alexander.dahlberg@sigma.se, bshjs@xidian.edu.cn
Content-Type: multipart/alternative; boundary="000000000000d9399306495623ce"
X-Spam-Status: No, score=2.3 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.01 / 15.00];
	FUZZY_DENIED(9.11)[1:787d95bcbb:0.75:txt];
	MAILLIST(-0.19)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	TAGGED_FROM(0.00)[bounces-2219-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,lists.ozlabs.org,sigma.se,xidian.edu.cn];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:gsjingjixueyuan@163.com,m:linux-erofs@lists.ozlabs.org,m:alexander.dahlberg@sigma.se,m:bshjs@xidian.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nelsonmv692d@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nelsonmv692d@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2404:9400:21b9:f100::1:c];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=2];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sumo.ad:url]
X-Rspamd-Queue-Id: A763F8FA59
X-Rspamd-Action: add header
X-Spam: Yes

--000000000000d9399306495623ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuWcqOWutuS4reenjeakjeiKseiKseiNieiNieaAoeaDheWFu+aAp++8jOay
oeaDs+WIsOWNtOWboOS4uumVv+acn+WQuOWFpeiHtOeZjOeJqei0qOiHtOe9ueeZjOeXh++8jOWk
p+mZhumihOmYsuWMu+enkemZoueXheavkuaJgOWPkeWHuuitpuiur++8jOWRvOWQgeawkeS8l+mS
iOWvueWPmOWPtuacqOOAgemTgea1t+ajoOOAgemHkeaenOamhOetieS6lOWNgeS6jOenjeiHtOeZ
jOakjeeJqe+8jOWwvemAn+KAnOa4heeQhumXqOaIt+KAneiHquS/neOAgg0KDQrmlrDljY7nvZHo
vazovb3ljJfkuqzmmajmiqXmiqXlr7zmjIflh7rvvIzlpKfpmYbpooTpmLLljLvnp5HpmaLnl4Xm
r5LmiYDpmaLlo6vmm77mr4Xlr7nigJzmpI3nianmiYDlkKvnianotKjnmoTkv4PnmYzkvZznlKji
gJ3ov5vooYznoJTnqbbvvIzlnKjkuIDljYPlha3nmb7kuZ3ljYHkuInnp43mpI3nianlj4rkuK3o
jYnoja/kuK3mo4Dpqozlh7rljYHlhavnp5HjgIHkupTljYHkuoznp43mpI3nianlkKvmnInoh7Tn
mYznianotKjvvIzov5nkupvmpI3nianlpJrlsZ7lpKfmiJ/np5HjgIHnkZ7pppnnp5HvvIzku6Tk
urrmg4rorrbnmoTmmK/ljIXmi6zpk4Hmtbfmo6DjgIHlj5jlj7bmnKjjgIHph5HmnpzmpoTov5nn
sbvlrrbkuK3miJblhazlm63ph4zluLjop4HnmoTop4LotY/mgKfoirHmnKjvvIzkuZ/pg73lkKvm
nInoh7TnmYznianotKjjgIINCg0K6Ie055mM5qSN54mp6K+x5Y+R6by75ZK955mM5ZKM6aOf566h
55mM55qE5a6e6aqM5bey5b6X5Yiw6K+B5a6e77yM5a6D5Lus5LiN5LuF5rWR6Lqr5LiK5LiL6YO9
5bim4oCc5q+S4oCd77yM6ICM5LiU56eN6L+H6L+Z57G75qSN54mp55qE5Zyf5aOk5Lmf6KKr5qOA
5rWL5Ye65ZCr5pyJ6Ie055mM55eF5q+S5ZKM5YyW5a2m6Ie055mM54mp55qE5r+A5rS754mp6LSo
44CC5aaC5p6c5a6k5YaF56eN5pyJ6L+Z57G75qSN54mp77yM5Lq65L2T5Y+v6IO95Zug5Li66ZW/
5pyf5ZC45YWl6Iqx57KJ44CB5bCY5Zyf6aKX57KS562J5Y6f5Zug5byV5Y+R55mM55eH44CCDQoN
Cui/meS6m+S/oeaBr+WNgeWIhuePjei0te+8jOivt+WKoeW/heafpeeci+WujOaVtOWGheWuue+8
gQ0KDQpodHRwczovL3N1bW8uYWQvZmF4aWFuLTUyLXpob25nLXpoaWFpLXpoaXd1DQoNCuelneS9
oOWSjOS9oOeahOWutuS6uuWlvei/kO+8gQ0KDQotLS0NCg0K5Lq65b+D5ZCR5ZaE77yM5pyq5p2l
5Y+v5pyfDQo=
--000000000000d9399306495623ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1z
aXplOm1lZGl1bSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9wPjxwIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPuWcqOWutuS4reenjeakjeiKseiK
seiNieiNieaAoeaDheWFu+aAp++8jOayoeaDs+WIsOWNtOWboOS4uumVv+acn+WQuOWFpeiHtOeZ
jOeJqei0qOiHtOe9ueeZjOeXh++8jOWkp+mZhumihOmYsuWMu+enkemZoueXheavkuaJgOWPkeWH
uuitpuiur++8jOWRvOWQgeawkeS8l+mSiOWvueWPmOWPtuacqOOAgemTgea1t+ajoOOAgemHkeae
nOamhOetieS6lOWNgeS6jOenjeiHtOeZjOakjeeJqe+8jOWwvemAn+KAnOa4heeQhumXqOaIt+KA
neiHquS/neOAgjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250LXNp
emU6bWVkaXVtIj7mlrDljY7nvZHovazovb3ljJfkuqzmmajmiqXmiqXlr7zmjIflh7rvvIzlpKfp
mYbpooTpmLLljLvnp5HpmaLnl4Xmr5LmiYDpmaLlo6vmm77mr4Xlr7nigJzmpI3nianmiYDlkKvn
ianotKjnmoTkv4PnmYzkvZznlKjigJ3ov5vooYznoJTnqbbvvIzlnKjkuIDljYPlha3nmb7kuZ3l
jYHkuInnp43mpI3nianlj4rkuK3ojYnoja/kuK3mo4Dpqozlh7rljYHlhavnp5HjgIHkupTljYHk
uoznp43mpI3nianlkKvmnInoh7TnmYznianotKjvvIzov5nkupvmpI3nianlpJrlsZ7lpKfmiJ/n
p5HjgIHnkZ7pppnnp5HvvIzku6Tkurrmg4rorrbnmoTmmK/ljIXmi6zpk4Hmtbfmo6DjgIHlj5jl
j7bmnKjjgIHph5HmnpzmpoTov5nnsbvlrrbkuK3miJblhazlm63ph4zluLjop4HnmoTop4LotY/m
gKfoirHmnKjvvIzkuZ/pg73lkKvmnInoh7TnmYznianotKjjgII8L3A+PHAgY2xhc3M9ImdtYWls
LWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1
b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1zaXplOm1lZGl1bSI+6Ie055mM5qSN54mp6K+x5Y+R
6by75ZK955mM5ZKM6aOf566h55mM55qE5a6e6aqM5bey5b6X5Yiw6K+B5a6e77yM5a6D5Lus5LiN
5LuF5rWR6Lqr5LiK5LiL6YO95bim4oCc5q+S4oCd77yM6ICM5LiU56eN6L+H6L+Z57G75qSN54mp
55qE5Zyf5aOk5Lmf6KKr5qOA5rWL5Ye65ZCr5pyJ6Ie055mM55eF5q+S5ZKM5YyW5a2m6Ie055mM
54mp55qE5r+A5rS754mp6LSo44CC5aaC5p6c5a6k5YaF56eN5pyJ6L+Z57G75qSN54mp77yM5Lq6
5L2T5Y+v6IO95Zug5Li66ZW/5pyf5ZC45YWl6Iqx57KJ44CB5bCY5Zyf6aKX57KS562J5Y6f5Zug
5byV5Y+R55mM55eH44CCPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZv
bnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2Zv
bnQtc2l6ZTptZWRpdW0iPui/meS6m+S/oeaBr+WNgeWIhuePjei0te+8jOivt+WKoeW/heafpeec
i+WujOaVtOWGheWuue+8gTwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtm
b250LXNpemU6bWVkaXVtIj48YSBocmVmPSJodHRwczovL3N1bW8uYWQvZmF4aWFuLTUyLXpob25n
LXpoaWFpLXpoaXd1IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9zdW1vLmFkL2ZheGlhbi01Mi16
aG9uZy16aGlhaS16aGl3dTwvYT48L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHls
ZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAs
MCk7Zm9udC1zaXplOm1lZGl1bSI+56Wd5L2g5ZKM5L2g55qE5a625Lq65aW96L+Q77yBPC9wPjxw
IGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlOSIgc3R5bGU9ImZvbnQtc2l6ZToxMS41cHQ7Y29sb3I6
cmdiKDkxLDEwMiwxMTYpIj4tLS08L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxNCIgc3R5
bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwx
MjMsMjU1KTtmb250LXNpemU6bWVkaXVtIj7kurrlv4PlkJHlloTvvIzmnKrmnaXlj6/mnJ88L3A+
PC9kaXY+DQo=
--000000000000d9399306495623ce--

