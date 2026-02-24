Return-Path: <linux-erofs+bounces-2378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AImMEto/nWlUNwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 07:06:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C71824B7
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 07:06:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKnKK2P2zz3cG9;
	Tue, 24 Feb 2026 17:06:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771913173;
	cv=pass; b=b7yVSZ8uKYGu7PcSDM3FJAB8A4c8qWzj9Uwh6DW0W/IayDGhXPSJOm4qc8sM01+ZPTOx/6Eb7tWIZjQi87yM4B4BbMw87hDlsm32dt4pZfmGhy5uoWeKZ4nn5IeOUgaxP6ghHPBn5tlMhxxc9vuCuip1vfaQlPi1j9uvRSCZuy8ywJXfAd8M37YVNQRNXDG9nx8M/nzE8gyqiMBfeqEEHGJ8AAYK9iU33GrmhcgaxoSIbzgHMINhgGemx9+VhBMNvs5srxL30BMq42+9l6gFzs5J7ObWTOBQYbJS49r/fitf+7TxKS23HPJucrInrMovubOENL3Dqz6mx/n2ZdT/sQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771913173; c=relaxed/relaxed;
	bh=dklRQUChrJfdsZeX6Sx8QNZvIVZJd98/BrtRVmuWGPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RxVKPvtkvSNg0wWAgTWsk5Jwxq/k/dVAT8iI2o34KV55yKRe24QhGkjbngTAcD8drItIL5Qpvvjs3Ih4eciYB4Q0wawxHttmdORNKn3re+yH6QZTLyRntrvxOTs0oCkUrUg11y/74ewssv/xFcBCBNmLKQHVjr23VKM7Gk6XDXLcUwt3PD2Xy7VD/b5HrhpIcMZyFLNB/TAo59LvutMG7C4uzcMuuvA0uCkdosSfPnVpReeb2pnm+MmAlNsZST4QqDNQQ6C1edwakSbCl9QBP/xHLrUkDvouRLZS4J5a5BY9NDLkQGcZNNO36xkte2HRtevOxSD2ZT3iOa9pwmtAgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gBSQ1tkS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gBSQ1tkS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKnKH55LQz3cFM
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 17:06:11 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-48375f1defeso35773285e9.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Feb 2026 22:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771913168; cv=none;
        d=google.com; s=arc-20240605;
        b=hmf8Lkx+q39k52JCoNhjdaqE0j0MlqSy+6mV+sHbynspr+z4Dfq2mQgropQE0fM2Vl
         Nwy7DB6Ee6CPyqg9yrHhwT/xR0Vvr92mFbHRTD+HSTmKo+zRywqqE8FXzEPwMtdCNT5h
         Fp6ZYiBX/MMXoVlJtQFIssezSxO88R7hywNHx5sg92mguseYFknXp7QUT7M6ZhN7WIZj
         2KB0e2FJ1BdvpKbFj2su3T8FuZMws5wtOULqcmqeUebi2kZVNQ4NKAWo1PbVoahdYrXO
         Uw7zzwyQ0V7Mz5h8Q8ENoknhHVx6plMqcR+q1aXIoosjH5/vMH0tfcm7sK/ILdUW5+i6
         ctUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dklRQUChrJfdsZeX6Sx8QNZvIVZJd98/BrtRVmuWGPs=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=VluE2FBtL9YANTETOv2bpR9R41l4Qgoftr5+Oek+XsDK+xezY6omlpzsszV3yn8HZa
         VFzbOmWbyxQFfjFbDS+wegG/NWHqAsO6J1GybhU3x4XrCWan6889i4DBfR/CuXoHB4Bq
         UNpVqZyPtJpcRSTFR/IY6K5zsp2pwlmsl3oK5XzlCe1PVgiHng8thbepSm18NkY0Tblm
         PbNrFedqMbrRKt3nCUJQPbw51QN8ZycqXcM+qaAku4a6T9gDPOwgHlcMYcCdldttwXXc
         tqKUkACQFArKjhcowp86ja0Z9pteAxmKGz1MiKjaw5ddnPq9fJ6ev0IxcFCv6oqoG/Gx
         0t9A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771913168; x=1772517968; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dklRQUChrJfdsZeX6Sx8QNZvIVZJd98/BrtRVmuWGPs=;
        b=gBSQ1tkSS9WvFklRHu3k366hsu4BGq4MKesizV4VMxAKjyWIciyDHOHInVnyFQ3vqv
         ZkEmYCBmB5xAAVvmlV47CZ1hi8hxv5TPB6hB/Gd48XFiZM3mQcNq+27hRjhY0eTUw/VZ
         O6YgDPc3iUbUxXi0f0eYfC4PGYp8Gi1lvZAG6QOEzPmcUp9hKeBJVv4DQk/pP5nBf/sI
         wQ6yE9H6bceyp8MK+g8zjkWcC+zZcC+2pKUTLjLQ4NkVmyd2QgreX2Qv/cVVJszAgTnw
         yeOKs4gPzmJsd+cDKW/TaMhPI+V6aZUCmC32vfgiKKKbGwj1pUChgqovbv6xi+hamrz/
         F2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913168; x=1772517968;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dklRQUChrJfdsZeX6Sx8QNZvIVZJd98/BrtRVmuWGPs=;
        b=MFNF1T+DwjBgjofoOnVDZ2GcKPflebW3r+vRHz9NSs66VzTHSl0B+VFXj02I8AuuQr
         EHYDRN9uM9XB7CXhsVXG9+IWj8PQvbsGy8ApV7Ov/luKAJidNG/qjsUhcVMAbMxSODQ3
         FCKQICsfHh3Bwo7LQzzvtw14Fu3zSb/bAeLYcHhoQOewby4cJXV9rCiDxFhfRgGPmHZM
         pUrHmOrHhOrFSc39CH6M91wTdw7tkRnWqWkS/RJ3O52YzFcjlTAASgjw3Q9OGJZqG325
         sWn0HxQiv4X9RfXivnD7q5UDfbSShqC5fLcxfMCDLMpHerUyxPvXiUzSyyKbNTxlJRwh
         VLOA==
