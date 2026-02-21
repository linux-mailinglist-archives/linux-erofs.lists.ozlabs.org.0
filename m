Return-Path: <linux-erofs+bounces-2342-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9tSWBf7EmWmQWgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2342-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Feb 2026 15:45:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D891A16D0C8
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Feb 2026 15:45:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fJ8zR4WKTz2yrn;
	Sun, 22 Feb 2026 01:45:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771685107;
	cv=pass; b=TXEnpCPbI0U8g/mClVti5TfCaarfd8lLiD3VC3AVHRpFG1mTP4i5eb2twxvY8aL82MxBW4LR0zDVDHePGWyB9fOJOoDZ7AAzhh6Hg72pwA/ZcZsRPHjhQ99BktMR89X+EdoBK10+FmXcWCrFS+m4YL7G7asD1it0yaX3CSLykKFz58ER+OTiVwf//6dUvx4q3WcRyGPwaiJsxyvt3MFvCcPsrM6g8G9Iobdg3v5WW7ICc2A+OBhVCXUXO/kSbdhyqhaCYJpI5qZt1e5OcQSjPbGGyuTwwpEcLtWrHITX/xaolChisojfhE56J24RW2/qr7GQK+YZ2/kMrv4AkvPGOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771685107; c=relaxed/relaxed;
	bh=0hcc3UIJWlRGIkw1audMXnwENwCTty4kBzpeXZoXMfY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KZKHzoOqDVdcGI2FyXus81LGwofJWWo+pu0qfq/LfXWndnqjeUgjAGjnoFadKNGz3PnlbvlQntBarjpMm+8ehnOehJRraNFxvN0iXRctYO1u5U1xvWp3pFqcgH+vQXO6uemC9fRa5/X6wkWUUy29+GQvTEEnRroPmcfyKY1/NYOe6jjkLM0lXzV1UE+rnFjjmBy12S1BCfPHMtTYxwgY6TJHg+I2PY1DCOR/50EKIlo5KFC5CuO/OeCdpw913BTeSAApCSYZz/miSfKmIKzRFyOatK+vGs34nXyGhGvBX26I1i8LJb0Dr05iZ45bPp2O3nkOZ3rg14UOqOMc8aNKdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NQktMWF8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=canyu3411@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NQktMWF8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=canyu3411@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fJ8zP2C9lz2xm5
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Feb 2026 01:45:04 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-354a2d107bfso1228528a91.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Feb 2026 06:45:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771685101; cv=none;
        d=google.com; s=arc-20240605;
        b=Ntio9IeeqyFcCpwSXcV2EueUAQmiXwsysx202zXjqMOeQBpyvZvikpPXqsuHILk6aq
         Fyuq/UVgYVldf4KYPPQrQdqRJdAxI9teUkqB+CqHWZ4dOnqRiuWF17T4esfyVHxlDttS
         B5GBkSRyE/sHBmQvEWb9KBc0pKlOQo33VGu9tuoLPxCDCru9bFJaahHlhygU07y8KTDA
         gIN5I7Bh1H3dCQRDsAuC5R35Fri2mCmkGKPUd1yvzA2pytBxzQEVsHVtznbrkK/C6GPc
         EecGScQdgW3bfLQW+flMUhG7D4FH3J/1ZgwQka53Mr5dCfX0juLpWaVeRffWV4ZRJuAC
         Bgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:sender:mime-version:dkim-signature;
        bh=0hcc3UIJWlRGIkw1audMXnwENwCTty4kBzpeXZoXMfY=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=UctkZ+YvQYtsAnsyEY7tiiUhudISgxPRYZgVR8Rn4cG0a4JyqnYRR95qhoskB2OrEM
         N2aaWvDkbZFRhVFQqGBJTtEvcxfSXvmRMy59DvX5hq4oIN/2/10EK0nqllCvSI/WuhnC
         UVoLUnX0+irJYtoLK04w9c/fJpUWPLHw5rSfWQGdDtICHb0tN1x2pt54ZNSjGWN5yMLW
         U2qfyke9p//XVqY0Nkl0gWgkVcoFTwJxIi02oeqyfWfChjUbpIR/4GGzGGbMhsW6J9lp
         V30WW0qnotKKUODyxEPoJwFmDbPzu7rEby+HPZjIqPj0cyQ1w6dV6tryvsh1gZg0KgSU
         qjMg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771685101; x=1772289901; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hcc3UIJWlRGIkw1audMXnwENwCTty4kBzpeXZoXMfY=;
        b=NQktMWF89SJscOkORSKri6rawp5iQKE22ckVD0EbAe564763hq8uY1kdtfNvFzWUgJ
         OPY90hTt/DLeuXwUfhKDuVYaBWRYgJ+GI9lvt1Sp0cqEPT78MYAzEVCC/kd6pfFi11Og
         0asV0CR0r0bgkcOknkWUDRBHQrULhrTvfUj4DHOeLfIpasjHhbJwvJ37sps1s2nFtlyl
         B4ywTAtzo52zKr586zQ4wcdok+YgKLEgxc+SGBgnsrui9gUlm3g3j8euvYW21grGOeJn
         8yHwAFZCk0o3SM+27+0imvEXPaEWaXs0Xr4PsNESdaKXAIqaBTHXiih+3FQvJncUHbIx
         8Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771685101; x=1772289901;
        h=to:subject:message-id:date:from:sender:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hcc3UIJWlRGIkw1audMXnwENwCTty4kBzpeXZoXMfY=;
        b=BuScg1LgBgnltQyvAa7Aew6kb3PArCAkzZnzaoTd4c3P940iM52rG+s4f1tM8bFj3E
         zUjKuzBZMG48SykYqr72Gvw0y3HhFDSKJ+Da39OMKQV/E7vvTls+rpJyFfYIxiRJW3z/
         B0kKSozxz5ODswwrgheqy/BO9jMz973H1p/UMVQKteULjVa6B2QZsCIRN2P1gHLRG658
         h9yvVzwebaIiE8oyaMARJYuj6x/HFcvN2c0pp2XQVLKxKjs98C0Nm9dQ3EYZlhcEiqQd
         NpETCyCKB22wMJUMtWd5KpmyV+M1knOdb+UA9oZZUrhFKR4ZGrM9ZwpXSQbu4zrn7Wyp
         /d2g==
