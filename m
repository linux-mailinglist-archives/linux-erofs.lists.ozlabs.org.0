Return-Path: <linux-erofs+bounces-2330-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bnJaDoVflWmaPwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2330-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B71537A8
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG6Qg5r84z2xlq;
	Wed, 18 Feb 2026 17:43:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771396987;
	cv=none; b=CeQDh5j7shPMAn9LNzQpjw2emPcjpfj4lBauT7OQ8pAqh75hho8+SkDktIO7mJElhlCBFftpc+VNluRXv3BRWi69FNS+8gs9nRPA87ls7CePkQtsFbs8x1VsE+mhqEJbVBIiBptgKZ0utXCdoV+yPZslI1NnhZvj1gxgoQAN0eBpKkwntZ3eUbScEDB4oKUscl1Bt5mVle6EHmc32oJ9GbQwytJADk1QVMvRUssjI7QtvmDRv7/nWUvDRz04jNq1HXwqxFcsBRaB37FAC19H0WdUn1OcDaFfp+OXDdj+Hd0zJJK47xywN3EBoT/4VmycNUva7rNbsrNylKefve3DSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771396987; c=relaxed/relaxed;
	bh=Pl5TibTYI66Ow4eUtoLawILi4XvcYbW+39O2e2z/3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gvp5wctiIwwQWoKkSlxhogiq/ulXO9elMyR+greysQ5bGpFppr0vZGDpKzNFHeKyisvzrK4SbUjtcwB0QnzxLsWb+clXVhgnDepcs9HxjbzfMKxWW5vLA9QUTYpnMbDXaZfZM19655Ja8qM0E7sy5cwINhpKQHYlGWFJ0c87lktzefqizGeAukUrsAwhYvewoJEOkeebI/Zfcx/IfZ/TjFsrDJ9P4ZEmmnzbrQTclCy4DO4cUqHtv2mVROULtWknw7A0XACeUhNtrBpJHIe4QAfG9P0A7+tHvlcZZXg4avmEqVja40OAwSvMGFBLywRAt2PIu5I1QBYllvNnafk9FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P/BE49Uk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P/BE49Uk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG6Qd195tz2yrn
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 17:43:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771396978; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Pl5TibTYI66Ow4eUtoLawILi4XvcYbW+39O2e2z/3b8=;
	b=P/BE49Uk0ski6jfcGJFZ4M5xbsmoP77aUDoGyQO61h7gipUDkRCajsYUYkr260XEZe8/RnTIklTfIgc28AOvfFjHxS50f/s23V085YzyQhP26LmVCjt/CGHtaEaGofYN4JNfzNV+7KGT3M5lqYBZSDFgUe12ldE9uvMS9wOCqyg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRx9Q2_1771396973 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 14:42:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: mkfs: update compressor status
Date: Wed, 18 Feb 2026 14:42:50 +0800
Message-ID: <20260218064252.3958518-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2330-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: CD3B71537A8
X-Rspamd-Action: no action

- Promote DEFLATE compressors from EXPERIMENTAL status;

- Recommend using `-E48bit` with Zstandard compression since it doesn't
  support native fixed-size output compression (this feature has been
  requested for many years), thus the traditional unaligned compression
  has to be used. Note that further build-time optimizations together
  with `-E48bit,fragments` for Zstandard are still pending; it will be
  addressed in the next versions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compressor_deflate.c    | 8 --------
 lib/compressor_libdeflate.c | 3 ---
 lib/compressor_libzstd.c    | 3 +--
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 704a8bbd8548..f567d2c731af 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -37,8 +37,6 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 
 static int compressor_deflate_init(struct erofs_compress *c)
 {
-	static erofs_atomic_bool_t __warnonce;
-
 	if (c->private_data) {
 		kite_deflate_end(c->private_data);
 		c->private_data = NULL;
@@ -46,12 +44,6 @@ static int compressor_deflate_init(struct erofs_compress *c)
 	c->private_data = kite_deflate_init(c->compression_level, c->dict_size);
 	if (IS_ERR_VALUE(c->private_data))
 		return PTR_ERR(c->private_data);
-
-	if (!erofs_atomic_test_and_set(&__warnonce)) {
-		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
-		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
-		erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
-	}
 	return 0;
 }
 
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 186da87c9b95..18f5f7b4048c 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -120,7 +120,6 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 
 static int compressor_libdeflate_init(struct erofs_compress *c)
 {
-	static erofs_atomic_bool_t __warnonce;
 	struct erofs_libdeflate_context *ctx;
 
 	DBG_BUGON(c->private_data);
@@ -133,8 +132,6 @@ static int compressor_libdeflate_init(struct erofs_compress *c)
 		return -ENOMEM;
 	}
 	c->private_data = ctx;
-	if (!erofs_atomic_test_and_set(&__warnonce))
-		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
 	return 0;
 }
 
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index feef409c23d0..c47507716528 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -175,8 +175,7 @@ static int compressor_libzstd_init(struct erofs_compress *c)
 
 	if (!erofs_atomic_test_and_set(&__warnonce)) {
 		erofs_warn("EXPERIMENTAL libzstd compressor in use. Note that `fitblk` isn't supported by upstream zstd for now.");
-		erofs_warn("Therefore it will takes more time in order to get the optimal result.");
-		erofs_info("You could clarify further needs in zstd repository <https://github.com/facebook/zstd/issues> for reference too.");
+		erofs_warn("If unaligned compression isn't used (without -E48bit), it will take more time in order to get the optimal result.");
 	}
 	return 0;
 out_err:
-- 
2.43.5


