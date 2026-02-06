Return-Path: <linux-erofs+bounces-2265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJb6FY90hWlzBwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 05:56:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47762FA2D3
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 05:56:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6hdK4Tc9z2xqk;
	Fri, 06 Feb 2026 15:56:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::944" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770353797;
	cv=pass; b=F5GOfhkMXIGt8XvTSEMrTrHqEYaN7Uf4mqg9C96Lbz5fur9VzGLZQxPvQqGjFbXQknEhSmouwtoIhYZBcMmRLe72pY2s5vLrWsm0Qd3IINVN2pLqQK9B/s1S05/byVSm1ZnTSs6uZ0qZVcZ6CZjmFHVI+9+/Blrk/2lFtOtdjGr6hNqazVGzRqDs9t2dWvx42uEcrwtrfmiGkSRIQ0Y4SC3doZj6AtVpIrZz6OTwrWhNIGS5o09ai6bUUVmdEmbtCNIBPPfcKlkj0vNwbKBVZNFhUZz+j0gAYlfkuGxsI+lysM+Bq0SAkqlnUO7caFR5ruTad3hhYwuF2Unfz+KwLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770353797; c=relaxed/relaxed;
	bh=xJTYZsWEA+DGHU4sguXXrGpw+jrQwxa9LHpUPpBzREQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U2xmYcluf/82qx/o1Ltq69SQTTGCS1sLXRSNUCAZ6HKEewA0FhIAxiyKBdWobRvdwDWiBhHEqlIlvpk+rJbkFNVBVUYxHWtvt8Si7z+hVJYPVdr4eYU2QooBXMKvSPskOsJv4MSK/KCcM3dTXKGUfUzgmdgMXyZiHo6aY7XDummnE2xoV08tyFb1MyKLXUDvahq1ObpFyE4AzTrhAk3dDoOqv9I3oKz7smOGVvnqJb0btUErUzxlOpUZ7xmSxM0vrWmpdgrPLjmI3mkr7H4IAdRzdkSBh0VwQ2u1JxuPVuZAAweL0xi2hoIXs2ZNCcihETXqM8cwI0V9w/ZeEuJisA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hr3HeayM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::944; helo=mail-ua1-x944.google.com; envelope-from=donglanying1275@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hr3HeayM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::944; helo=mail-ua1-x944.google.com; envelope-from=donglanying1275@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6hdH3FjRz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Feb 2026 15:56:34 +1100 (AEDT)
