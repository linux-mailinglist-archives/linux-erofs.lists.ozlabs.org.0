Return-Path: <linux-erofs+bounces-3086-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF98MxXgyWn83AUAu9opvQ
	(envelope-from <linux-erofs+bounces-3086-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 04:29:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC3354CDD
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 04:29:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkZvk2GcKz2xly;
	Mon, 30 Mar 2026 13:29:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774837778;
	cv=none; b=kZK63gEVeaczLXohhXsCxPfUKJBHbOI1WZqSUqekdvm+DX8hznyUEpf03CiW25igvT1ubi8GKdH9/xPS461j/SvyTRiObZPxTdCo+SscI/get44K2Ui/GdpNqnWSz6USXKxl7Bb5gtAseO4OaTCUwV5wNku84SW6MawCDFFwx7PM64Cr0Bv4ae4YL/90hq8OmTkEwS2Lo/lH0dnmNIr+3I1yIRIdo2i4beF5Bn3OSsZSy4vPANjHbpULE3qnBuHqWfUNpwvqZ8Zmi7siaGEh1kVjQUCTrnAJ1AkLhvJi5Az7yjGl97gruc6AGrgfUzpkTJMHKnpbizuMO2AHa1wmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774837778; c=relaxed/relaxed;
	bh=eM3VHdhgVCPvtEOZPzd8s7fdzrhoiHKP5ui9y0tHke0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daqrZwiWdjkqd1RVANsTHfJ5HnN9zD0MzQ7Y/siGgCoOcOi5E5XouZVL/7JvHimT4vA0p+Zn/KiYHrh+Vxrzp4+QP7lVG88OCMr7RcN/Dhl1bUPlemWSGAJ5SO9/ZqPxkTQONfSH+Bdn+o0DsIo5uszRTfGCR/umcIx/xeWDKu/Be/Ch64m/FDEL2eRiWItuePHSLOotGyXkplJIMJnCO44+P4sjb2lErI8CTtsRatC2c2abwGet5Rl9Ccl4RTswQhpJ3OitRiO13SpQdyeWt+bgUPKWfe6lCb/BAZSyAqI3GzfCXHxGEFI2+C1UDvbObIA1jPeOYs+LDOIk8VHeoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZbZrvlpH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZbZrvlpH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkZvh2XKqz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 13:29:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774837771; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eM3VHdhgVCPvtEOZPzd8s7fdzrhoiHKP5ui9y0tHke0=;
	b=ZbZrvlpHbTS5pFeV1gYhuaRD8kTfcxNgUR6QFbUO0QP4NnpvKr2wXTRsSarWaUl96wY3J7JxPOK+66aKGPluUaAj0o48xMaKfJD01FOV9gP/nRF7fJ69Ysi1X3Hsgd3XH6Fc7AutUV7gygdZpsLbvWikOahBzjva9nvtz0ZHUgQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X.tyjed_1774837770;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.tyjed_1774837770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 10:29:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Yifan Zhao <stopire@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] erofs: verify metadata accesses for file-backed mounts
Date: Mon, 30 Mar 2026 10:29:29 +0800
Message-ID: <20260330022929.2119716-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260330022031.2107239-1-hsiangkao@linux.alibaba.com>
References: <20260330022031.2107239-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3086-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,gmail.com,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: EADC3354CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For file-backed mounts, metadata is fetched via the page cache of
backing inodes to avoid double caching and redundant copy ops just out
of RO uptodate folios, which is useful for Android APEXes, ComposeFS,
containerd and more for example.  However, rw_verify_area() was missing
prior to metadata accesses.

Similar to vfs_iocb_iter_read(), fix this by:
 - Enabling fanotify pre-content hooks on metadata accesses;
 - security_file_permission() for security modules.

Verified that fanotify pre-content hooks now works correctly.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Acked-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix the code comment.

 fs/erofs/data.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f79ee80627d9..687cf7e4ded0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -30,6 +30,20 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
 	pgoff_t index = (buf->off + offset) >> PAGE_SHIFT;
 	struct folio *folio = NULL;
+	loff_t fpos;
+	int err;
+
+	/*
+	 * Metadata access for file-backed mounts reuses page cache of backing
+	 * fs inodes (only folio data will be needed) to prevent double caching.
+	 * However, the data access range must be verified here in advance.
+	 */
+	if (buf->file) {
+		fpos = index << PAGE_SHIFT;
+		err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	if (buf->page) {
 		folio = page_folio(buf->page);
-- 
2.43.5


