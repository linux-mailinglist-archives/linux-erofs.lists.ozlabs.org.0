Return-Path: <linux-erofs+bounces-2713-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DhpLylut2l+RAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2713-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 03:42:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C2294373
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 03:42:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYzsL4hzkz2xpn;
	Mon, 16 Mar 2026 13:42:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::432" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773628966;
	cv=pass; b=oNF4ic0x7yzfqz939KAQTcZFyOE82PRtcnnfB9vLQowyCjaD4d2a6qdOIUt3dyXI8NTaADwZlMFLweiBiEE1GaIXCt7E+96IxXQByrPTtDoc7SFs6fPB1snd7RZpIRiAKdUKKC2vneOVY6Hwy4+R7O1wzkl5kqNeyGjHfVNw9LmUmwhhGd5hQnRbuO484Mn+Tx0tRfQOYLpzcrlSLNTQx5zVTfudHnmjJzMkBEJI0686MiGC6h+ZNabni+D6nzxz4zl2OZNpKA0UHqOKUWmWQGX856Q2n1qopkx7N9OxBoUreN4fRjRwIEhqcJlCUy4LuCF2nO8+8eJoeT+P9lUd1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773628966; c=relaxed/relaxed;
	bh=nCc7j/pTjnWX6g8DjsRevGKtMG2fXuvV9qQ99JxRlCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AiJ8usi4lP8utKx/448PItFKJ/sw3jaRv85RX0QWFcaLR9a9o+XREj3cYKEBinYzUd8FQu2asjV2eQYg6kmA+I57G2GNb7sDx8HmS/8ynj9vXKXwiecudDHaJFgqUFN32oWjA3iGOf+hAPyHxFtj2lwQE8E+v6Xztwvg74LNclYjbUcgdyUp6Wovvv01nWM33g0YRcyN+hI0aYiWLJjuHJU/bjH/D9J0pHitOLrroeuxN5MWCsSLcEe+8T00yyqp9EYfxTA6IEcdeIvLyEDqNxTkajHNQ/cNUKYTkWz6J3GGppb9yom0/CXtbXgxtkxCocX6fEORC+Ps+AEdHn7RFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q8RvlIrC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q8RvlIrC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYzsK3B6Mz2xS3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 13:42:45 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-439fe4985efso3664711f8f.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 19:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773628961; cv=none;
        d=google.com; s=arc-20240605;
        b=FC/UP702JMs/PhpUsK9FcdxXY10+ZpAab2wpa4UEVLV6TrLGhVHORyHg6P59NyDqVh
         XGDBHcEPznCwDb+hBSNTW/iEZmAMiM4HMOnt6tsT3JVykN+VN+ojIq52A9GK1bhRF+Kc
         LMyEANSaZJk73uxE4WpoKhdqS0FtsieEflDWBTKQeb8OHho5GSiFYK/gEO8FpL5KtTKA
         AMxX8swO8aht9f3LJf5zo744x60tTacEiHGVw0CsDC6Vd3ZYntCddffcae6qrqAnhjWv
         iyQVuBqBHUNeC9QCdxqByejDWKaL2pdr2I3o1HxdK8a4gqrxNS0fLiVqc9BEMOHa9eB+
         bisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nCc7j/pTjnWX6g8DjsRevGKtMG2fXuvV9qQ99JxRlCU=;
        fh=RrsHr754WNOhbpINcYykH5z2BXa7uJ3DSBCxj++xbAI=;
        b=CVLHPMZiIfrtGJgHBI4mtupshYR7cDwAB2nU10JOEZkmLXua9xFggg+IDDiof4ci/r
         g5V9YKdK3e1pmd+QHjibhfEmWt2yT1ZSMUeo9TJzROmOEbBWjZnGif7bRHxpCDT86Ffq
         Q1KCP1WwVK4K0tiaUZ2LS2M/zJqgsHEXnzUW+mJ97FtjknW41eFVEf0L6nYlbLiewvh+
         Q3niSmxwMq0IZugoPqEnGAP9zvz8Z7XKp1EdCF1CTt/krDFYhazB5cFHfmq1gae1NvZU
         Ecae/kZAy4VlLi9WZ7JB5uO20dT7Bm21qL3REWpbaU3dQIndYmuugnLodiTmuCN4h+NC
         a5nQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773628961; x=1774233761; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nCc7j/pTjnWX6g8DjsRevGKtMG2fXuvV9qQ99JxRlCU=;
        b=Q8RvlIrCOpIeo9Px9hxumxEm/ImOSLIRFbDQE9WBgo7Flk3ARcwgGzoQXEpcPfrolh
         1ALwObVOMj/64iq5e3xuo0pOrUj9LyvARkHdCv7dpKzyMjPk3/He2QTzjYhO2S0RNLUi
         s3/86DfphoKe4Xa2/TGfxlv9FKNolsD153EZ/W/19XHnd0aF/QqligtZyHsvfRQWDGhY
         gGzYYIJXuKpdYFX1aVHeiz663mbFF/VUtfimw2asH2RqpNegX/e73RwKCatQXwxWCDGZ
         v93FZ+LMijtuSt5ePgwo3lxe52PT8WXiopy2QpJ0STy33eFq1W+0ILqsgk+gBSuNOnph
         tfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773628961; x=1774233761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCc7j/pTjnWX6g8DjsRevGKtMG2fXuvV9qQ99JxRlCU=;
        b=fFn5cS9wtiH+mTvky5baYzJT3LNLXjg6t+Ht9e++PvRO3klpg88lP/I3U6iecmOKbV
         ZCaFuscABW70+Fc15aMuBIOGfozoqk6Ilo+81sAFtYBYFCHj2oSeYnZUbhNt4VaDR82m
         W7E4LqJIEh0Y9DZIcPPyGsanT2ThffSpame/UHfMLYH2az3EhztI715BWlolJ5oQK5jX
         CS/M1/79j9YyA9mnmbL0ly1VxAZL5GLeP+UFMmmzj+XUJR+FJQr1ROEVSRXzQYydB99+
         ItHATuUbXanCeFkBovfnuymO6oTB3QDsHGncX2LY808VY6lfSVYv8UasZZW+VzUklUsH
         jenA==