Received: by mail-ua1-x944.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso1011766241.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Feb 2026 20:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770353791; cv=none;
        d=google.com; s=arc-20240605;
        b=dcGrC2k8RWX3eUD8ZblfmW5zMgsFMSj9ZPTzmjSlTmOmtavpgLTK4yaihBc2gb3EZZ
         vGKDhqUkYS9wmLfssEqY/gFPZbfqTLUDp4Hth9LREPA6HLb8MBIP68MPPfYq9hDY++y4
         B8g4KWHphOdtyHOkIvvAiyZChLBkXLCzad5AefvWpM+huXi5Jg4qmX+ICtl+Uye/petC
         y9VAfEi9y1PmeZqOOG6thG91PY8gm08bYUOOglsc6FWyrzCMf8fR6tLU+3Pl5LZMb5fw
         es8+wUAmPlqgUqq0i5ZMVQe7yylqMb1wsnj+Qp+qjWULW55jU8Fst/3l9e0gsQIsCmBo
         xBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xJTYZsWEA+DGHU4sguXXrGpw+jrQwxa9LHpUPpBzREQ=;
        fh=5aAE5Z1692T8FwewqxMLpcNxOGWQyjSn4s1YiMfxyzs=;
        b=K5syDFgXrmjQgNPjfkQxfpnM3uOKIXcTG+LAyIglEz+i4z+ejlGzIv9pTgwBwp4GMz
         Jb5cSTKlZz///GWTxvHRwc100Q1jXra6ES6ByobP2hsnmDHOefxSQkOPB7pFHLIeujPm
         JOTLk3EvcJzKU+RZ/uUPUllC2yeGQzIqGwEUoKOPAwl6ydBqkBgckOhF8bGkunW94nN2
         aCZ++zeRh+YY/i3ZzZnkALVQjetAwFcMewe2vW+8IPSNn0wJllZfw0bJXmfZFibg/2yA
         5SHB4NohxdZyokLdyrB/8cQrbQEFnHTD8YEKcwhRex0ZdcAiOCAG39ax20Zt82MlAmPG
         RCMg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770353791; x=1770958591; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJTYZsWEA+DGHU4sguXXrGpw+jrQwxa9LHpUPpBzREQ=;
        b=Hr3HeayMQovrWz2PRGph/mDBKc13ORyommPj2akUSjfyLuHPtq9l5wvR3ZW+wOk2y7
         1rZqkuD6hclUWCMuDIGalWH6/1nlrcNee24EJj/pz3zxT4R5aXPKCc/HwC23zDiUJ52/
         MS4TyNC0M1H3z+C3hw4W+XuNXX9Gb8piz6NwDxY66EU7/UAoJEImwZkGiIvNFlUqhuMo
         BtxD8QOYcu9yIgp/KG2LuH35gNB7Hk6kwaRkaa86U7fmbsJOWmSGXK9w7MEl25Si9hD/
         PBCPbejmpVtO8Nz/P5ecArKhpKh24OG2c//TYVqbiaTE8ALzi+qTcUZF5St9dunwQsr4
         +Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770353791; x=1770958591;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJTYZsWEA+DGHU4sguXXrGpw+jrQwxa9LHpUPpBzREQ=;
        b=IOdnV8QEdTQ+kE/djgMPmPfkDbaaizIOPlcmWHIT9b9jXY7TEdsSGfGqASz+gJVb+X
         lnb6FpiEK/F2IOVt0QQzWacpc4vwxBb6DdeUZArZXoXYFI2p7Do27UbWq+DUxFvq7aBQ
         +LDxZ66gFB8/ibknmi/nuTJMEEzI9h6UmDV7Y9KiFvnwVr4SyzbkZwlcQvNWY/y9Urn5
         QVvlrRjmf6ZZVJiWksrsS/p1tqMDI8XD0G7YjfmoFhbokCt8yg2N9zP5Nd/nfjiwduTU
         IuZuKMuOPXIoNTDiE1TeqyOfTKbaGaEzgSboRsOk1T4oMXkHaWIGgQM5xi9TKKPgKjZJ
         mFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuDw4dl++W0Qy+oKwpACboj+ceAYYBr5WK5Z1wbmFBAAPKuKQiHdoEnZDt99UuvR4zA2DPW9xYpE4ojA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5ZyvIFdgeLVYLhyij/l5wCixbQty/cgSqSFk4DgEyiysr4WPk
	ifQkbEbJX63KEHu2MalyV9bJr2hyvXqQq98Bdo3H2JmrVtr/xvRCdV2d1x8Q+8zO8SiMb71Un+9
	XsZphSdHzx4xtt99LX2IV/X2UrJcceKA=
X-Gm-Gg: AZuq6aIpzJ/p9ai29ISIP6X0AyR6WKuyXSsOJsICHOuAev5shY9DAm3dxYoHJBnciLj
	1SRGe+2p2Phf7AFrA5bLY0rW61gy6m6XUaAHLbxEzf1ny68HDzQdYPuml7CsSoHnE4DKlUgGXlN
	E8cHsUUAxyAzlv/mrkmJIHTkhtIqrpCto7QwMSgTGPIQEqSZk2s9IS+wMP5U3g7brsFoOeJOgGA
	nLkf9+YiPlx80tJ/KirxBc82hUlGWD/dEqcV3Rh83zEVoDQ14BtzXhArOtbvY598gjTH7pk7p+d
	65zQaAfpKOpElTYXoXoIh2pYNzmWNQLxuL1WyFCSs01meNeCXtc3cgys//WChmkyUeWgi9UuzoP
	50WTwZh+pOQGxK7L46OD385BEm2gaPctCOO3Q6MG3kHOl28ppAntxhNtu2m6OIV3Pbpviret8gA
	pLZt2fTap97L6j9MWYAuNfEZqHS+GGuOgS5YmEA6KLsAwKwxkwJ2qvIn7IFgr1uK2fbSXW9izG
X-Received: by 2002:a05:6102:26d1:b0:5f8:e45d:6438 with SMTP id
 ada2fe7eead31-5fae8a7b297mr346829137.15.1770353790693; Thu, 05 Feb 2026
 20:56:30 -0800 (PST)
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
From: Dong Lanying <donglanying1275@gmail.com>
Date: Fri, 6 Feb 2026 11:56:19 +0700
X-Gm-Features: AZwV_QiBU6ZmkmG24fcFb-gi4tiAK7u8K5lBvYDigjc9iG1JyrTbr5t3pg6_6gY
Message-ID: <CAJqAdtZn1GY_YiRYKArGF_bfadGJiLh-0qbM_7-_+JmjmDmO-g@mail.gmail.com>
Subject: =?UTF-8?B?5L2g5ZCD5a+55Lic6KW/5LqG5ZCX77yf5LiT5a625o+t5LiD5aSn6Ziy55mM6aWu6aOf?=
To: sales-hh@blohmjung.com, xxcmhr@163.com, 13906715120@163.com, 
	linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000d23305064a209c21"