X-Gm-Message-State: AOJu0YxO7Z2xkYDKv2yuS28A6V2AWDlFcuAiWHMl8F6hprLyrBUUGVxa
	wlX+IJlFR3MPRYQ2pZAymMXgnQGPsPXfDa63VKA5ZxSq5JtfzsIzp6DblciUXdvX3RCkdXJx9mC
	0bdnQWB+qhZpjXCGKZXITlstOgNKt0rTe+9PEM3A=
X-Gm-Gg: AZuq6aIw/AO14WcOoWqbaUJ8TWcYKBok6CUnkoKgcTh3nyFQjS01MC4++GMA+HILe62
	B6sSv0QGJcFnHOVX+5sAjKNU3QE5AQdNG2/hdcMrKzfHJN+QbVRyJ8uJpU5n/u5y0NaQrOkZLkR
	GWINfJYeVVXZkrodE/xmszjPbaYY7OG2kVK4feyED4/NIIBLx7q/8zfhzt/CZZ1USeEOxE/wIwP
	ic+vNwQlsdqJV/20XiFYw5KmgYKXFUoFQgvcnAanI1GY8d6FkUb7988RVSC61rYduamY7ea4+qI
	q+7Fgg==
X-Received: by 2002:a05:600c:19c9:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-483a963d2d9mr152603405e9.30.1771913167566; Mon, 23 Feb 2026
 22:06:07 -0800 (PST)
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
From: Puneeth Aditya <myakampuneeth@gmail.com>
Date: Tue, 24 Feb 2026 11:35:55 +0530
X-Gm-Features: AaiRm51aYG-Utiw2v3-gFq9QqMnxvqXc5qRlFsXyuvcfqUDFiizrfu0T-d-UI94
Message-ID: <CAMdT05qew=4T_ifjH+JTuFqgk6Sy2zRV0TvdBhC9-wtF6dtYrA@mail.gmail.com>
Subject: 
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000ecfb20064b8baeb1"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	FREEMAIL_REPLY,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	EMPTY_SUBJECT(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2378-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.547];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myakampuneeth@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 634C71824B7
X-Rspamd-Action: no action

