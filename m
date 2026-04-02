Return-Path: <linux-erofs+bounces-3180-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEHTJitRzmmjmgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3180-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 13:21:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B8C3883ED
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 13:21:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmfYg4JBWz2ygT;
	Thu, 02 Apr 2026 22:21:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775128871;
	cv=none; b=NpdFCf8vGM2G7tuCSPLdxg5AepEh7IypeHtBNqgEYCMy9392c8Mp5UB9XM6dCfQmK0X55NmKWicV92qbyuTLk0XYj1t8xmuyQ7busVg5YXYuxBv/ARbICYvuzEucYZcufFhSiznExa8gzRkZUCmAn5dm13kmvdqTO96VKUAzRNcHnvukUpHDdEkkRggOZ1ogz8ey8Aje1g+k7Px6E/PHmndWLCi7uIzXrHNyni/X0NQfRogSJ9pMQxE0pff+JtP0latz+N+waaG+4FhVSCXJZZ3eIoGdYjf6EC3CzTeH18alWklV92CkWMgt6swL/XE7U52nS5pC2KzbRO//X2WyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775128871; c=relaxed/relaxed;
	bh=uRc0fEF+ONqvVzDqGIKgEG9scIir8NhohKRP5U8geGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz7+tRLUpAKbO7Fty6fUKJHNTmitlMpdtcy4ehdAIng9CWUFCk4oYrXdAVkIYtQee41sASfK6Y/gmuur6SMk+dttvmpw2K6YyHYLqtneqn9QP7/NBd8DurJEwLh4rqr5hR5cTl41NA5ZNDLZctd8X0WK0atuL3JLZjfw2f5q3RWKzqydbcd6+MBTNB6wiLNWhXKSusRq1tXInkQkJOM0sHMn/99nI7axDdDl/II2oKnj9XUt5r9lzUTFwHLvB+u6ZQMzCima13nkbpcVVyw/1+jIMu1A9vqneb1gGExSnUfhSzeO0MSjkVu6lcUPAmbD0SKumpSK6Cv4YvhppwW5kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dV4JMiVU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dV4JMiVU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmfYf1v85z2yfl
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 22:21:09 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b256a4c6b5so4240875ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775128865; x=1775733665; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRc0fEF+ONqvVzDqGIKgEG9scIir8NhohKRP5U8geGw=;
        b=dV4JMiVUsqOsbpx19rSWMjdr/rVVECcPs0zrI8SBroOK2vxQmbvJknJNuRrKMYs6Vb
         +g9bkSTbS7Xjq3y1sygVUT5kcypqj3Yoqjk6zKByVTJg68ABA4TcMMc8sqDV1nMY7W+Y
         e12yhP8nNgs7XbgLtrt300ygSiCkqU3U9HKlquGSRIYmXeYxxfjx5eEsPLIxG1gq/v30
         GpoOMZGC+/lbz39sLgbT30QPVbCQNVinXsmIqLKfGBKMUbm8uqx93q65G/HzqYX9y2KI
         gUqy2GxdzSF1GY98smvllNiOE/Xijsxf8xj27nawSiTyb3/RZdI2ZJhCtCldUVuEGx2D
         406w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775128865; x=1775733665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRc0fEF+ONqvVzDqGIKgEG9scIir8NhohKRP5U8geGw=;
        b=Zd9nsV/Xq+JjGsryEiuxPyTV2WK9OTGMxyB435RPL24pmXf7C5btAK7W0JhbjvQM5C
         /+9Mye9my906ryCjxEFIkR1Hs6dgsjCBC8ayvjNsQLeyPmqnBGMfBVPlZa51ohuSPF4T
         o39CLtSvdS3W2sOph1qPyFJX0c/N8/2BWwbgUTyrqfLpuLPwswGQiZtqEFUaTQc098kM
         PG5qTr1TJmfBCyHcs/CmHW6Vzczulb8cnkkMoNA3hmyoYto8lhue1uECYhkgMgo0Z6fq
         tgSCoyTWQTDlCFH0qmn8CmgdYVNCfG8o+wQJuyrfGsZIIufku+wsXN3vYgX6/8Axyo+N
         I5Lw==
X-Gm-Message-State: AOJu0Yz/xQy+BJjGU2zemVpCpEHvLehmPhB4+bqaWAFrH8lBEaxOeTVU
	7KWHLTE55pT2iagmMoEawKPbe+E27dPPn0jwVXnVjJFu1DWHlA5oVSs4KlfbZq7Z
X-Gm-Gg: AeBDievrKu231rbM62vnqQjgCZWXIgTQo7Bip667Eajt7PR+SAISEx6gzB5q5n1HzCj
	k17+6L/lu3SpCxqx0ZqBBEskbLUfsdobS2UvAgEdce3TX7J8RX3Fv3zHGJsRWd6cjfTmpRrdy6t
	KSv1oTvPNtKKGe669XxxtR5Ju9qlEW3Q0qsLpB6ckjoxiy3zd2H2zl3ONpJdnjgcI1HpZppxwzq
	I02u/5Fz68IDuqSAWyV2eZirXPG+lz61fe9ELukT5cO5rrSHhuU2d1kU/YgWBnuX3bbpylPDKzD
	mI09Xau6b4x9X56booSUk5IMyWobgdozAKK700WeFNWcm16t0Fcf2sziqPhhxhYoQFLHvWE0P8T
	4KhZEKbFglpZlTRcWTdh/iwEVUSFHFOpO09FPbQoFEyCwkNVV8XMGJf/7XRM1xPVRFx4NI7Vy3R
	K7iLBGGKEyTf4liSou3Ia0D4tnyXIelfnffxCqT+O7l4eSPF/2RL+4
X-Received: by 2002:a17:903:2986:b0:2b2:5035:dc4e with SMTP id d9443c01a7336-2b26998e690mr75785185ad.0.1775128865378;
        Thu, 02 Apr 2026 04:21:05 -0700 (PDT)
Received: from v2-email.patch ([103.181.15.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747a7115sm24924115ad.36.2026.04.02.04.21.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 04:21:05 -0700 (PDT)
From: Deepak Pathik <deepakpathik2005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org, Deepak Pathik <deepakpathik2005@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
Date: Wed, 2 Apr 2026 16:50:21 +0530
Message-ID: <20260402111800.v2-1-deepakpathik2005@gmail.com>
In-Reply-To: <20260401194000.1-deepakpathik2005@gmail.com>
References: <20260401194000.1-deepakpathik2005@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3180-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 10B8C3883ED
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
v2: use erofs_io_close() instead of raw close(); rebased on latest upstream/dev

 lib/metabox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index d5ce9e3..86a7083 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info *sbi,
 
 m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
- if (!m2gr->bmgr)
+if (!m2gr->bmgr) {
+erofs_io_close(&m2gr->vf);
 		return -ENOMEM;
+}
 	return 0;
 }
 
-- 
2.53.0


