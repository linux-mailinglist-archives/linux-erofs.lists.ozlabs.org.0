Return-Path: <linux-erofs+bounces-2714-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEvlEl5wt2nnRAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2714-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 03:52:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE129442C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 03:52:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ04B48L3z2xpn;
	Mon, 16 Mar 2026 13:52:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773629530;
	cv=pass; b=i1JMcG5+jqqGRVjT32iKQyxFAIGigm7Fo79fXZj8w9GjehGtNybxKDRPMP+y5TxMaZRAAjo+dQi1ylr4cTuMtxQnKTVrJFdJFcK1HRgbRC+6xWWoYsbDL4eYZGkau9KhdvrlPVRLtypaOC1oUozwWrz4fFdMjrJH1k1T71UG6xp0WhbCeWXEftw1lAUgQNKQo0nyG6awanCwRDY1t6U6kGaJPrIBJk0UWRa002p6Kc9zSsug1ZZx5PmgRQiglJMZBkLUjV8KPmZBkzDOIYggtSHG2JuYa5TyVE5boDm6Ebm01MVcgGgaQaTr5ecJG8GK6UIoe/EqK2wEAcquU5PMSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773629530; c=relaxed/relaxed;
	bh=lkLiHYp9tVKed1aa7twayLjV4Yp6OpEvVPruZ0ddqFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6CTuZkqVOQEAsVQrOeqBB5jK+CwLPeJa6Wro8cgw9jKTNCFygccQLHoZvvFpRwrpOzJnGV1+pnEje6J+mFGBMEkXvQF485+wyjRrgpS8j37H3r/DpK3fOkP5chJ/oWz1ZIMX30AaF5v/Pd6oKcJU2jk1Fnigm0StfbT2580P2FT9WWmlQ13detoZxlr7deFwR6A5BfpYbLYliZzSSE6jA+o+TKAr3yGUt0hJyQwmpBeIS83it38+Vz6vkIxPEaQHmuNRKXyzBtP+qT19voPriJYHQN5vftulrH6Dxhib6Zsj9bv6a4QALE5byHh1RgL6OgPgV9hZfREJLLOX6b+9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QodnyKph; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QodnyKph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ04923zDz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 13:52:08 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43b3cfc38edso1330765f8f.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 19:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629524; cv=none;
        d=google.com; s=arc-20240605;
        b=ivklvM95ZZLPNYtspA5m0orz/msJ5AVWSwe0Fscd/psHcyyIeSONhBM6buorvOWUbm
         n+A/0nnJl7iu+Sw8tmYWohu/cVgUgfRe5U2nRZTAI371efAikSFDmJLI5T+Aw0Wfv1dn
         djVhynG3o6IPBCvMUeXsX1FI9Bkc0ytpnxVNDzzZ9CtylVJrTHKzqEuBFIJH3P37e+UC
         06nnp4RUmcreggR9W7LAdObDakiZqVNrXub5kW9bMYsYdt22ZgfSz2BNv+uheBuxaaSP
         HCpK4P1vn+FbzZHySSrdX8Il82/I+GieAsQPbt0x0Y86pdjvcA9yh757RT0/Cptk9hWd
         KJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lkLiHYp9tVKed1aa7twayLjV4Yp6OpEvVPruZ0ddqFY=;
        fh=RrsHr754WNOhbpINcYykH5z2BXa7uJ3DSBCxj++xbAI=;
        b=ZJunosh3mSDEz1CDnpnW2eIQj4n1fIFIxnSiU4u3IaD8H1s19YWn7tMW3p6z1zQzpV
         WHqCNoKNPJdizwEienIIWlFdjbLpXnsNsD7npOdr0JCkO2CtK38XN/AFfwWTfpB1QCW8
         sh1gwz8dSrVc1i/yo4CEyxBBCql2APLHE27CnQpeU1Au+YEbjZDqIxp70gEEM8jcb7D/
         juRdiH6gKmszgotQp8urWsa7796g8Z7Xxi7lizpkYTW+j57d6vn2KQwZYhq9o0Yt26Sb
         j50+gxlWXokT688eFPz4n+vzYb7vZE+4oSqMdBXdQ6QnmlRXtY6qY7XibTf8Qd1cLTP2
         nGIg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773629524; x=1774234324; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkLiHYp9tVKed1aa7twayLjV4Yp6OpEvVPruZ0ddqFY=;
        b=QodnyKphQHWYv2crpvLcI4sNcJH6qtpclKqcDZin58Zwm3/V7GKEAkAVuMmxrIxKjH
         P34RiNdb/YTYzu+jboGCvk3pVw2kTVI5AZRLbQAcE4jLlTGfzjBzQxC2kx46a73UWugg
         3qiHfHpWgNpQpgPzxJpJ6JNRgTYYnDRL9MBob/m3MxwZjyyV9AQieVYxlYLJHO/5NO8P
         0t5ikZQgHZIasglxVP7g1y0kwGGM3PwTBb3eh5WWCh/eRVQ3qmMV3TV1nA4uQ7blRUub
         YDMcgrgvXpl047dZLivxEmoLkqPmI8FsMo+UdWJEdtQsn3EEuLJaImgfZWHHVtIGmV7J
         b7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773629524; x=1774234324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkLiHYp9tVKed1aa7twayLjV4Yp6OpEvVPruZ0ddqFY=;
        b=dvcEbslFIf+DAev58T+/QPbTgSDuWfSv6sBO74rm9nVDD57+2/CacYGiq8rGZYgJwb
         opSwLaKXXGmpIrBGPocbaYcEh2cy3sPGRN56GSGQOmL37L+32Vj+y+xso0OGXtFX4BKg
         vjcYOBF3fTVZAchvwBktiOyxgOx267IIgGcBRCTg+RwFMUCQyrjMZxeuVL7BH2FRDSXj
         kl+mts84GBwN30hT5WTG6qI0HWnD4IUSBRahIne6BwnRlmIP0TPDP6y2z0PIOsCoJB/G
         XbhSg+vIedoZ73+cvJmrxaG/pDVrNWwvtTgA6+sjUniQXPgrFpwuqrz0dAOjQRPQC3rL
         83gA==
