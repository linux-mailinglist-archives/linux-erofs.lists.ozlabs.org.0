Return-Path: <linux-erofs+bounces-3197-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL2bLDy7z2kd0AYAu9opvQ
	(envelope-from <linux-erofs+bounces-3197-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765E3944DB
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnJr76kggz2ygT;
	Sat, 04 Apr 2026 00:05:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775221559;
	cv=none; b=JpSn6CtojGHsLYyiPnqIWpwbQshP4ofp5qEJkp1vglZYgNrZ/VtyOOZyqM2R6xlowhAwTWQjrRNphXEwvzPg3HL0eRUZs+B6H/CZa4OztMQ8kJ3I6XIkslqKnChT2TFcf6WsrvU3mE+NyqSHkg6cHg27jXwcwAZCBibwTmDPy8HB4EsQD5nnteCYsN6lezO16P/0hEyV4UCqJBxl1lVFdvJvdc3fcrI8cN6yhRUaF4PB0SPJMtTO2eRWmoMWl4ajxsXA58djZiU+JS31khWG9Vo5PoZbgfhBpzw01BXmnoNunSj0WiVfuL/qbVC+2YMfebLNuOhWep/NskktMNjTew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775221559; c=relaxed/relaxed;
	bh=J6BQ7vqe3j/74hko+v9ah7ZHiHfQjP9o4BjGYAxNKlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhb5JJmexXHne8b501VfrVMlsCMZmD6MZgSOHyznQ/mvFX4y26A5FP7mWXO10xy3eK+D/rq+Oa9oPCrpBdqgCXWrkEHlWTXWHZAW5OD6aiQa/UbPbHD+sjCXkTYveoO6jiuE30tfgRKCdVNZoFvIm4V68kMFGlitsQU6NgeMAlFC9BiSkbmQ5NjYyZU5zYu6YPfd9T28xR7Rwn31g7o3KdnAh+F6aEDMnVstRTSkvrHeoEqDw6OFj9+d9mi+gVjPnBi9lntwoHm3EGoQwGYwR0Q5I5BCJ9BoxTU33L3aSB8FWhqzxMEkS1bZ86AzL0az05p8JF732Wn6ZvJNJ1/T0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxUB/caK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxUB/caK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnJr659GVz2ygH
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 00:05:58 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82cebbdab08so1382772b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221556; x=1775826356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6BQ7vqe3j/74hko+v9ah7ZHiHfQjP9o4BjGYAxNKlk=;
        b=SxUB/caKnrU6f9Udyj7lK+qyPaD99LItJbeQm+oYIi/hk421650sCBpaJkhUxFq9j4
         jvpf5lRQi4li2GldCeG06Dc+0owDgKosX26JD06hmZVVnl/2ddcZyV53dVfWhgPCUCm/
         qxxwASeeZoSSsGTkeMVyO3MgUDbIkJr4cnDQ+CFB9XvrNf+95H+FIhsRIoam7D+r2Os/
         E6yMqgR91HBB3vMqLca/4BejZSZo3ZTYbvnilrdXERGrV91AVra6Gc+Li/3jaiwnvFT3
         PMQZ7Q0jtvo97AsSt1ShtF1codWbww6oD3qx8g1DdZlsFYWYh3LlXXsq1lBQb6hG0WXJ
         qSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221556; x=1775826356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J6BQ7vqe3j/74hko+v9ah7ZHiHfQjP9o4BjGYAxNKlk=;
        b=krhcS1W1kDnoVMLlxROxJV9PeP2hq+zJ3k07+k86RD9W5bREDS90Q6Y5T2i2tmYWKz
         uwshm3uT9aivVS+aVbBRnM8kqJ/ZGTlYPL7KBV/hl4tvH7o4uRZjTxXCYy2ADqzr8ivq
         KHnldYi3mPqwV5CBBYlOXsW+/xzoIdSkLCsdWbYes5tXDsFx4jx8eDlvugW6eHpY4aY7
         V0PmvMIzk2VoNY9VQGmxqVHF9Y2fCChfccsOtvNPoMoRlLLScnYeqtaLycFT7nwwe43g
         MsBzLpuZpt2DHPsWyLY/ThmKR8eSfJGk2NNO144UqlGVKOAJ9HJnpLYr/XFgR5DZGQug
         6uzA==
X-Gm-Message-State: AOJu0Yw9snnTtrknLYZ2OCrn12sKDYQi+8jxl5a+1JB9eEshUWs8ty/G
	6y+vAzAAx5HZqviR2qhk9KrU0EXynGAfkuhhJhZF446EBry8ZM5RUiLJ
X-Gm-Gg: AeBDiev1D4P0fxY+oENJf5Svy83SHXLt2aEGZ7nahF9C8Mt+H5rc6NN94n50corYN83
	aotYQ9tI4TSRFGHQ7ZIeLT5q9oRMEeKd2h4hbhYxM3e8+C+fs1Vh9JLQ2HFwXZC4gEbifyjF4LH
	4+T1i0QU8NHsGiJegJ1HAgYwQEiH1xCU15p2iKFBBk9O4ZL4ycKzmQ0xRMPa3dGSXnyd+uSzyv5
	6tfgPzaZ8lKJMwgd6wJffbiAHpA5f/GRezTZSAV2WaWo1zOdWdOEzpjieRN75aZH9OG444T0AU6
	mh53GET4r64XUG/cYCyLxfzIRMropgcxLpmYjdymwdSt5prgCKTB6cSYIEnYa0BngyGG3Jtillo
	IE4+h8OvWzRSOM952ugmzAbRTs8O70+ZtzY9SdeWNmJVIKaAglETaU2iei3s6XQx/rdWJOsD0qF
	lGFh8l4KuG4UWPlYUaPMm86RkD7byaG+8ROAzuohNx+2wJo7I=
X-Received: by 2002:a05:6a00:1a89:b0:82c:f877:3d13 with SMTP id d2e1a72fcca58-82d0db6ba53mr3267580b3a.26.1775221556417;
        Fri, 03 Apr 2026 06:05:56 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5f1dbsm6064258b3a.27.2026.04.03.06.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:05:56 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH erofs-utils v2 1/2] erofs-utils: fix swapped hi/lo in 48-bit primary blocks read
Date: Fri,  3 Apr 2026 21:05:45 +0800
Message-ID: <20260403130546.76579-2-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403130546.76579-1-zhanxusheng@xiaomi.com>
References: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
 <20260403130546.76579-1-zhanxusheng@xiaomi.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3197-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 1765E3944DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_read_superblock() combines the 48-bit primary device block count as:
    (primarydevice_blocks << 32) | blocks_hi

This places blocks_lo in the upper 32 bits and blocks_hi in the lower
16 bits, which is reversed.  The correct combination is:
      primarydevice_blocks | ((u64)blocks_hi << 32)

This is the same bug that was fixed in the Linux kernel by commit
0b96d9bed324 ("erofs: fix block count report when 48-bit layout is
on").  Apply the equivalent fix to erofs-utils.

Fixes: f5b492b27e53 ("erofs-utils: add 48-bit block addressing support")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 lib/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index 088c9a0..86d50a1 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -122,8 +122,8 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
 		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
-		sbi->primarydevice_blocks = (sbi->primarydevice_blocks << 32) |
-				le16_to_cpu(dsb->rb.blocks_hi);
+		sbi->primarydevice_blocks = sbi->primarydevice_blocks |
+				((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
 	} else {
 		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	}
-- 
2.43.0


