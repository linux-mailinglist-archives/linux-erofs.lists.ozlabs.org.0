Return-Path: <linux-erofs+bounces-2903-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCV3DE5Gvmn0LQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2903-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:18:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AA2E3F05
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:18:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd9lG4kGFz2ydn;
	Sat, 21 Mar 2026 18:18:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774077514;
	cv=pass; b=kvEU5aHYey5pEHXtkdTrzmqOwyWAY6wkEXGyrlk9pEl9owTEPLuTNAb0ALyvsVa25c6nMe/OhPLeBxlnKTSt+t/cvCadVjqXdIxyq+3ExqMcx1/uMr8RK2o0WCMFIMW14dFsSihRb6uadb6mbJuDaAhOMSmIK0MXTurTl4TQXCVAn5tbzu2w+TDLmEQY4tKKIcNLyA4nG344V1FGdFM565+Ec70z4WB29+V202+JOfe+H8lSOxbNU3oX1cGSyvZT4eURnvZmWv2k66wWl6MgpzyygzHWL7uUdR6sr9u9dooJqxLYna0S9ilaokA1JdhBxknU1PoEquKuS6jETFER0A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774077514; c=relaxed/relaxed;
	bh=54rF58UcoARWQaSVM5f52RMNhIZd99K8VyhD2WLdA8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgCBQ9MoM0H3jUHpCiid6HLiN/UbS0955O4SgBogZXO+n+cZxVmywe45lKm7Ivv0f50+GuTg8V5KKihSlIjsK8KqlpvzX6y4sg1YPZLrqzS9/7l9eqn1kprGv/3LRdDwvch9DbOHCeV9rXhIBUPuRj2ntQSz9W/W7tSN3e+N2mknmm77YbQxaG9Oa1ytgK8RrAL169Lo0jJnpUhmpziJrV/Bj62DzCJarq/DLSRwVEtg/jJsIeQrwEqAk23pUjz3mSkw7WH6bWWSRb+yEIAI0isEfY4BG2GkTuEBtNFyF2L+RyLrsJFNXPWlpcteCCZqXCSrt9UnXCnx0iqIFg6J3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UDbpPfmo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UDbpPfmo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd9lF47skz2xP9
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 18:18:33 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1766771f8f.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 00:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774077510; cv=none;
        d=google.com; s=arc-20240605;
        b=hd5jx2PeUjhfbZjKobMTJiieh7PnuP2Lw4sTsnCjfnf7q95TILOLwCqma7QFzxjJfr
         YHgDtDfZs/WhPguol1UZ/oJkGFfsOKsijcu8gJ2RWV8xP3e2vdj8o5/l4sqlSZO3MkIr
         zu6bspAX0a9B/UJW/zG+tCUP28jD9PgX6euezz9tvM1uZ+T8J7Kh+j0er0LHnLgL0U7/
         t3Eb0ioTDett0PL1GltMGWDOlP0atkA1uHY9t8EyamfjZLEsaASHJk6Bz6b62Mwulg8g
         K5Fj8gVaF8vsWynR7S0psPMpieDATF2MfjY8oYegH0i3EEOx7wRGMmiZqsTVW0fOxOyH
         aqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=54rF58UcoARWQaSVM5f52RMNhIZd99K8VyhD2WLdA8A=;
        fh=h6uq7XjWFSBY/jwInOiPeoemBJWA2pJ/g0xZ2uxEeMY=;
        b=TxVajtb+6neuqMB7y3eZ52TDZrHhYDq6KrMV0h4pcsliylZB5uHfZA4L3XiuKim+Rm
         F3MjgC/0+reaDeh5iA2Y23bQsDuYYttlYFkDBu4dbHbPCJMVEyezyQ5KQmvMD0cQci1h
         TziyqTVbKePSnO3Dmxx1tfIdBaiozmKDwdyjN/wmJZDC0S7KwK5kY+lyTVZKJvoe6nI9
         pmZzV/UKY4QXS1sRXZYtcCjVsg3c2rPt+xumWlmRFuhuWxbQZW7VBBf26g4UnmA9Risj
         JB+/3RrtysHQmyp9WE40UaW3MwJDQRMp5Luf8VSEPEwh7xvV6SLSeZDWTbc5YgkEUNh4
         d6nw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774077510; x=1774682310; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=54rF58UcoARWQaSVM5f52RMNhIZd99K8VyhD2WLdA8A=;
        b=UDbpPfmo9R5ko7EA/+qS6YlCswsxVQcU5+2S4IzFk9aBwvs0lt/8sD103FhfsFkVf0
         y1PVovsY3F1YIDy3/ugI8BnHwn9zaWnD4Sp/LxWgmIQmhZcADxNcywUDzS+CzeO91Eva
         sL/GvZiYm16pCHW8bp4m9YDAkhx/Nb7rmkMeXDsQLTJhg0KYvfYnbvEsclhuY+SC3b0F
         zOSOt2zBi5WA5Nz5rZm9i2H3xGTjFdjbsuaxG3wnWxybS3e9nTcle6PVGnzoh8FaD5Oe
         28sCFOmnNk9JlmP1aR3KGlc9XUHOgSvyjmtEqraesMNsnPRoY6nsbWmLpTxaFyys/3g7
         87pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774077510; x=1774682310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54rF58UcoARWQaSVM5f52RMNhIZd99K8VyhD2WLdA8A=;
        b=UyzWanSs1TMAI91Mqh4yT66kOy5wqZJ5vuGT4V/ql9D7RL80DdU0tooss/aIZlIgEg
         0ydGUTiMzsLket1+h4pvGwR4k7Z+EwCMI9wU3z6imHWOJrauz14YWdfmETO0iRccq1NE
         OvPC3QqulAFggfGukCSzaR2p6fTRaPNkn6+VahSH/P+FNuQ0ibVCX4Q9D2HHrCUw05QF
         gJRK+8o6WUEHNkzWPKYPo+ytL86AZv059j6RmFPQdiBIvqXEaKAjs5lWCvKvmU3XVL+F
         Hy/RIyyZy67AtuivUPgGVUi942JPEqDPo45t3dJk0RIfPLoiJfBXGMdbdzx3cELkluVl
         vCbw==
