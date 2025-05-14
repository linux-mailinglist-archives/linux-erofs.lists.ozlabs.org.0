Return-Path: <linux-erofs+bounces-318-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389DAB6AAE
	for <lists+linux-erofs@lfdr.de>; Wed, 14 May 2025 13:57:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyBfb2B7Jz2yqW;
	Wed, 14 May 2025 21:57:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747223847;
	cv=none; b=Y8VXNma4ARzpOSPpe4dUK/zaPPmUUNcm0nmBLTumo7AgyvzIOTdt/7Fz6Vz3WMy4+RZ8OZMCabQEmoqTthWjUKFNa3vHQdcUmYSjYX5z3pxEwGt+YIdLm8iMcIOiSSKEDIr2hpd0Ym1hHR2AYyy8mBe5KCFtQJpXF67dy2xmfi22Q1JJD55xY8QmrHKFeMBP/tYJ81HpWFFGAgOiX1Uavaik1xlOV6NTvAKXEWu8LKStpVirts4cLp3sVlKkDXbExtAjmDVT8XrMezXLhX49A/gCXzIfXLZN4Ed6FwdtUgD8tPbE72mdiB4aWhd178iYO4hXR44h7qfhSXv0CFc+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747223847; c=relaxed/relaxed;
	bh=X6Xt+gme88eWtaAzO7wjB1rqU85g/KZnskzOAk8sCIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dn1vNW1cUqEeQb3zXsL4usVkGGgR2FfJMvWOmFeXiuFdGQrKREv3UbVZck/zMS6OQUvQJ8y6TZophZhYA87m4h81jgO0H+hfXa2gLPKpjy3wLKU0srgc0qkuO0wfxeNs08y5LNmLLCDWWFBNTlppLqWJSdbcOSA0Lrc1lCKxpLA24dlcrMzJ9qaNFYN74cfWnIAUl8JO/lV0eaVqM7Xb0/7grqj4Dc/WneihKVN8P56tPZ7cdAZnAQIhVNvx5T9oE2rzucprb/6kczdpLxMLfrcutUhN2o01DgXV5KNP5RC9UFCZLS3gke4DcK8OMWJbzqWwNkYU1mbnokZ0OwOmMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C2ukb24c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C2ukb24c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyBfY4MTQz2ySg
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 21:57:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747223841; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X6Xt+gme88eWtaAzO7wjB1rqU85g/KZnskzOAk8sCIk=;
	b=C2ukb24cZFOlgERYuk1HF6Fa3pH3WgABWlX6FJ4RVZFRyKTyGJN7ZMq92gEWjY0DAdWWuoUdvFqWWWu1GHKrvW6a/MnclaeRY+YtHqeyZzN2xHAnjJjoK06gZ9Xak49LK2t7Xl6Sh7nxcm1iltHsoVKJEd26/B3NTjs87KmdZxo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Walx0ZR_1747223834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 May 2025 19:57:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: refine readahead tracepoint
Date: Wed, 14 May 2025 19:57:13 +0800
Message-ID: <20250514115713.2719705-1-hsiangkao@linux.alibaba.com>
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

 - trace_erofs_readpages => trace_erofs_readahead;

 - Rename a redundant statement `nrpages = readahead_count(rac);`;

 - Move the tracepoint to the beginning of z_erofs_readahead().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c             | 5 ++---
 include/trace/events/erofs.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b8e6b76c23d5..29541e0787b8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1855,13 +1855,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
 	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
-	struct folio *head = NULL, *folio;
 	unsigned int nrpages = readahead_count(rac);
+	struct folio *head = NULL, *folio;
 	int err;
 
+	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
-	nrpages = readahead_count(rac);
-	trace_erofs_readpages(inode, readahead_index(rac), nrpages, false);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
 		head = folio;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index c69c7b1e41d1..644d4cbd3d80 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -113,7 +113,7 @@ TRACE_EVENT(erofs_read_folio,
 		__entry->raw)
 );
 
-TRACE_EVENT(erofs_readpages,
+TRACE_EVENT(erofs_readahead,
 
 	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
 		bool raw),
@@ -138,7 +138,7 @@ TRACE_EVENT(erofs_readpages,
 
 	TP_printk("dev = (%d,%d), nid = %llu, start = %lu nrpage = %u raw = %d",
 		show_dev_nid(__entry),
-		(unsigned long)__entry->start,
+		(unsigned long)__entry->start,`
 		__entry->nrpage,
 		__entry->raw)
 );
-- 
2.43.5


