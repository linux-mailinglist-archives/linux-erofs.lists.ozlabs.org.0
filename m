Return-Path: <linux-erofs+bounces-3493-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH2vE9JDHWpbXwkAu9opvQ
	(envelope-from <linux-erofs+bounces-3493-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Jun 2026 10:33:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A461B842
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Jun 2026 10:33:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTRsg6TKyz2xqn;
	Mon, 01 Jun 2026 18:27:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.192.252.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780302455;
	cv=none; b=OHQV/6vl9TgWqoYC6PGmWvkeolrMKdSJ+Z+xTizK8fiU/NJGS45Ix8a522pN7EHky80Tu4BC6jLQXsxs4QmdZx6IPejiMNmeEekEevr9c3sWNrNDKLPEwQhfmRhDy37X2JSzZdNQDRbkJ/h8r799Hwzp0Bt+xN4bhpLNZpDN4uTVUlBoa3wuUxZF4LEi3Dsfa2ULueG58K+WZIcnXIqFzIbSndFxesYNPr24sTllArrDq7qIb6IQ7lUA21VcaZxwIJkadMozp3j5jNZEIRC2MsV5MsTTjqiQWg6m8Mi1sO8XnNJvTQzFws+tS8zTrGKyH7LrKKVcQFOShZIbsPBWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780302455; c=relaxed/relaxed;
	bh=Doj4hb6TYVHp/2KUkPFOCMSDnF2lAIxvGoczv8pZd3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Olzq+tiz3Ia+XTXQu/pJLLkZwdWDQyWliix60iNhcmdo8UfusfUpITs4Fz/ZjLDL+qU1ZsE3kQfE9SPHOfo7MqpYEUgPTRXQ/welJ62Okp1u0FMsLhDMIZWXpxDywFwgcuBH5/I7IwqvtL6ghd5WlEb0TZfURdybQgg0AGJt4OEqjNn79IzuIwgx2k92Zj3Bbsfzj29OnhW5/02BtEQHMOOLRBauHp3RLSOsXPZbw+LOPjBlAo6Hw0SAygkcW//Fai4+8SIytJjTKKb3vIVd85EEN2/sj5G9gaUZ0eFKwAia8n3Zy8yYVKzxcoKpnxVKrkqQkEYDjHSIV08mdQUHoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaynakdunyasi.com; dkim=fail header.d=kaynakdunyasi.com header.i=@kaynakdunyasi.com header.a=rsa-sha256 header.s=202409 header.b=mFF7MTPi reason="key not found in DNS"; dkim-atps=neutral; spf=none (client-ip=212.192.252.199; helo=ns1.etagram.com; envelope-from=cevdet@kaynakdunyasi.com; receiver=lists.ozlabs.org) smtp.mailfrom=kaynakdunyasi.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaynakdunyasi.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=kaynakdunyasi.com header.i=@kaynakdunyasi.com header.a=rsa-sha256 header.s=202409 header.b=mFF7MTPi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=kaynakdunyasi.com (client-ip=212.192.252.199; helo=ns1.etagram.com; envelope-from=cevdet@kaynakdunyasi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 166378 seconds by postgrey-1.37 at boromir; Mon, 01 Jun 2026 18:27:33 AEST
Received: from ns1.etagram.com (Vasita360.com [212.192.252.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTRsd1WMYz2xdh
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Jun 2026 18:27:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kaynakdunyasi.com;
	s=202409; t=1780129734;
	bh=Doj4hb6TYVHp/2KUkPFOCMSDnF2lAIxvGoczv8pZd3I=;
	h=Reply-To:From:To:Subject:Date:From;
	b=mFF7MTPiVPmjTqhejz5rnCIc9+7L9D4Ws6wwdK9FOG6F9SKoqtrnPVNBzueniP6JD
	 WkgSLglv8gKKb+vxNmlmWSzIzbmhtncrjWK2tkbBjCt03rakLmCcxQpmkI4ijcOPps
	 UfTu88KINUeFAvWs46+Sybfa7p2qBSrIElMjj6E3a1MxKFehOgLaxlGVvPoTU+TeND
	 QgJ+5ix1j38CTjF/gY2ewQvVhEttgJdHiHtOIAzbhH5a3KAxgBHZdK1WUOnMha0EyB
	 Na2ZbOFS8m/sGPOIbzV8I4bNvmIeS1A2gKx/wVJQkNIwrkd7M8zmwlH8XXEiGfQ0yw
	 etMCmHGEsSXYA==
Received: from unn-149-22-87-14.datapacket.com (unknown [151.240.95.117])
	by ns1.etagram.com (Postfix) with ESMTPSA id 27F79268F6E
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 May 2026 11:28:52 +0300 (+03)
Reply-To: mckenzie.scott@tutanota.com
From: "MacKenzie Scott" <cevdet@kaynakdunyasi.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: 
Date: 30 May 2026 01:28:51 -0700
Message-ID: <20260530011601.0EEB5B33274AF079@kaynakdunyasi.com>
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
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HTML_MESSAGE,LOTS_OF_MONEY,MIME_HTML_ONLY,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [14.60 / 15.00];
	FUZZY_DENIED(11.99)[1:06f0f997e4:1.00:txt];
	FAKE_REPLY(1.00)[];
	DATE_IN_PAST(1.00)[48];
	SUBJECT_ENDS_SPACES(0.50)[];
	MIME_HTML_ONLY(0.20)[];
	MAILLIST(-0.19)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3493-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kaynakdunyasi.com:~];
	DMARC_NA(0.00)[kaynakdunyasi.com];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:~];
	R_DKIM_PERMFAIL(0.00)[kaynakdunyasi.com:s=202409];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[mckenzie.scott@tutanota.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.797];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cevdet@kaynakdunyasi.com,linux-erofs@lists.ozlabs.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2404:9400:21b9:f100::1:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kaynakdunyasi.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 5B4A461B842
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

<html><head>
<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.10570.1001">
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><p>Hello,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; <br>
I'm MacKenzie Scott, the ex-wife of Jeff Bezos, the CEO and founder of Amaz=
on, I'm donating a grant to you, I've donated $19 billion dollars to charit=
ies, individuals, colleges across the Globe from Scott's foundation, to pro=
vide immediate support to people suffering economically from COVID-19 pande=
mic and you're one of the lucky winners, I have a donation grant worth $100=
,800,000.00 dollars for you, you can contact me for more information if you=
're interested.</p><p>Regards,<br>
MacKenzie Scott.</p></body></html>

