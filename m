Return-Path: <linux-erofs+bounces-2202-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M6UCNDScmnKpgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2202-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 02:45:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AD6F4C0
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 02:45:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy13K5YQdz2yFY;
	Fri, 23 Jan 2026 12:45:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769132733;
	cv=none; b=QGwDl7nd/qLMPB/D9uT6PV5HOHihYVsK3uNX+OtUI65kJusK0DbAsyzTi54TR5EyZ5/HKcFHN2DF36TGMy6P5h3rmzGyqMVRqTMo3VvqIdTz2d4rSZ4nTF7VuhrRSo/ByCV8U+E/oonsTVe8Sq++NibZwsVnlwOdojtH5Kpuyx6LbAgttEdOYF+3OM7cECVv5qIOl9HpAIEtkrcpMYA61AHHgFpbx+guoT1eUwpdIF2aCT254d3eaZYLOI6/rnw3nghMMZvIfOSTKIKtx7PSW4LrNyeQblequvGA6bU2tw32S3Go2O38gL/5wq7sQVhL4IxwLVqgfda744bKl3Bdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769132733; c=relaxed/relaxed;
	bh=j6kl+aNNrzyjMKF8SjtxTwU6f9KRILQcLr8ULQnojpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC5WTP+E8/cYZnjQpZGAS88Rvc3ubgf6Y8GjolCt3OGUVm/rUAiWD4zfb49FVhKLK4dqMm/5RfLZQ30EfMzf9lpyiYhSPf8jC63O+odrWZ2JVMEq7AdbuNpvAeisfrkKPm2SYmJhP5RfiasV/TU2zKHCz3C6V2Yt3GZCa3oUlQ1edyMBZXuepzHlqbvd55WBVmzubExnDzPcZjsjHF/bA5ZBIlmTwH2qaksiFggMxI/zPkgNcSTJsvM8MwMcytRlGoYD9TN0KerbA5AM29ziMcUT8XFXmFGpmetuT4u/qvwWuX2oidR3eT+OAcza+EalJZLn4g/IUClLzidYY1VLeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZSFqI/eL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZSFqI/eL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy13G2phpz2yF1
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 12:45:30 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j6kl+aNNrzyjMKF8SjtxTwU6f9KRILQcLr8ULQnojpQ=;
	b=ZSFqI/eL8SkZkha+KVfw4O1daKwpmPXrJHkt4VIZy7RqDziP4M3b26lurC9oWQb4xEkoRMwF7
	Rx0GyuiyyZFUPRB8EwtOwz3Gm5FPYcfoydiffhkwDsmDApHzd6lHcG4G3/0z67w0SKB36Z6sAPR
	KPvfG+EO7YjzG4bNch88GYo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dy0z71kTNzRhV6;
	Fri, 23 Jan 2026 09:41:55 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 43B4F40363;
	Fri, 23 Jan 2026 09:45:20 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 09:45:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v18 07/10] erofs: pass inode to trace_erofs_read_folio
Date: Fri, 23 Jan 2026 01:31:29 +0000
Message-ID: <20260123013132.662393-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260123013132.662393-1-lihongbo22@huawei.com>
References: <20260123013132.662393-1-lihongbo22@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2202-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_COUNT_FIVE(0.00)[5];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.902];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 7D7AD6F4C0
X-Rspamd-Action: no action

The trace_erofs_read_folio accesses inode information through folio,
but this method fails if the real inode is not associated with the
folio(such as in the upcoming page cache sharing case). Therefore,
we pass the real inode to it so that the inode information can be
printed out in that case.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c              |  6 ++----
 fs/erofs/fileio.c            |  2 +-
 fs/erofs/zdata.c             |  2 +-
 include/trace/events/erofs.h | 10 +++++-----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 71e23d91123d..ea198defb531 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -385,8 +385,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 	};
 	struct erofs_iomap_iter_ctx iter_ctx = {};
 
-	trace_erofs_read_folio(folio, true);
-
+	trace_erofs_read_folio(folio_inode(folio), folio, true);
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	return 0;
 }
@@ -400,8 +399,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	struct erofs_iomap_iter_ctx iter_ctx = {};
 
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
-					readahead_count(rac), true);
-
+			      readahead_count(rac), true);
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 }
 
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 932e8b353ba1..d07dc248d264 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -161,7 +161,7 @@ static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
 	struct erofs_fileio io = {};
 	int err;
 
-	trace_erofs_read_folio(folio, true);
+	trace_erofs_read_folio(folio_inode(folio), folio, true);
 	err = erofs_fileio_scan_folio(&io, folio);
 	erofs_fileio_rq_submit(io.rq);
 	return err;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..93ab6a481b64 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1887,7 +1887,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
 	int err;
 
-	trace_erofs_read_folio(folio, false);
+	trace_erofs_read_folio(inode, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index dad7360f42f9..def20d06507b 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -82,9 +82,9 @@ TRACE_EVENT(erofs_fill_inode,
 
 TRACE_EVENT(erofs_read_folio,
 
-	TP_PROTO(struct folio *folio, bool raw),
+	TP_PROTO(struct inode *inode, struct folio *folio, bool raw),
 
-	TP_ARGS(folio, raw),
+	TP_ARGS(inode, folio, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -96,9 +96,9 @@ TRACE_EVENT(erofs_read_folio,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= folio->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_I(folio->mapping->host)->nid;
-		__entry->dir	= S_ISDIR(folio->mapping->host->i_mode);
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->nid	= EROFS_I(inode)->nid;
+		__entry->dir	= S_ISDIR(inode->i_mode);
 		__entry->index	= folio->index;
 		__entry->uptodate = folio_test_uptodate(folio);
 		__entry->raw = raw;
-- 
2.22.0


