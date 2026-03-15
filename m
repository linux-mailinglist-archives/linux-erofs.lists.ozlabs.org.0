Return-Path: <linux-erofs+bounces-2711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v1S0FegJt2lmLwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 20:35:04 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F642923C0
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 20:35:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYpMm0qxYz2yYy;
	Mon, 16 Mar 2026 06:35:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773603300;
	cv=pass; b=badQpvEHFg/f+O6OBCU61vkqg6NjQ/p3LhQXnptbfkWj0uXNr+ghDem2CZzuK1mIxw+sCzRocUaRM4UydNOg56mJCaxLtJRq9ljbx280zPa5sHMVZp5E/DY7dju/4QVNvNt7tbd3YLTPNxCTYkI1TdDLbOKRsLX76AHBkUL+iUtVk58yEQVeUdAtYJZHRHQOQbz9o8uq4AGdYeXYZqc/Sp5iF8aCRVG7V5r5dbROUTcqUOl8A0YI0s4nP1otpaK+FbQnPGJQ2nDlcxYPIPIRr0tlC1oSTTaLKVSGP9nIbTZ/x/RFjp6xT0KixvhR1+MaE+f14Co8Nn9opbrfgdoSjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773603300; c=relaxed/relaxed;
	bh=0G/923+jwZqs3zhX7gEiPm2hWsiZkL3pdyG8HH3qVzo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HXVJpu6GHozm++Hp/4gs2/XvQ7cZJ3nYxH0MVMiFzAuSLzuKImBUG97yhUw3QqeeC/RAUkAvOkJ45KU/xaFcytFgBrnEMuPtDC7rX+8GXTiwNt1IrtjDvZHQ/GBUB1YGK5tLHi8sm3PHx+xH5tSyXDFjdAr5sxDz9Cw29jKSHHbaV8+tCghOYQ2xgsU6TeKEy0PLC4m6RBGaXejC8vx7pDbfpNUHsvwbPqSAUu/5pjed81EktOVEJ6dZZDb+ZgVqvsxMRCock48fkVcfaJ2+2fd3SNPP5ZXqSyLRB2Loidm8wQVKMdH1KH4H9QTqG9KmAXdZhIPJd/hKXghKcNwwqw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dErIaL8G; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dErIaL8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYpMk5dXmz2xnl
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 06:34:58 +1100 (AEDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b976536806cso433302066b.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 12:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773603290; cv=none;
        d=google.com; s=arc-20240605;
        b=XIkCsyu2E66eCzvbH4PdWYUbGEpCeh3yTdgCV0pelw2BSGA8GE5IPGJUgsvVN+kfu5
         SvPE9ML/ixJMuQSuNANCmACIZe5j4ZRe8lgQnu2qChTVVRDbLWZ7eQhNO4Q1bEOuUn/6
         GPuaSP4Jp0A4knEQKuZ9yg8dAK2zRV8nxPG3z8ESpgNXl2pPhOCgRV/00ct/EDiczJrI
         AIc6LzXHMApYG8KQOTDAYItMRj03GQiURu53q6P3hg3dCYgU2yEbLRfba5KJeFhOJRhY
         pwAjeFir4fO7esCsCTkVzWrDzKQVHuKxBA/vT8aGenXx2wKyKhfLpG0KEdKpfL+UgY2/
         H0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0G/923+jwZqs3zhX7gEiPm2hWsiZkL3pdyG8HH3qVzo=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=NFAWAB6rDupBf8YLhkWtAmySjTe0ZuR00VRjvEhpHCSJwVQky/IbYoBFem1NG2mekD
         M9km5fTi4CR35A9/lJaVFSfSXGN+7HmZLzha4SKlG0Sx/h6zEMBt+gKpfvOdqyPaTYT8
         avr8ZEwNwTRsqkAFcQ6RoxBnwIGEyZX5Lztl1ni1K2yw625dw2CpnBpyDfYJF8rsNkfg
         pOHCG+VJY9w3iqoKd0tUP8tyVOYe/7mM3uYTQ827PvNU/ZpilryjPgWUWTuTCy2r4NdO
         0Sa8K5xaLK17NWPPFvCJCzPhBXEaG+TatiYW0sIgXBVCIxg6BOHy/a1Mb45IsGEGBoi9
         JOvg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773603290; x=1774208090; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0G/923+jwZqs3zhX7gEiPm2hWsiZkL3pdyG8HH3qVzo=;
        b=dErIaL8Gpo+h+zMF+Nao859/uBNcTih6u0+a+wF1pLPEGMPGqjgz+xt/ndkrMAY2so
         /1VRyzvco4x8IKnFqPxzU4URYtxHeaEWHk6M94VsFzIeAt+eXIIXw33bzsdKQ2Okc+7F
         IenK3m4liGCT6hJKpSX06mfLCBt6t2AUDdNdxB9NAWxJ8CQHpnCAwAYseGNrRyMwTp3G
         rtvPLvwDnTcDvvL5Eu+jJTuxDr4HQ++C1FdXo6aAUy6uJ6YiZikVkysMo2b+Fcqg9FOw
         OkLh52dI6tPDuPWxcgSJ5YjwXTBprTT6e8g7nmFfATZyfhNTT4R7tqSr+VQfHDzhXqij
         pZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773603290; x=1774208090;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0G/923+jwZqs3zhX7gEiPm2hWsiZkL3pdyG8HH3qVzo=;
        b=IG/J64qhXihlhb9RFqgki1vzFpbBGrzULQ63ABxtNJ1pgrwVyknWjqoBtLwW+WA1da
         NOK5yAOWcADJoRlyaHnbdSw5GyrwyrQSlSZ/ruVi6Yy+w9o9aYPCT8qsadlqtplrT/1t
         8FbzsjDAP1FfMvP5Dxx2YSZUGvH+E9Y80xpfySnk6RMpZ4+zwy222CPrFMf8vvYYUCs1
         XBLGnspj9qsCBX+Q6YLUzImWWD/hGYW0lyjAACMcxnMajQa3L+kWf6thNU1CSwHi+Ga/
         tyF5JhyCm6ZwfUns+qBFemhMc3gSmG7zqae4SmdXewcfRJ61tDPvuNOd0+onoJP39l1E
         NaJA==
X-Gm-Message-State: AOJu0YxTkpdfTIy3ZH/q07wFlR66o77sdDpNX+7orlTYxFo7y6Kmua2W
	E03F6LwDBEHnojWFCxvstlXlyBUelV2QL5uEAHhyyPSQjEsrsWSXhyBMCYXpIcHsjq8/YRuaORC
	0jsNEcOzuw+BH2AIfE++4BRPw6kln0InyptSUqfQ=
X-Gm-Gg: ATEYQzzFq7GYET10po9ipqXulHYMb0kmX7m8oIwe2CY5/vUB7DVqSzQz2ctfe0ma/SA
	g3HWPindXnt3oprnOZ6F0ysI9Avq25C68kvIGkr7TntvQlaCuNYGKCxlgxje1LktuFRxq6Yg3zO
	5oYZbKn5jgHhh/mJDxefA2az76DgKyEmid/6Re3HfN8pOaURtzYUIr0Lfa2S7/wXaQ9SsC7Nsfx
	QoD/4iwLDeHDVKsDPyh0atpLzsImB9JO6QeLyuiiF2I6UFYnIoQK56cMrdWIvGpEEUVhmdCCetO
	1OJ4m1w=
X-Received: by 2002:a17:907:94d4:b0:b88:dc6:3967 with SMTP id
 a640c23a62f3a-b976537db9fmr675643166b.40.1773603289350; Sun, 15 Mar 2026
 12:34:49 -0700 (PDT)
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
From: Sri Lasya Prathipati <lasyaprathipati@gmail.com>
Date: Mon, 16 Mar 2026 01:04:40 +0530
X-Gm-Features: AaiRm51er_bBImJnvJGz036hFqE3hCmreaCVErY1NuzA6hpqBoNjtxUOT4UwgrU
Message-ID: <CABDnCWmf7NkT75a5zHAzixbLxpKSdK1s35GBC8d1s=-YosBncA@mail.gmail.com>
Subject: [GSoC] Inquiries regarding manifest format and implementation strategy
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2711-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A2F642923C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao and the EROFS Community,

As I am finalizing my GSoC 2026 proposal for the project "Support
generating filesystems from manifests," I have been researching the
various manifest formats mentioned in the project ideas.

To ensure my proposal aligns with the community's vision for
erofs-utils, I have two specific questions:

Format Priority: Should the initial focus be on implementing a parser
for Unix-style proto files (similar to genext2fs), or is there a
stronger preference for supporting composefs-dump style manifests from
the start?

Integration Path: In mkfs.erofs, do you envision the manifest parser
acting as a "virtual source" that replaces the standard directory
crawling logic, or should it coexist as a hybrid approach?

I believe clarifying these points will help me provide a more accurate
and realistic timeline in my application. I've already begun looking
into the mkfs source to see where the insertion point for a new input
frontend would be most efficient.

Looking forward to your guidance!

Best regards,
Sri Lasya prathipati