X-Spam-Status: No, score=2.6 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2265-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sales-hh@blohmjung.com,m:xxcmhr@163.com,m:13906715120@163.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[blohmjung.com,163.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[donglanying1275@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donglanying1275@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sumo.ad:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 47762FA2D3
X-Rspamd-Action: no action

--000000000000d23305064a209c21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuaAjuagt+eahOmlrumjn+aWueW8j+aJjeiDveWHj+WwkeeZjOeXh+WPkeeU
n+eahOamgueOh++8jOS7peWPiumBv+WFjeeZjOeXh+WGjeW6puWkjeWPke+8nw0KDQrlj7Dmub7k
ubPnmYzkuJPlrrblvKDph5HlnZrljZrlo6vvvIzlnKjlpKfnuqrlhYPigJzlgaXlurflhbvmiJDo
rrDigJ3oioLnm67kuK3vvIzmj63npLrnmYznl4fnmoTlhbPplK7po47pmanlm6DntKDlj4rkuIPl
pKfpmLLnmYzppa7po5/ljp/liJnjgIINCg0K5byg6YeR5Z2a5Li+5L6L6K+077yM5LiN5ZCM55qE
6aWu6aOf5qih5byP5Y+v6IO95Lya5Lqn55Sf5LiN5ZCM55qE55mM55eH55eF5Y+Y44CCDQoNCui/
meS6m+S/oeaBr+WNgeWIhuePjei0te+8jOivt+WKoeW/heafpeeci+WujOaVtOWGheWuue+8gQ0K
DQpodHRwczovL3N1bW8uYWQvamllbWktcWktemhvbmctZmFuZy1haS15aW5zaGkNCg0K56Wd5L2g
5ZKM5L2g55qE5a625Lq65aW96L+Q77yBDQoNCi0tLQ0KDQrmr4/kuIDku73nnJ/nkIbpg73lgLzl
vpfooqvmjY3ljavvvIzmr4/kuIDku73lhazmraPpg73lgLzlvpfooqvov73msYLjgIINCg==
--000000000000d23305064a209c21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1z
aXplOm1lZGl1bSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9wPjxwIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPuaAjuagt+eahOmlrumjn+aWueW8
j+aJjeiDveWHj+WwkeeZjOeXh+WPkeeUn+eahOamgueOh++8jOS7peWPiumBv+WFjeeZjOeXh+WG
jeW6puWkjeWPke+8nzwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250
LXNpemU6bWVkaXVtIj7lj7Dmub7kubPnmYzkuJPlrrblvKDph5HlnZrljZrlo6vvvIzlnKjlpKfn
uqrlhYPigJzlgaXlurflhbvmiJDorrDigJ3oioLnm67kuK3vvIzmj63npLrnmYznl4fnmoTlhbPp
lK7po47pmanlm6DntKDlj4rkuIPlpKfpmLLnmYzppa7po5/ljp/liJnjgII8L3A+PHAgY2xhc3M9
ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlh
SGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1zaXplOm1lZGl1bSI+5byg6YeR5Z2a5Li+
5L6L6K+077yM5LiN5ZCM55qE6aWu6aOf5qih5byP5Y+v6IO95Lya5Lqn55Sf5LiN5ZCM55qE55mM
55eH55eF5Y+Y44CCPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQt
c2l6ZTptZWRpdW0iPui/meS6m+S/oeaBr+WNgeWIhuePjei0te+8jOivt+WKoeW/heafpeeci+Wu
jOaVtOWGheWuue+8gTwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250
LXNpemU6bWVkaXVtIj48YSBocmVmPSJodHRwczovL3N1bW8uYWQvamllbWktcWktemhvbmctZmFu
Zy1haS15aW5zaGkiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3N1bW8uYWQvamllbWktcWktemhv
bmctZmFuZy1haS15aW5zaGk8L2E+PC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5
bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpyZ2IoMCww
LDApO2ZvbnQtc2l6ZTptZWRpdW0iPuelneS9oOWSjOS9oOeahOWutuS6uuWlvei/kO+8gTwvcD48
cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTkiIHN0eWxlPSJmb250LXNpemU6MTEuNXB0O2NvbG9y
OnJnYig5MSwxMDIsMTE2KSI+LS0tPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMTQiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAs
MTIzLDI1NSk7Zm9udC1zaXplOm1lZGl1bSI+5q+P5LiA5Lu955yf55CG6YO95YC85b6X6KKr5o2N
5Y2r77yM5q+P5LiA5Lu95YWs5q2j6YO95YC85b6X6KKr6L+95rGC44CCPC9wPjwvZGl2Pg0K
--000000000000d23305064a209c21--

