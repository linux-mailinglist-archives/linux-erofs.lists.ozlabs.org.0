Return-Path: <linux-erofs+bounces-899-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F674B336FB
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 08:56:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9M6B1JzPz2xBV;
	Mon, 25 Aug 2025 16:56:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756105010;
	cv=none; b=YTah7QPpj6fKSxZi/O1peDKP+o3WzCH+hk8dItM7O18c5CyuCflDjHPM4xS4DbHm7fj3uDrdolAEc3fJZ37iyNa025v5djKjkwalRiavXfY2JdcqEsUZDnQQcWTTwiWpTqKWm7YFw01Mp8NIBqRwCPJRQFBE8jaHV+XZFOpVhH+Q0AK04pvi6YktKyce5RE2VoFemTLCrMA0HH8ssnYPsGQleUgsPW11AEaWNnhzLHNdlv73qlle9BxJrLrHGeO74ieYy2SROfY91T3hF3JsM2wZ+wqsX/imPtPY5AWrkNvygv2dQ7pV23kay/6nHj1bsZfaXyRlZGzaaJMZJuI5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756105010; c=relaxed/relaxed;
	bh=lGj8Uhs5AvVLXm4j/p+T7V74+SPXhbNIumRIVY3Ycgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndQegCP1ePIP1YqZaZDlPvEafZWs9K1IBxnAcCiV8RxGx4pFkYnTf+mlgmmp1xZNYsPiiBU2Z1yf3CiLCFUtw+x5k6zL+dOl/u7ijnzSvmnZGAwOuBOwud8ibI35EeZXvyJ6hBGv+4qDSWEitEYJ8nhNk/qQXrZziiqk3UgfMGvB+KTqBtu89wNlNiXNJmKfrFFtfaZc6I3ysEsEgieNaASJ8bFd3yQ1e7ElfFe6wod51Ncy46ngwggPFFCsKadbY26vJdPTRraGuf6YCMpdSM6so9OrzFB2MpbDqKk1J5iGqURNVSqV4VsOblYvWpxpsNQVaEZl8r8ywwXnTdCyDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vlic72jl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vlic72jl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9M665Cgqz3cYy
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 16:56:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756105001; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lGj8Uhs5AvVLXm4j/p+T7V74+SPXhbNIumRIVY3Ycgs=;
	b=vlic72jlyzvGRQkhNE1UFJxHDX6BFmOGJxAeJkPJsOQ5tbdwzU/RiMStEaKRRl75ow52W57ZzL75W+N6UEODyDwq78Qgw68eW0tD78tK9lfDa6OS1lXxJGdv8LrrTS0sOIT4krTSdZbd7Gv6oo+76A37K7//J1rWfU/ZHW7kGiM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmSImL5_1756104995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 14:56:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
Date: Mon, 25 Aug 2025 14:56:35 +0800
Message-ID: <20250825065635.2318673-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822084241.170054-1-friendy.su@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
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

Hi Friendy,

I applied the version as below:

Thanks,
Gao Xiang

From 631ebfada7b6733ed31d70692f08a4e0bd3dc0b8 Mon Sep 17 00:00:00 2001
From: Friendy Su <friendy.su@sony.com>
Date: Sat, 23 Aug 2025 16:34:53 +0800
Subject: [PATCH v2 applied] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev

Align inode data to huge pages on blobdev, where dsunit * blocksize =
2MiB.

When a file is mmap()'ed with dax=always, aligning to huge pages allows
the kernel to map a 2M huge page per page fault, instead of mapping
a 4KiB normal page for each page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Note that `chunksize` should not be smaller than `dsunit` so that
data alignment is preserved after deduplication.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
[ Gao Xiang: refine some informational messages. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c  | 19 +++++++++++++++++++
 man/mkfs.erofs.1 | 13 +++++++++++++
 mkfs/main.c      | 15 +++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index af6ddd7..4ed463f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,25 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
 	interval_start = 0;
 
+	/*
+	 * If dsunit <= chunksize, deduplication will not cause misalignment,
+	 * so it's uncontroversial to apply the current data alignment policy.
+	 */
+	if (sbi->bmgr->dsunit > 1 &&
+	    sbi->bmgr->dsunit <= 1u << (chunkbits - sbi->blkszbits)) {
+		off_t off = lseek(blobfile, 0, SEEK_CUR);
+
+		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+		if (lseek(blobfile, off, SEEK_SET) != off) {
+			ret = -errno;
+			erofs_err("failed to lseek blobdev@0x%llx: %s", off,
+				  erofs_strerror(ret));
+			goto err;
+		}
+		erofs_dbg("Align /%s on block #%d (0x%llx)",
+			  erofs_fspath(inode->i_srcpath), erofs_blknr(sbi, off), off);
+	}
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 63f7a2f..cc5a310 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -168,6 +168,19 @@ the output filesystem, with no leading /.
 .TP
 .BI "\-\-dsunit=" #
 Align all data block addresses to multiples of #.
+
+If \fI--dsunit\fR and \fI--chunksize\fR are both set, \fI--dsunit\fR will be
+ignored if it is larger than \fI--chunksize\fR.
+
+If \fI--dsunit\fR is larger, it spans multiple chunks, for example:
+\fI-b 4096\fR, \fI--dsunit 512\fR (2MiB), \fI--chunksize 4096\fR
+
+Once a chunk is deduplicated, all subsequent chunks will no longer be
+aligned. For optimal performance, it is recommended to set \fI--dsunit\fR to
+the same value as \fI--chunksize\fR:
+
+E.g. \fI-b\fR 4096, \fI--dsunit 512\fR (2MiB), \fI--chunksize $((4096*512))\fR
+
 .TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
diff --git a/mkfs/main.c b/mkfs/main.c
index e0ba55d..2e6de00 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1298,6 +1298,21 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		return -EINVAL;
 	}
 
+	/*
+	 * chunksize must be greater than or equal to dsunit to keep
+	 * data alignment working.
+	 *
+	 * If chunksize is smaller than dsunit (e.g., chunksize=4K, dsunit=2M),
+	 * deduplicating a chunk will cause all subsequent data to become
+	 * unaligned. Therefore, let's issue a warning here and still skip
+	 * alignment for now.
+	 */
+	if (cfg.c_chunkbits && dsunit &&
+	    1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
+		erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore dsunit !",
+			   1u << cfg.c_chunkbits, dsunit);
+	}
+
 	if (pclustersize_packed) {
 		if (pclustersize_packed < (1U << mkfs_blkszbits) ||
 		    pclustersize_packed % (1U << mkfs_blkszbits)) {
-- 
2.43.5