X-Gm-Message-State: AOJu0YyyaebGSQSMIDtfnUjDe3lHtfahXWwl5Rx3zLCanHZLbHSD+asW
	CuZguj4NIiajUva1ISHFO/OqdRaDLPn8/iAXd1mODssouYgplMUPa/Uco+Rf02iC0ahZuR7vJC9
	rHxMQt3tm5j7l5IEE/1lyLQYlxA8Y5QgtPrRL3F5rxx6U
X-Gm-Gg: AZuq6aIc8EiLtWi8eIFvbgaO0waIlAR4K4VkOJsStHMJ5XhvMgQLzP6ZjKXSHHnfmf+
	rTiBG1f8V8wUHQo+WP2gYTJILOb384YMFvcCKbdm8idpDhl3SWWMxpi3WwgZn3p0KZvH4eHlHkR
	Hfa502ITVe6Qmv2ELaVKql0j2CfdM+0hhcbzv9yxT5dm6W0eXgy004BXo0S2Zvb6Hkknp/j9yf5
	RupS4e2Gat9Otgwm080tdJf7kTItXDJxRYdlz51S2H3Ub4Mf3tYJwdDmR7h4D5l0Ke92etw1uae
	0Mom5j36na+1RKheRQ==
X-Received: by 2002:a17:90b:4a03:b0:354:bfb7:db1a with SMTP id
 98e67ed59e1d1-358ae8eb3c1mr2564007a91.31.1771685100738; Sat, 21 Feb 2026
 06:45:00 -0800 (PST)