X-Gm-Message-State: AOJu0Yzm2loi6J2qARr9uksw7YNJk71r9tmmO7WS+tfgfajaQLRZYV5N
	9gFioxy7+LBwWg+atTztUS6OfMMOoU+VTbBJn90/qiamOu+Cu1R9lwmSc7MBPEVJv+8y6tPWAel
	O4Y4K8JCNwhpcJ1tp7T7FS68mz1A3/YtodAcg
X-Gm-Gg: ATEYQzyCcC2pEn8MS7Td3acxEe2jN/XyqqNCVH1omW8TarTRSZaZgCzyp36XvYI0f8t
	W0nRpHatjXOJzMVTLhZYpvB+ydN8GA+nkdVOQTvT+x2WJM5OXD3H87omMOpNe/ItbCF87ZN5wtL
	cyu7R6D092JkrbGdCNTw2j5znwdKlEy2wqI5S7asF7xhsKAoHBuAXkoYCOcG6UjyizzRNmCDkvY
	DFr4h4qyotThMa9jH9pu8YtyrN9r7FfaG7ZUIblzicxJ6tmrBNLZM0rJsN5dW6Y8bUTjDYGuOmp
	hkddC7v6TZTpmGpEBzd408yiPUYM6SJW927SEwKz/g==
X-Received: by 2002:a05:6000:1849:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43a04dc0a33mr18494703f8f.41.1773628960953; Sun, 15 Mar 2026
 19:42:40 -0700 (PDT)
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
From: Ajay <newajay.11r@gmail.com>
Date: Mon, 16 Mar 2026 08:12:28 +0530
X-Gm-Features: AaiRm50qQAHJQWBkA2YvcdpXtmXek2vmmJTpJAlwp_S9qUfC94HXlh4XfS98x-I
Message-ID: <CAMhhD9i6UbLKFQYv=bqGydUwtrdDU0zZ81tcRsxgSHhZEUN7UQ@mail.gmail.com>
Subject: GSoC ( Ajay Rajera ): Support generating filesystems from manifests
 with mkfs.erofs
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2713-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 047C2294373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello EROFS Maintainers and Mentors,

My name is Ajay Rajera, and I am here to express my interest in
participating in Google Summer of Code with EROFS, specifically for
the project: "Support generating filesystems from manifests with
mkfs.erofs" mentored by Chengyu Zhu and Gao Xiang.

Over the past few weeks, I have been actively exploring and
contributing to the EROFS ecosystem to familiarize myself with the
codebase. Some of my recent contributions include:

1. Addressing the excessive default verbosity in mkfs.erofs by
suppressing per-file processing messages (Issue #14 in erofs-utils). I
actually did it but couldn't submit the pr as it is restricted there.
2. Improving and updating documentation within erofs-utils to fix
grammatical errors and outdated information. (
https://github.com/erofs/docs/pull/25#issue-4078189227 )
3. Implementing support for EROFS device tables in the go-erofs
library, which involved parsing device tables from the superblock and
mapping block addresses. (
https://github.com/erofs/go-erofs/pull/18#issue-4078327809 )
I am looking forward to contributing more and keep learning from it.
I am drawn to this GSoC project because I have experience with file
system concepts and C programming, and I recognize the limitations of
currently generating images strictly from source directories or
tarballs. Implementing support for manifest files (like
composefs-dump(5), modified unix proto files, or BSD mtree(5)) will be
a highly valuable addition, providing better metadata control,
ordering control, and better performance for large filesystem trees.

I have started drafting my proposal so I also have a few initial
questions regarding the project:

1. As I detail my implementation timeline and architecture in the
proposal, are there any specific edge cases or phases of the project
you recommend I focus on the most?
2. The project mentions supporting at least two common manifest
formats. Is there a preferred format (e.g., composefs-dump vs. BSD
mtree) that you would recommend I target first for the initial
prototype?
Thank you for your time and for maintaining such a great project. I
look forward to your guidance and the opportunity to contribute
further during GSoC.

Best regards,
Ajay Rajera

