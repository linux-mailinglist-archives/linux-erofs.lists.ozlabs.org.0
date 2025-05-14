Return-Path: <linux-erofs+bounces-319-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46508AB6B0C
	for <lists+linux-erofs@lfdr.de>; Wed, 14 May 2025 14:08:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyBvN0cnMz2yqW;
	Wed, 14 May 2025 22:08:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747224511;
	cv=none; b=cfYMxo6uk8B6LzziCWKX2T47UuIrDN4oJX+QYF2rhN5AW8TfnHjdFQeozC0V1ZJRM16rB+qBNst2GYhyZ2jfACy6xFItBtBWbqySlXx+pOkseeLRN+MT5FarKJrg/c8+ZHJMHMFq8wHeFZ6+VyOI8tTzFWQPkuslXbfx4onCqj5octj6DCAaUAdhPU9lIUsuGn8cWC5feCpPiQFpyozGp8nq3VDyusNNF+rgt0cX6u332CieQeoYILZ6Ppz3/bUMN9MOfS9ezDug6FTSNla3vYQP+VN03B4SK3X+xZ2r8vdwaYMD8wOat1/Aaw9JpHFPIwJNbZQrCN+19pFr9xxFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747224511; c=relaxed/relaxed;
	bh=7eAMLJCK5k1FYQOA++OTzL/iUPIzGdYVuMe6yqYdMHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSPxTDJZWJ2/Ro2i+LTZ6HCsNlvzcoWa/JZNoREl3xB3tgEQZBT9ss0XYrl0CSfPB5NqDXa1dAxF78mouS9fd2OknkezeGEkOlXqEyURZ9ChWCJl2MgZAWPfo2AP62UF5ykQgAHqhxUeEs7BDyEpLbQaujz4I6BDZmXYTXw55m0SkcZjLCl3UJajJ81RkKtIL01m6heor2Wzn4jCjoFxSrF9cmjoTnStfJGJnqIMfsm9Z3rx3ATq90alAnKwmFbSnf7mPyHDg4nEDtir0g2Jjs4W4uRcLh1tTljQhPNsZ+Uhbku6NysKNhvFJ85KdNkboGwcodhKOnr8IQzA6aC/ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OBJ89n/T; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OBJ89n/T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyBvL1c9kz2ySg
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 22:08:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747224505; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7eAMLJCK5k1FYQOA++OTzL/iUPIzGdYVuMe6yqYdMHc=;
	b=OBJ89n/TqYbHcwr+U3rBLPEVkUnCRG9oX4FeOLWqMkLjDVP5dfRe39HJF7exi8eFxWBUrfjD8bhMxSir9kVRGv7kOlLf2rWVFxLqrEWBaYlUG8eo8r13HdFzGH0uYYfaZ6RMAdYV3xSbmBthuq2PIUSkwN2cD6mxNNYuSNRFa+o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Walxtxb_1747224503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 May 2025 20:08:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH RESEND] erofs: refine readahead tracepoint
Date: Wed, 14 May 2025 20:08:20 +0800
Message-ID: <20250514120820.2739288-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250514115713.2719705-1-hsiangkao@linux.alibaba.com>
References: <20250514115713.2719705-1-hsiangkao@linux.alibaba.com>
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
replace a stale version..

 fs/erofs/fileio.c            | 2 +-
 fs/erofs/zdata.c             | 5 ++---
 include/trace/events/erofs.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 60c7cc4c105c..94fff404db81 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -180,7 +180,7 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
 	struct folio *folio;
 	int err;
 
-	trace_erofs_readpages(inode, readahead_index(rac),
+	trace_erofs_readahead(inode, readahead_index(rac),
 			      readahead_count(rac), true);
 	while ((folio = readahead_folio(rac))) {
 		err = erofs_fileio_scan_folio(&io, folio);
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
index c69c7b1e41d1..a5f4b9234f46 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -113,7 +113,7 @@ TRACE_EVENT(erofs_read_folio,
 		__entry->raw)
 );
 
-TRACE_EVENT(erofs_readpages,
+TRACE_EVENT(erofs_readahead,
 
 	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
 		bool raw),
-- 
2.43.5