Received: from 1062442478371 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Feb 2026 08:45:00 -0600
Received: from 1062442478371 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Feb 2026 08:45:00 -0600
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
Sender: canyu3411@gmail.com
From: canyu3411@gmail.com
Date: Sat, 21 Feb 2026 08:45:00 -0600
X-Google-Sender-Auth: d7CV-vbHmNVSjEcEly_VM0V0iZ8
X-Gm-Features: AaiRm53nuSA3d4JuwjSHuL8yU2lkx3386R7_SEAa3y_UFh2PFfoOPb5O8NXlBAw
Message-ID: <CAFCWvpVztzjWOwOkfGELw64R+rH1AGhNj+H5ySsz+Xp4aKuaWA@mail.gmail.com>
Subject: How do I become exceptional?
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000155fd1064b56957b"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	INTRODUCTION(2.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2342-lists,linux-erofs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[canyu3411@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_SPAM(0.00)[0.945];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linkedin.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D891A16D0C8
X-Rspamd-Action: no action

--000000000000155fd1064b56957b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear EROFS community,

I want to know before I start contributing, how do I go above and beyond
your provided guide to truly get accepted this year for GSoC? Could you
share how previous applicants or current contributors are extraordinary in
the community?

My name is Can (face to a name <https://www.linkedin.com/in/icancode/>), a
CS and Business student in Ireland. I=E2=80=99ve done internships
<https://drive.google.com/file/d/10fbajdcn8WGks-2zmQ_mvwqCSNh_dR84/view?usp=
=3Dsharing>
, research
<https://drive.google.com/file/d/13fLgwVvdrDvJpiEscEYTm7gtIkfrt6Nu/view?usp=
=3Dsharing>
, DSA programming <https://leetcode.com/u/canyu3411/> and I=E2=80=99m ready=
 for my
next endeavour.

That being said, I want to start off at the right foot. That=E2=80=99s why =
I wanted
to reach out before starting; to understand how to be well regarded in the
community, provide true value *beyond the guide*, and to become familiar
with the people, starting from you.

If you think I=E2=80=99m someone who you can see here, I will take your adv=
ice to
heart and start making contributions immediately. Thank you for your time.

Gratefully,

Can Atasever.

--000000000000155fd1064b56957b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"color:rgb(0,0,0)">Dear EROFS community=
,</span><br></div><div><p style=3D"color:rgb(0,0,0)">I want to know before =
I start contributing, how do I go above and beyond your provided guide to t=
ruly get accepted this year for GSoC? Could you share how previous applican=
ts or current contributors are extraordinary in the community?</p><p style=
=3D"color:rgb(0,0,0)">My name is Can (<a href=3D"https://www.linkedin.com/i=
n/icancode/">face to a name</a>), a CS and Business student in Ireland. I=
=E2=80=99ve done<span class=3D"gmail-Apple-converted-space">=C2=A0</span><a=
 href=3D"https://drive.google.com/file/d/10fbajdcn8WGks-2zmQ_mvwqCSNh_dR84/=
view?usp=3Dsharing">internships</a>,<span class=3D"gmail-Apple-converted-sp=
ace">=C2=A0</span><a href=3D"https://drive.google.com/file/d/13fLgwVvdrDvJp=
iEscEYTm7gtIkfrt6Nu/view?usp=3Dsharing">research</a>,<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span><a href=3D"https://leetcode.com/u/canyu3=
411/">DSA programming</a><span class=3D"gmail-Apple-converted-space">=C2=A0=
</span>and I=E2=80=99m ready for my next endeavour.=C2=A0</p><p style=3D"co=
lor:rgb(0,0,0)">That being said, I want to start off at the right foot. Tha=
t=E2=80=99s why I wanted to reach out before starting; to understand how to=
 be well regarded in the community, provide true value <u>beyond the guide<=
/u>, and to become familiar with the people, starting from you.</p><p style=
=3D"color:rgb(0,0,0)">If you think I=E2=80=99m someone who you can see here=
, I will take your advice to heart and start making contributions immediate=
ly. Thank you for your time.<br></p><p style=3D"color:rgb(0,0,0)">Gratefull=
y,</p><p style=3D"color:rgb(0,0,0)">Can Atasever.</p></div></div>

--000000000000155fd1064b56957b--

