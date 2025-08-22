Return-Path: <linux-erofs+bounces-871-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FDB31228
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 10:47:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Yj666lgz30RJ;
	Fri, 22 Aug 2025 18:47:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755852442;
	cv=none; b=Sr2zNZ5WBhfKwlBpsqGlftPD7t1rkOS6ZstVL5+ilGMd4P2EB6nFlZ120QQAlDUmoxcyCPBtIcKThuNsv15AIvqNOYfS12v+G0hJn6F5QgJRLK7BJMTVGgWky8A1B/FojBc4PMJRoUlNEBXPKEdQpZj+wD8cXNJrb2EPqKkJwyWhHwgy59svH8JJaO+BGsyiuXRbbgd29rIzyypCERRLoB8tEac3wxm+VNDpaJYs6hW9Cif92LGaXjrz8H0o+9uFYrSYAsTTwigqDJPXjewJ+am7VS5r+7z8BDVRFQ2XNQ3kze8Zyu1rWqPFmjN4RACWFbQAUoyvKBOtD41hp6WUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755852442; c=relaxed/relaxed;
	bh=5GjJoqe/D09OtiF2kHwAZ6dKks4Aaswzq+OMw3cpRsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oetfKR5Px2M3O0HvKeM/hQGqg6pRltPP4bzneCcJXcI1Q/fFFGsFEALykTGtmrwaVyEMfLZo7dk+xfU/JvphlbKgIIfswjpR6dm4Vdrnuf97oa+Z7S6HLZ+kir7vabr2xqLtz74lrUC0GUzYxCRPVrHyCaqRQ9AVULmBgkPBvBMXiWABrUWDt7Q12eaBMuUTZpIj6dzhQeB6Fl232bUzXGHAEASJxhVaWF//lFc9NWintdOyWbyoCULeJgHyT99/sWkBEA0joE2vcmJpk5+CMN8LmtPELCGy39eoKjgutzRnqv/iSaEdIIm0+D5mFbeJLrRHUYN0z0Xc9UQQweCePA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=N08Bp8RX; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=N08Bp8RX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Yj53xMfz30Ff
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 18:47:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1755852441; x=1787388441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5GjJoqe/D09OtiF2kHwAZ6dKks4Aaswzq+OMw3cpRsk=;
  b=N08Bp8RXzfoC0MI9dIzxDTUDhWa6lK4tkjg/G4zmz1A15UwvZlhVSqMq
   8lqaM/7Mi/u8HHjxQ7J1Rz2LML3xwwSKTD8bbLSQgLEBqlUFYwwu7fYdp
   Rdy5eYCjuuInQk4XlacR3RNTv0gcx2ryhmxhCiuS4QCMG0W/l7EoHfEFA
   Xcsd14qjTMI5ff0B3L7o94NRteR4E5+NZ2OkpKk3yLH1R9wgwLXmKazQ1
   sYkudd5rxWvd+igeD3VTPaSZxNcOtJMPxxy7Mr7qKpnN9h9gcABFNITa1
   Yk4agZIf8pY1/fR+raRCjNuXEvYQ4q2wXhtVPvtDBygTrnAaD2M6wX+jV
   g==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 17:47:15 +0900
X-IronPort-AV: E=Sophos;i="6.17,309,1747666800"; 
   d="scan'208";a="19313598"
Received: from unknown (HELO cscsh-5109200313..) ([IPv6:2403:700:0:20a2::1e0f])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 22 Aug 2025 17:47:15 +0900
From: Friendy Su <friendy.su@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
Date: Fri, 22 Aug 2025 16:42:41 +0800
Message-Id: <20250822084241.170054-1-friendy.su@sony.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Set proper 'dsunit' to let file body align on huge page on blobdev,

where 'dsunit' * 'blocksize' = huge page size (2M).

When do mmap() a file mounted with dax=always, aligning on huge page
makes kernel map huge page(2M) per page fault exception, compared with
mapping normal page(4K) per page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Considering deduplication, 'chunksize' should not be smaller than
'dsunit', then after dedupliation, still align on dsunit.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 lib/blobchunk.c  | 15 +++++++++++++++
 man/mkfs.erofs.1 | 15 +++++++++++++++
 mkfs/main.c      | 13 +++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index bbc69cf..e47afb5 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
 	interval_start = 0;
 
+	/* Align file on 'dsunit' */
+	if (sbi->bmgr->dsunit > 1) {
+		off_t off = lseek(blobfile, 0, SEEK_CUR);
+
+		erofs_dbg("Try to round up 0x%llx to align on %d blocks (dsunit)",
+				off, sbi->bmgr->dsunit);
+		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+		if (lseek(blobfile, off, SEEK_SET) != off) {
+			ret = -errno;
+			erofs_err("lseek to blobdev 0x%llx error", off);
+			goto err;
+		}
+		erofs_dbg("Aligned on 0x%llx", off);
+	}
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 63f7a2f..9075522 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -168,6 +168,21 @@ the output filesystem, with no leading /.
 .TP
 .BI "\-\-dsunit=" #
 Align all data block addresses to multiples of #.
+
+If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be ignored
+if it is bigger than \fBchunksize\fR.
+
+This is for keeping alignment after deduplication.
+If \fBdsunit\fR is bigger, it contains several chunks,
+
+E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=4096
+
+Once 1 chunk is deduplicated, the chunks thereafter will not be aligned any
+longer. In order to achieve the best performance, recommend to set \fBdsunit\fR
+same as \fBchunksize\fR.
+
+E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=$((4096*512))
+
 .TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
diff --git a/mkfs/main.c b/mkfs/main.c
index 30804d1..fcb2b89 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1098,6 +1098,19 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	/*
+	 * once align data on dsunit, in order to keep alignment after deduplication
+	 * chunksize should be equal to or bigger than dsunit.
+	 * if chunksize is smaller than dsunit, e.g. chunksize=4k, dsunit=2M,
+	 * once a chunk is deduplicated, all data thereafter will be unaligned.
+	 * so ignore dsunit under such case.
+	 */
+	if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
+		erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore dsunit !",
+				1u << cfg.c_chunkbits, dsunit);
+		dsunit = 0;
+	}
+
 	if (pclustersize_packed) {
 		if (pclustersize_packed < erofs_blksiz(&g_sbi) ||
 		    pclustersize_packed % erofs_blksiz(&g_sbi)) {
-- 
2.34.1


