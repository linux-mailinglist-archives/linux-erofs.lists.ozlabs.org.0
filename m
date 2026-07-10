Return-Path: <linux-erofs+bounces-3871-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iT+PC15ZUGqqxAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3871-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jul 2026 04:30:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3455736AE3
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jul 2026 04:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KIes4Guw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3871-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3871-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxG623jDLz2xSb;
	Fri, 10 Jul 2026 12:30:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783650650;
	cv=none; b=j2azE1XRzn5YvW4cur1bFVYZY/bzWV4Z4THheapCrK+6wDTSl3fbA9+MjISCCpQThOLBp3SOvriMymQzmhXhbySgRZOnq4eCO51B+z8IphffpUbBK+B9wcwFSCXi9fqKLY10nq2nmd1kEykZQApQ4c0zT0ZwMpYPkSXbtY72U96ruv/AujDRPFhNAld/VAhsbfyryKPaD+GZgi8yzSk3jsTTyE3/7eDyciQwrewgfwEKgAbK0a+mhKAvOCZO9rvJ95FZy4ERwgnrnTQD7FgteYrgfEwbqrxZv7Ws2RckAJjMoeOsNfgHS2192D+3BrskBjh10hF11kSh+gERkBpGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783650650; c=relaxed/relaxed;
	bh=MmyA50XS4r2q2+to0CnCcs4o3TfllBec+8WuJlT9k1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hiu2XvvwWi0jwUEDT0pxOFEFZK8zhtgb3JYJo6RrGNs1740SiNqx5ZBfTBAJIo0fcKQ43jksgh85SJZLBQvNLmZsaRiZSddKKYbhztbD3UUoJGcT2/R4ZKLtLAkBModNP2zpwZfzH3sonXP20LlCDJAXBnisSiYYwfz5paxG4pY/LaTGhjxj5+NLGtcIj6N1Ke8HSJ44XmSxW+Bt8USLeOERXB48GFshX37loRgpWMn+BrC7TNWrKYhgWjXVTGE6hNHYnDy4TvFrK9VdEgXmk3dFngc/zfr8ei1993ZLhtnICAWxA+3Z6iZ690wxjG/xWWg0rQeuh6TsomHEyLppbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KIes4Guw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=michael.bommarito@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxG606p6Dz2xJT
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Jul 2026 12:30:47 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-51c15bf5000so1895211cf.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650645; x=1784255445; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmyA50XS4r2q2+to0CnCcs4o3TfllBec+8WuJlT9k1I=;
        b=KIes4GuwsVfUdKWa87gy4rdIFnmzHT1f9ojGvnx5qmGryEV8STI5L5dmvRBtv689fX
         oFsAAiCnQzJEeHatHU0WJhUxO9vVnkuezqeXbGyMRrk3XQXts08owssY7iikAenDDx66
         CO8DXFcknxUFvlhkF3CAzHmQp+3XSluhgUbsiEIm1GlxQIMOuMAi24lAOQIHAqaWcpfl
         GL0+pO1NqvhBH4d3JkTDEAglFRWt/g+fit6i05A3IWRXTJfjh2vKqmveGHbCbVraT0et
         3+ZpE1JruBpYeXIHbavx4hF4S1XvzOEI91DFL6noQ1a1PmsJLYhjC5y2ysjpKs3Jr0vg
         /9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650645; x=1784255445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmyA50XS4r2q2+to0CnCcs4o3TfllBec+8WuJlT9k1I=;
        b=TS626OCEdzBlue9yHfG4xVmJPvCgKS5Qvblb5Lyng+pZFq9elln7hii2Vi5vglNQ5W
         Axtt298c2s5x2XbRlrsr1o9mMtwhL5y7AB/2UOjElKAuwsTqtSM4EKk+vJVcruuPGIWn
         88pSm64Mb46dheohZzjflRE4GRWiCLdYWzlcxvRqjbjKAVW7e/5W9Q/heiiuH5u99YoD
         L1oyshnYa+weesbB2DYUZJngEne9YFakfgRp+d45jRfqWDvWK37HmYKVXkyA4s9E1p3R
         nYZfqSdJmfUtscQmkHxsym7DrR0OJsSZ2WPud17/R5gpzP+6Cn9F+4aqRdNUj1KhkP7L
         /RZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNZbDh+WNDMINhQIVSmMDSCUBeY0dJ8FZvCosDaCrCPCJCHl3DvhuRSr9HLUEG/OhKr8M/GNJFRy/aDw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoASb7K47m3CYHlLz4r39LAuavtajMc30vfahSWqozZ7uBchbe
	HOuSAPvtt0apISyfxa6GqNc3bJ/N8hshpA6PGFD8bfA/apYeqRIu5FGo
X-Gm-Gg: AfdE7clKq01s3LOjCjSkrmJBWJizj7p0bUOGQWwdO7Utz0XXY6EW4CHjB4HfHQsfVrx
	XG/v3T8dnZhocPAAEaD1jbru/ytAIR6vOBqj4hbnWJ91mPMxuBKaC78i8z1EgpERjHeMUHpWZ84
	MvyOILAp2lJubp01MBrxwezOzH1UwrfxVEKxF7tEV9Cox7jCjhyeyVUmStVHtim6vAEjP59QSm4
	JjO/r7jxEyIcgNnCMBTS7iHngEch6j8vrd0QRICMQOosKCec8XpLZk0aRfkUnI+XcDAw6bzhn99
	p8njdZYqjcJjJJ1cgravkMT4VXC4Xzd3tnz1KtDSI/wjkSdeBz91ZnyiGtQ+Aw6BS997pkLhfcJ
	uvz6w8z07oz8ovqNjbMO91cptmiH6QtYQ0ws/k/0Oty4rm/6lvmUIx2z3YeyxrP/5/i+K9sRyyE
	UkvLuyxWhml1bSPOljva4LU8KB/FFsy89vkWxDR0xbk9HkXzZ0BAPcNQezjNsGaIMlifVtHu3Pw
	6fvD7KXj9dMFAmdRlgSozIKeE4WS3ro
X-Received: by 2002:ac8:7dcb:0:b0:51c:7b12:600b with SMTP id d75a77b69052e-51c8b58e364mr116647591cf.87.1783650644940;
        Thu, 09 Jul 2026 19:30:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm7251381cf.12.2026.07.09.19.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] erofs: cap LZMA stream pool size
Date: Thu,  9 Jul 2026 22:30:36 -0400
Message-ID: <20260710023036.3745254-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3871-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3455736AE3

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() or lzma_streams, then
z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Cap the LZMA stream pool at 16 streams.  That keeps the worst-case
preallocated dictionary pool at 128 MiB while preserving the existing
per-image dictionary limit.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/erofs/decompressor_lzma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..7bda4b73c2e41 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -8,6 +8,13 @@ struct z_erofs_lzma {
 	u8 bounce[PAGE_SIZE];
 };
 
+/*
+ * One MicroLZMA decoder can pin an 8 MiB dictionary. Bound the
+ * module-global stream pool so an image cannot multiply that by large CPU
+ * counts.
+ */
+#define Z_EROFS_LZMA_MAX_STREAMS	16
+
 /* considering the LZMA performance, no need to use a lockless list for now */
 static DEFINE_SPINLOCK(z_erofs_lzma_lock);
 static unsigned int z_erofs_lzma_max_dictsize;
@@ -52,6 +59,8 @@ static int __init z_erofs_lzma_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
 		z_erofs_lzma_nstrms = num_possible_cpus();
+	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
+				    Z_EROFS_LZMA_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0