--000000000000ecfb20064b8baeb1
Content-Type: text/plain; charset="UTF-8"

hi everyone,

i am puneeth aditya (mugiwaraluffy56 github), an undergrad student
interested in contributing to erofs as part of GSoC 2026. i just sent my
first patch to the list today (blobchunk: fix 48-bit format detection to
use final remapped block addresses, message id
20260224055712.14110-1-myakampuneeth@gmail.com) and have been spending the
past week going through the erofs-utils codebase to understand how things
fit together.

i went through the roadmap at erofs.docs.kernel.org and i am particularly
interested in the multi-threaded userspace decompression work. the current
single-threaded decompression path is a real bottleneck on large images and
i think there is good scope for a structured GSoC project around it.

would love any guidance on what a good proposal would look like, and
whether there are specific parts of the decompression pipeline you would
want a GSoC contributor to focus on first.

thanks, puneeth aditya

--000000000000ecfb20064b8baeb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-messagesContainer_07S1Yg" style=3D"ove=
rflow:hidden auto;display:flex;background-color:rgb(1,4,9);min-width:0px;pa=
dding:20px 20px 40px"><div class=3D"gmail-message_07S1Yg gmail-timelineMess=
age_07S1Yg" style=3D"color:rgb(230,237,243);display:flex;padding:8px 0px 8p=
x 30px"><span class=3D"gmail-root_-a7MRw" style=3D"overflow-x:hidden;width:=
1142px"><p style=3D"margin-top:0.1em;margin-bottom:0.2em">hi everyone,</p><=
p style=3D"margin-top:0.1em;margin-bottom:0.2em">i am puneeth aditya (mugiw=
araluffy56 github), an undergrad student interested in contributing to erof=
s as part of GSoC 2026. i just sent my first patch to the list today (blobc=
hunk: fix 48-bit format detection to use final remapped block addresses, me=
ssage id <a href=3D"mailto:20260224055712.14110-1-myakampuneeth@gmail.com" =
target=3D"_blank" rel=3D"noopener noreferrer" style=3D"color:rgb(47,129,247=
);text-decoration-line:initial;text-decoration-color:rgb(47,129,247)">20260=
224055712.14110-1-myakampuneeth@gmail.com</a>) and have been spending the p=
ast week going through the erofs-utils codebase to understand how things fi=
t together.</p><p style=3D"margin-top:0.1em;margin-bottom:0.2em">i went thr=
ough the roadmap at <a href=3D"http://erofs.docs.kernel.org">erofs.docs.ker=
nel.org</a> and i am particularly interested in the multi-threaded userspac=
e decompression work. the current single-threaded decompression path is a r=
eal bottleneck on large images and i think there is good scope for a struct=
ured GSoC project around it.</p><p style=3D"margin-top:0.1em;margin-bottom:=
0.2em">would love any guidance on what a good proposal would look like, and=
 whether there are specific parts of the decompression pipeline you would w=
ant a GSoC contributor to focus on first.</p><p style=3D"margin-top:0.1em;m=
argin-bottom:0.2em">thanks,
puneeth aditya</p></span></div></div><div class=3D"gmail-inputContainer_07S=
1Yg" style=3D"display:flex"><div><div class=3D"gmail-inputWrapper_cKsPxg" s=
tyle=3D"width:680px;max-width:680px;margin:0px auto"><form><fieldset class=
=3D"gmail-inputContainer_cKsPxg" style=3D"background:none 0% 0%/auto repeat=
 scroll padding-box border-box rgb(22,27,34);border-color:rgb(69,69,69);bor=
der-style:solid;border-width:1px;border-radius:8px;color:rgb(230,237,243);d=
isplay:flex;min-width:0px;margin:0px;padding:0px"><div class=3D"gmail-messa=
geInputContainer_cKsPxg" style=3D"display:flex;font-family:-apple-system,&q=
uot;system-ui&quot;,&quot;Segoe UI&quot;,Roboto,sans-serif;font-size:13px">=
<br class=3D"gmail-Apple-interchange-newline"></div></fieldset></form></div=
></div></div></div>

--000000000000ecfb20064b8baeb1--

