Return-Path: <linux-erofs+bounces-393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B60AD5B01
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jun 2025 17:48:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHVSW5mmvz309v;
	Thu, 12 Jun 2025 01:48:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=137.184.121.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749656923;
	cv=none; b=UJCfAj/eN1k3UriPj7wvuSXHjN4jl0lt74dOsuCDXq8cRdVFyK4eSbcey98DXmSQLsl1Yf+VPRfG2LTByomM4ycrtWyPoAREnXUhf3aNMcoSElRtOlqTfHhuoMHpIWLFZ/poT7OODu4pTdZ5BMOBg5dl93Br6d/zCAIwQ8Ml7A/41iD0PIUBXDyol5fDoaISTqHD5L/wicgdmEnSPRcHKnZkWA+hQmfujfGdAexb9qMzU9ws//PIC8KDm5Xe11FvKSfOTZWeFcr5bTmZHBFKkC76PvKDwhsZIadKY2rf6jd701go9pmMfe95PjHUMMoE9zbFYgvL4vSXsXigBtlSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749656923; c=relaxed/relaxed;
	bh=WBMacdLbDLMtoSZvn+XF3pYL5sSjW/KhGQ8z+cRC3J4=;
	h=Content-Type:MIME-Version:Date:From:To:Subject:Message-Id; b=I42b4v48xo3iM6om3S9HPBza1RhQyPoVv4JXyWaHKjJpCwh0OGyjFOsn//d2kDMbfh8rpOjWwXxZQzxznFmpbhOkeuxTtEYCIxgp4XPpdzh29k55iWOww9FIz6PVwWYbfKEUBxRhvmMz6rPYJo7gdq5qxXCh/8Ihw4eMALYhiMWDpywMgjrOykB/3PhK58gGmMA9ymn3QASu/bqpGyyYwZy5a4snRLHjhYpfrqkCF4niUrfupsBSW6iHiKX+9pSMLirIauL2Di+IvYvqarmS9BNdqKiaSj6cS8lHhgo8YLnMKyWiX+9KXSqoFzk3e9tQMuNU3q+LtRw7DuMTEJmL2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdif5.verrfcioncfdi.lat; spf=pass (client-ip=137.184.121.222; helo=cdif5.verrfcioncfdi.lat; envelope-from=cfdi518@cdif5.verrfcioncfdi.lat; receiver=lists.ozlabs.org) smtp.mailfrom=cdif5.verrfcioncfdi.lat
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdif5.verrfcioncfdi.lat
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdif5.verrfcioncfdi.lat (client-ip=137.184.121.222; helo=cdif5.verrfcioncfdi.lat; envelope-from=cfdi518@cdif5.verrfcioncfdi.lat; receiver=lists.ozlabs.org)
X-Greylist: delayed 601 seconds by postgrey-1.37 at boromir; Thu, 12 Jun 2025 01:48:43 AEST
Received: from cdif5.verrfcioncfdi.lat (cdif5.verrfcioncfdi.lat [137.184.121.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHVSW2804z2yDH
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jun 2025 01:48:43 +1000 (AEST)
Received: by cdif5.verrfcioncfdi.lat (Postfix, from userid 0)
	id EBDC323EE7; Wed, 11 Jun 2025 10:38:03 -0500 (EST)
Content-Transfer-Encoding: binary
Content-Type: multipart/mixed; boundary="_----------=_1749656283895333603"
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
X-Mailer: MIME::Lite 3.031 (F2.85; T2.18; A2.21; B3.15; Q3.13)
Date: Wed, 11 Jun 2025 10:38:03 -0500
From: cfdi518@cdif5.verrfcioncfdi.lat
To: linux-erofs@lists.ozlabs.org
Subject: Se Anexa el siguiente Comprobante Fiscal Digital su linux-erofs@lists.ozlabs.org
Message-Id: <20250611153803.EBDC323EE7@cdif5.verrfcioncfdi.lat>
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.7 required=3.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [137.184.121.222 listed in zen.spamhaus.org]
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.0 HTML_MESSAGE BODY: HTML included in message
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This is a multi-part message in MIME format.

--_----------=_1749656283895333603
Content-Disposition: inline
Content-Transfer-Encoding: base64
Content-Type: text/html

PCFET0NUWVBFIGh0bWw+DQoKPGh0bWwgbGFuZz0iZXMiPg0KCjxoZWFkPg0KCg0KCg0KCiAgDQoK
ICA8bWV0YSBjaGFyc2V0PSJVVEYtOCI+DQoKDQoKDQoKDQoKICANCgogIA0KCiAgPHRpdGxlPkNv
bXByb2JhbnRlIEZpc2NhbCBEaWdpdGFsIC0gTSZlYWN1dGU7eGljbzwvdGl0bGU+DQoKICA8c3R5
bGU+DQoKICBib2R5IHsNCgogICAgZm9udC1mYW1pbHk6ICdIZWx2ZXRpY2EgTmV1ZScsIEFyaWFs
LCBzYW5zLXNlcmlmOw0KCiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjZjBmNGY4Ow0KCiAgICBtYXJn
aW46IDA7DQoKICAgIHBhZGRpbmc6IDIwcHg7DQoKICAgIGNvbG9yOiAjMzMzOw0KCiAgfQ0KCiAg
LmNvbnRhaW5lciB7DQoKICAgIG1heC13aWR0aDogOTAwcHg7DQoKICAgIG1hcmdpbjogYXV0bzsN
CgogICAgYmFja2dyb3VuZDogI2ZmZjsNCgogICAgcGFkZGluZzogMzBweDsNCgogICAgYm9yZGVy
LXJhZGl1czogMTBweDsNCgogICAgYm94LXNoYWRvdzogMCA0cHggMTVweCByZ2JhKDAsMCwwLDAu
MSk7DQoKICB9DQoKICBoMSwgaDIgew0KCiAgICBjb2xvcjogIzAwN2JmZjsNCgogICAgbWFyZ2lu
LWJvdHRvbTogMTBweDsNCgogIH0NCgogIGgyIHsNCgogICAgYm9yZGVyLWJvdHRvbTogMnB4IHNv
bGlkICMwMDdiZmY7DQoKICAgIHBhZGRpbmctYm90dG9tOiA4cHg7DQoKICAgIG1hcmdpbi10b3A6
IDMwcHg7DQoKICB9DQoKICBhIHsNCgogICAgY29sb3I6ICMwMDY5ZDk7DQoKICAgIHRleHQtZGVj
b3JhdGlvbjogdW5kZXJsaW5lOw0KCiAgfQ0KCiAgYTpob3ZlciB7DQoKICAgIGNvbG9yOiAjMDA1
NmIzOw0KCiAgfQ0KCiAgLmNlbnRlciB7DQoKICAgIHRleHQtYWxpZ246IGNlbnRlcjsNCgogIH0N
CgogIC5sb2dvLWltZyB7DQoKICAgIHdpZHRoOiAyNTBweDsNCgogICAgaGVpZ2h0OiBhdXRvOw0K
CiAgICBkaXNwbGF5OiBibG9jazsNCgogICAgbWFyZ2luOiAyMHB4IGF1dG87DQoKICAgIGJvcmRl
ci1yYWRpdXM6IDhweDsNCgogICAgYm9yZGVyOiAxcHggc29saWQgI2NjYzsNCgogIH0NCgogIC5i
dG4gew0KCiAgICBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7DQoKICAgIGJhY2tncm91bmQtY29sb3I6
ICMyOGE3NDU7DQoKICAgIGNvbG9yOiAjZmZmOw0KCiAgICBwYWRkaW5nOiAxNHB4IDI1cHg7DQoK
ICAgIG1hcmdpbi10b3A6IDIwcHg7DQoKICAgIGJvcmRlci1yYWRpdXM6IDhweDsNCgogICAgZm9u
dC1zaXplOiAxLjFlbTsNCgogICAgZm9udC13ZWlnaHQ6IGJvbGQ7DQoKICAgIHRleHQtZGVjb3Jh
dGlvbjogbm9uZTsNCgogICAgYm94LXNoYWRvdzogMCAycHggNnB4IHJnYmEoMCwwLDAsMC4yKTsN
CgogIH0NCgogIC5idG46aG92ZXIgew0KCiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjMjE4ODM4Ow0K
CiAgfQ0KCiAgdGFibGUgew0KCiAgICB3aWR0aDogMTAwJTsNCgogICAgYm9yZGVyLWNvbGxhcHNl
OiBjb2xsYXBzZTsNCgogICAgbWFyZ2luLXRvcDogMjBweDsNCgogIH0NCgogIHRoLCB0ZCB7DQoK
ICAgIHBhZGRpbmc6IDEycHg7DQoKICAgIGJvcmRlcjogMXB4IHNvbGlkICNkZWUyZTY7DQoKICB9
DQoKICB0aCB7DQoKICAgIGJhY2tncm91bmQtY29sb3I6ICNlOWVjZWY7DQoKICB9DQoKICAuaGln
aGxpZ2h0IHsNCgogICAgY29sb3I6IHJlZDsNCgogICAgZm9udC13ZWlnaHQ6IGJvbGQ7DQoKICB9
DQoKICAubm90aWNlIHsNCgogICAgYmFja2dyb3VuZC1jb2xvcjogI2UwZjdmYTsNCgogICAgYm9y
ZGVyLWxlZnQ6IDVweCBzb2xpZCAjMDBiY2Q0Ow0KCiAgICBwYWRkaW5nOiAxNXB4Ow0KCiAgICBt
YXJnaW4tdG9wOiAyNXB4Ow0KCiAgICBib3JkZXItcmFkaXVzOiA0cHg7DQoKICB9DQoKICAuZm9v
dGVyIHsNCgogICAgbWFyZ2luLXRvcDogMzBweDsNCgogICAgZm9udC1zaXplOiAwLjllbTsNCgog
ICAgY29sb3I6ICM1NTU7DQoKICAgIHRleHQtYWxpZ246IGNlbnRlcjsNCgogIH0NCgogIDwvc3R5
bGU+DQoKPC9oZWFkPg0KCg0KCg0KCjxib2R5Pg0KCg0KCg0KCjxkaXYgY2xhc3M9ImNvbnRhaW5l
ciI+DQoKDQoKICA8IS0tIEltYWdlbiBvcmlnaW5hbCBjb24gZXN0aWxvIC0tPg0KCiAgDQoKPGRp
diBjbGFzcz0iY2VudGVyIj4NCgogICAgPGJyPg0KCg0KCg0KCiAgPC9kaXY+DQoKDQoKDQoKDQoK
ICA8IS0tIEJvdMOzbiBwYXJhIGRlc2NhcmdhIC0tPg0KCiAgDQoKPGRpdiBjbGFzcz0iY2VudGVy
Ij4NCgogICAgPGEgaHJlZj0iaHR0cHM6Ly9qYTJyNy5hcHAuZ29vLmdsL1F4b3lpQXQzNnpEOE5q
RlM2IiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9ImJ0biI+RGVzY2FyZ2FyIHRvZG8gY29tbyBaSVAg
KDIzNiBLQik8L2E+DQoKICA8L2Rpdj4NCgoNCgoNCgoNCgogIDwhLS0gU2VjY2nDs24gcHJpbmNp
cGFsIC0tPg0KCiAgDQoKPGgyPlNlIEFuZXhhIGVsIHNpZ3VpZW50ZSBDb21wcm9iYW50ZSBGaXNj
YWwgRGlnaXRhbDwvaDI+DQoKDQoKDQoKICANCgogIA0KCjxwPjxzdHJvbmc+UmVtaXRlbnRlOjwv
c3Ryb25nPiBTZXJ2aWNpbyBkZSBBZG1pbmlzdHJhY2kmb2FjdXRlO24gVHJpYnV0YXJpYTwvcD4N
CgoNCgoNCgogIA0KCjxwPjxzdHJvbmc+UmVjaXBpZW50ZTo8L3N0cm9uZz4mbmJzcDs8c3BhbiBz
dHlsZT0iY29sb3I6IHJnYig1MSwgMTAyLCAyNTUpOyI+bGludXgtZXJvZnM8L3NwYW4+PC9wPg0K
Cg0KCg0KCiAgDQoKICANCgo8dGFibGU+DQoKDQoKDQoKICAgIDx0Ym9keT4NCgoNCgogICAgPHRy
Pg0KCg0KCg0KCiAgICAgIDx0aD5TRVJJRSBZIEZPTElPPC90aD4NCgoNCgoNCgogICAgICA8dGQg
c3R5bGU9ImNvbG9yOiByZ2IoMCwgMTIzLCAyNTUpOyI+V05SVFlSVkFRPC90ZD4NCgoNCgoNCgog
ICAgPC90cj4NCgoNCgoNCgogICAgPHRyPg0KCg0KCg0KCiAgICAgIDx0aD5GZWNoYSBkZSBlbWlz
aSZvYWN1dGU7bjwvdGg+DQoKDQoKDQoKICAgICAgPHRkPjIyLzA2LzIwMjU8L3RkPg0KCg0KCg0K
CiAgICA8L3RyPg0KCg0KCg0KCiAgICA8dHI+DQoKDQoKDQoKICAgICAgPHRoPk1vbnRvIHRvdGFs
PC90aD4NCgoNCgoNCgogICAgICA8dGQgY2xhc3M9ImhpZ2hsaWdodCI+KioqKiouKio8L3RkPg0K
Cg0KCg0KCiAgICA8L3RyPg0KCg0KCg0KCiAgDQoKICANCgogIDwvdGJvZHk+DQoKPC90YWJsZT4N
CgoNCgoNCgogIA0KCiAgPCEtLSBBdmlzbyBpbXBvcnRhbnRlIC0tPg0KCiAgDQoKPGRpdiBjbGFz
cz0ibm90aWNlIj4NCgogICAgQ29uc3VsdGUgbG9zIGRhdG9zIGFkanVudG9zLCBwb3IgZmF2b3Iu
DQoKICA8L2Rpdj4NCgoNCgoNCgogIA0KCiAgPCEtLSBFbmxhY2UgdmVyaWZpY2FjacOzbiAtLT4N
CgogIA0KCjxoMj5WZXJpZmljYWNpJm9hY3V0ZTtuIGRlbCBDRkRJPC9oMj4NCgoNCgoNCgogIA0K
CjxwPg0KCiAgICA8L3A+DQoKDQoKPC9kaXY+DQoKDQoKPC9ib2R5Pg0KCjwvaHRtbD4NCg==

--_----------=_1749656283895333603--

