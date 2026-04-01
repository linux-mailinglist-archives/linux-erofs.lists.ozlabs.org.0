Return-Path: <linux-erofs+bounces-3159-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLvpHK90zWnYdgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3159-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 21:40:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992037FE23
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 21:40:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmFh92Y3zz2yjV;
	Thu, 02 Apr 2026 06:40:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775072425;
	cv=none; b=jC2NDcFthBgTXnqiA3RegnP/8PRUwogeUZ5TS3IbDWwKMb5lc2rtVe62ubAM7Utxo49EW2j2RPkPK0qPjqEMD2Z6U2XEFPJ3w9WotvcQ0tlzRcpkN9YtEK0oOznDiGt3og2nFYjQJhYIY8zMUYZUlFbuk/oWiiTYQ9wKdW7KqXZb/oGd09p7TKcMhahTXpDHn9QtYMr2xi6IyQVxYbYi2GgzkufaFi3z+fQu1pgbC7TnkjNPFEtfuUG+Eae9BjNGTHF6aDEyYxA1wYdFWOVpEXjmDLuHheTDYqOCqL1ewsbM+nkHH4RZBHnnFqzZHyfVY6dYujB6r469JlJ6HuNBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775072425; c=relaxed/relaxed;
	bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j09ZLkHzZJhbMSMwABMPj1xb05FdDIL94Cc45OdZMu5L6Lfsdq2GJACoLWTi8/RC2+6tpOgMFW8S1MBf4bDq92R1uUe8ISVioE8WwBnX4F8l+lczmmSaFl3ukeF7R2FfTtpaqNE3jZxYKHqdeKBLj/80AMw0ti4KrGSWrIhQmCWp0nzwl3QB/bM3Z9in/PIsXBhbb1h451AmVN+A+mLpvsttEihCoc01khFhAjFbvKE8pAfJhnNE2NsznrVQnRcYY0BfxzVODCfo8SXa8pCs18Y6B2AnnGr5jPro6AvQJhhUdkfgAEkGM4cC4rzQzVIMdHpA+MywLH2vIVZ9VJfafA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UpxNuhcw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UpxNuhcw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmFh76Hm2z2yj3
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 06:40:23 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b0c8362d93so430595ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775072420; x=1775677220; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
        b=UpxNuhcwWoWphGAkmQd8RZw9v603hWLLnvvdbPmkKrFBI08GIamtOUIY+ZuEfIrSPE
         nOZS40j6mxGtUcbV8nuEPA1t/9o/hluTVKIjik4rC4JOTVDB5J7AFw27iEA2cI6cT2rP
         8XBJHYcHLPZjCh4BO8V5p6zZrsNafrL5yiIRzMKahKBD0QzNiJFhlDQvKTlrY8wbhGT3
         sTTEyVNaQsQEP3pa5wv6sxGT1rUzbE1KOaq4IBsczD8/ZHTDIQ+ntvFA/YJi1lJMTo3o
         mJOZZDag1pAutDu9UK90IZJIgqrgdpcK/931e8F5TFAVB/8uFkqDDUZnuH1HzwoZnQrv
         EYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072420; x=1775677220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
        b=HRXP0BiCRYxgX0pCLqDRwi+mjo7f8GjhIf62/ZOIDtn1XqQuekn0XmyulLfic7ZBN3
         fSx8fUKiWRJb56ZfEmADB2qO30nRE2MDyix2EBsFWYZPdQ9MotQueRzS3W0UKil94GWQ
         13iLBeSljgo9Ur/3ZwRccJidkr2hOfFTytywEw+hFMgpoODVErOm9MJVMlvO59tenvZ8
         XMr5Uwy7EIt0sjflfU9b/DUQuGrysNJiUiiFvpQna+AfMhHvrGNGNV6yXP9vzVD6Oz+y
         2EJiuLD17sNT256dpk6/F5986p+y8xf3RdQIbHPemkKnVLguX587S3hH8zcWsyyfnfSV
         VEGw==
X-Gm-Message-State: AOJu0Yz/8ultm/XrhHM62BUuqPbvH5iggtRtLRQ9FLH5Jii9M7EmE3lB
	bxzYH3smqpr7a/Xho/8Ww6Qt+/4U+a6tqfy1aMVyMPVSXLqYSHTgpSFZFSbSoRkL
X-Gm-Gg: ATEYQzwebmCH90BJyIiSPzgWoA4m4dr0b0OrXfKR1LBBJxoMKbBhP4AXkJ/aJusv9EY
	EaQXC/srjZ82+s13soWeocu/GhIntQOH2sOlwTz/FTxjURwxteQPq0BDhpStYLRCljEi5K7gbNJ
	bcIvyOXwV7ybAbhyfQWWmsEHjrskdwWlPrbWJxAtH0xLIpqwAs2yNzK2wQcDhlxt+GI9gKwseqL
	qrfUX2D58D1Iw71EF7GuclFqkTwV2sINX+/Ti1jRPjskiXfUTl2cbhkHY255JxTC/ry4ZfETNCd
	/1qH/p0qftBJgWkGnmE7ErUpjMWJZXuR2xR1gD09jEpY4XtRON1uE1mx9bG44zMAWPiwgiF5QpG
	MPf+wIyqROjMliLe8X7Dz2N9vxjg91/fqsFXzSvjfq9ualfYbdi5gjY2WKFqE0AlSJbEHaQGwkn
	KjWauAEOAlLsDjYUGM4BtG456PcAsLPmcjEqO8vThtPP7QuZs=
X-Received: by 2002:a17:903:1d2:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b275d9eb7fmr4096925ad.36.1775072420149;
        Wed, 01 Apr 2026 12:40:20 -0700 (PDT)
Received: from final.email ([103.97.165.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749eeb9esm6147785ad.84.2026.04.01.12.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 12:40:19 -0700 (PDT)
From: Deepak Pathik <deepakpathik2005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org, deepakpathik2005@gmail.com
Subject: [PATCH] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
Date: Thu,  2 Apr 2026 01:10:00 +0530
Message-ID: <20260401194000.1-deepakpathik2005@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3159-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0992037FE23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In erofs_metamgr_init(), erofs_tmpfile() returns a file
descriptor stored in m2gr->vf.fd. If the subsequent
erofs_buffer_init() call fails, the function returns -ENOMEM
without closing this file descriptor.

The caller erofs_metadata_init() handles this failure at
err_free, which only frees the m2gr struct. The fd is
therefore leaked with no remaining reference to close it.

The success path correctly cleans up via erofs_metamgr_exit(),
which calls erofs_io_close(&m2gr->vf). Mirror that behaviour
on the error path by closing the fd before returning.

Signed-off-by: Deepak Pathik <deepakpathik2005@gmail.com>
---
 lib/metabox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index 12706aa..d55e787 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info *sbi,
 
 m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
- if (!m2gr->bmgr)
+if (!m2gr->bmgr) {
+close(m2gr->vf.fd);
 		return -ENOMEM;
+}
 	return 0;
 }
-- 
2.50.1