X-Gm-Message-State: AOJu0YwbT2ragjUZ+MmcvU2oHhejVvz2FRL+ouGlyEiV5ED6MgNyc7Ha
	sFw/6z3x0N0S5BChy6N57Zmg5+Y/D/0FKWIL/eC7RZ5+luZ8BiLeAUqts2/0CDTY0BrEHzyeNT2
	+gnrVOLsQ0U6AQHaZS9Vvl4aPKuhYQAgJKGFmVXc=
X-Gm-Gg: ATEYQzx0UM9oP0RmtPESfl2aMuxDrJoDeZlv/TPdMZBbMsceK23OgK+aYWvzpVsunq7
	1uVFFmUI5tNEWE4mTIkjrI//QUhKjniOBv9wrzE4GbxsX4p+Z9rEDq8Z/8YmSPVfsauv2VRSK65
	Jwmcs8vjEcEOX1eo2Cilhjuo46W+R8UmOIpZT4d9vHuVRaVj/0ZUUoqhCekHvO7nvVdYwacA6cY
	7cqReBMhJnK5zOctekr7puYOFKJD1iyH6PdqdudFxbP9NQSfkxEeKMlBi7btX8AwIT0i3susSqK
	XdL4UYr0XlWFEAtKEEQiNkxB8cVTzQADjooQYlTZJQ==
X-Received: by 2002:a5d:5f85:0:b0:439:b858:1d28 with SMTP id
 ffacd0b85a97d-43a04d90460mr20957133f8f.26.1773629524341; Sun, 15 Mar 2026
 19:52:04 -0700 (PDT)
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
References: <CAMhhD9i6UbLKFQYv=bqGydUwtrdDU0zZ81tcRsxgSHhZEUN7UQ@mail.gmail.com>
In-Reply-To: <CAMhhD9i6UbLKFQYv=bqGydUwtrdDU0zZ81tcRsxgSHhZEUN7UQ@mail.gmail.com>
From: Ajay <newajay.11r@gmail.com>
Date: Mon, 16 Mar 2026 08:21:51 +0530
X-Gm-Features: AaiRm52WCb7GR7NFAJItM16WQiCz_rTw1vKQ-oZZRC1bwx2ZdeDD5ApgiLcd_GU
Message-ID: <CAMhhD9gWW9EvNvHdVS6EUePehyQOaqTGSB_1xbehQPYQe_v3zA@mail.gmail.com>
Subject: Re: GSoC ( Ajay Rajera ): Support generating filesystems from
 manifests with mkfs.erofs
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2714-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 35FE129442C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I previously submitted my two contributions as GitHub Pull Requests,
but I have now familiarized myself with the git send-email patch
workflow and plan to submit all future patches directly to the mailing
list.

On Mon, 16 Mar 2026 at 08:12, Ajay <newajay.11r@gmail.com> wrote:
>
> Hello EROFS Maintainers and Mentors,
>
> My name is Ajay Rajera, and I am here to express my interest in
> participating in Google Summer of Code with EROFS, specifically for
> the project: "Support generating filesystems from manifests with
> mkfs.erofs" mentored by Chengyu Zhu and Gao Xiang.
>
> Over the past few weeks, I have been actively exploring and
> contributing to the EROFS ecosystem to familiarize myself with the
> codebase. Some of my recent contributions include:
>
> 1. Addressing the excessive default verbosity in mkfs.erofs by
> suppressing per-file processing messages (Issue #14 in erofs-utils). I
> actually did it but couldn't submit the pr as it is restricted there.
> 2. Improving and updating documentation within erofs-utils to fix
> grammatical errors and outdated information. (
> https://github.com/erofs/docs/pull/25#issue-4078189227 )
> 3. Implementing support for EROFS device tables in the go-erofs
> library, which involved parsing device tables from the superblock and
> mapping block addresses. (
> https://github.com/erofs/go-erofs/pull/18#issue-4078327809 )
> I am looking forward to contributing more and keep learning from it.
> I am drawn to this GSoC project because I have experience with file
> system concepts and C programming, and I recognize the limitations of
> currently generating images strictly from source directories or
> tarballs. Implementing support for manifest files (like
> composefs-dump(5), modified unix proto files, or BSD mtree(5)) will be
> a highly valuable addition, providing better metadata control,
> ordering control, and better performance for large filesystem trees.
>
> I have started drafting my proposal so I also have a few initial
> questions regarding the project:
>
> 1. As I detail my implementation timeline and architecture in the
> proposal, are there any specific edge cases or phases of the project
> you recommend I focus on the most?
> 2. The project mentions supporting at least two common manifest
> formats. Is there a preferred format (e.g., composefs-dump vs. BSD
> mtree) that you would recommend I target first for the initial
> prototype?
> Thank you for your time and for maintaining such a great project. I
> look forward to your guidance and the opportunity to contribute
> further during GSoC.
>
> Best regards,
> Ajay Rajera