X-Gm-Message-State: AOJu0YwXAKxPlPdKkTSd916+c4+M6EV5FMThY/1f2//9kX8r2F7kGidr
	NHTmD3a7pny1q3jBmHiYdHD2SPL3aigoCtNKMSAxrTJI1l/yHy6JmQ5jGN56Df3wLs6tQVOyaL3
	9yhsOI1DXNXFP5kG1ZIG0a4Df5S1736x8uPtk
X-Gm-Gg: ATEYQzyRvMZD19/0Kv29T7B2O7WMqORxdX7JfPNrJxDVR+VYa2OPx9Gur3nnJWZxbw1
	0qfrXKmHIomdMRQuydn+juUz3+SSF7+a2tLUJdia7/YYCVGsB36CBuyGNywdXAt05ToK9Pc2UfE
	UOWGEl7EpHQS1pQ1q26J7Mv0wmwN0SU7dxoY7E2eKUziKwYAmmuqd/Bl2hByt08g+BaNXFVTY3X
	FutvyYPLrHpQY6bsuZZ+YL4Pak4wFIcUfw7PBN4Z5Idnb23dfB52pgaFRUKV4T4P0ccmIO3bYot
	DLpTZBJQ5039ST+e9Th17rIvM52i/N10nFZ6kTuJAUknljcmG02z
X-Received: by 2002:a5d:5f84:0:b0:439:b775:fca2 with SMTP id
 ffacd0b85a97d-43b6428731emr9347761f8f.24.1774077510197; Sat, 21 Mar 2026
 00:18:30 -0700 (PDT)
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
References: <20260321062604.1905-1-newajay.11r@gmail.com> <cb307f5e-bb07-4456-8bb9-7d4697171d14@linux.alibaba.com>
In-Reply-To: <cb307f5e-bb07-4456-8bb9-7d4697171d14@linux.alibaba.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sat, 21 Mar 2026 12:48:17 +0530
X-Gm-Features: AaiRm51nodsMfak0GwJz7xcKxCqPvZradmkHGCkFk6Wh5o6LtJ5GlpBDnS_mI0Q
Message-ID: <CAMhhD9g+Kv2G=voBkBV8+sFoENCuiUwvnmrJgPVr7j_9uPSM2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] erofs-utils: fuse: add missing return on getattr error
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2903-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 417AA2E3F05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yeah, I apologize for the mistake.
I just sent patch v3
Thanks, Ajay.


On Sat, 21 Mar 2026 at 12:13, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2026/3/21 14:26, Ajay Rajera wrote:
> > erofsfuse_getattr() calls fuse_reply_err() when erofs_read_inode_from_disk()
> > fails, but does not return afterwards. This causes the function to fall through
> > to erofsfuse_fill_stat() with uninitialized inode data and then call
> > fuse_reply_attr(), sending a second reply to the same FUSE request.
> >
> > Sending two replies to a single FUSE request is undefined behavior in libfuse
> > and typically triggers an assertion failure or crash. The uninitialized inode
> > data may also expose garbage values to userspace.
> >
> > Fix by adding the missing return after fuse_reply_err().
>
> Each line of the commit message should not exceed 72 chars.
>
> >
> > Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> > ---
> >   fuse/main.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fuse/main.c b/fuse/main.c
> > index 82aca8c..b634782 100644
> > --- a/fuse/main.c
> > +++ b/fuse/main.c
> > @@ -265,8 +265,10 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
> >       struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
> >
> >       ret = erofs_read_inode_from_disk(&vi);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> >               fuse_reply_err(req, -ret);
> > +             return;
> > +     }
> >
> >       erofsfuse_fill_stat(&vi, &stbuf);
> >       stbuf.st_ino = ino;
>

