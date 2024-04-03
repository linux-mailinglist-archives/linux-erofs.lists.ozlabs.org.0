Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111689655A
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 09:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712128031;
	bh=gJl8kotpMUIRgIYFPtFHK6HDWZaOUyhtqOwLH8W0PxU=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ri+HGujkWvgc0MwcSOZEAZz4466tZKyhjehRyiFaGzddQ3AlYk6CU7ATbWMPSJPvf
	 Yj6AF6IDO2KBsoNV2paCfosm0yztdaZS2gkBzbMW1fAdXaY2c+qnnIHeRgdPFfFbzn
	 vrh+iG+XJHfuIVwAeclSjv5xV9DFp9uzq8Wtvt7UZBIKxvAs/rHHVTOLUc+iIbzUpb
	 0/1cnl+2S1U5/S8zK5QVmLpcNsGWSVYzPcgvsAhsA/hbyeJLVDNdzdQhNrx2eriHX9
	 d3Hyz5cH/YMW3lkQee4bjUfl4/iTX2gP7YBSyd4gcFpdnIhDEdH9MKpHHiwZLauSDb
	 Y5HNy7vTCyZwA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8bR3681Pz3cZR
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 18:07:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=bdriY6/t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3fwanzgckc4ijng1grkmuumrk.iusrot03-kxulyroyzy.u5rghy.uxm@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8bQz5NbHz2ykn
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 18:07:06 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-60cc8d4e1a4so110059017b3.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 03 Apr 2024 00:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128024; x=1712732824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJl8kotpMUIRgIYFPtFHK6HDWZaOUyhtqOwLH8W0PxU=;
        b=CwMY/3w9YWYCS4L00G2fbBVxsEUQmUllYswa/U8aJ9yzpyVVKA0J3Sha8dDHgIO9jL
         Gap+8Yh+vQoaP8cLNXdLj2ezOo5Z5SSzE9lwItKmutU8o/JMJpOa25AmSgUgi1RHXYLC
         pNXJHdqQFY3eq3hX3k9YwPPmlkS25RTCuSMwS+dK0FvVNJkpXyMfv/Dr4P7v0HiQFC0Y
         wSBqshytXRCNv+YK2Rq0rJVEqFgLbc8r/F2hKmKOCLAO1Oa470/ARtc3qvyljYQTERsW
         eQPlABU1DlHXtDRgD0Jsxxg/P6ZQyRVG2D9uN86QoOuLF7mNwf4KJs7xF3khjajhPEgP
         ESGw==
X-Gm-Message-State: AOJu0Yx5lOORFsoGO3iAScml9E45TjVZJtyAhCJYGcFEvvEQrvVP1AtT
	Mw33RZYGWlXIYizJpI6J41eWzgPedOAyD+M84Ayhduin09xTFLO3KBZk9QYUUQ8XybW9/Cn89th
	+pYBzEZFMLpgi0PuLT1YoxwRE9rVTK+20LJ+O4po7UK8vRihoDT95iPsVRdHCilu56mc895Fm38
	KwiVVZv88IrF+K18pnvQjM/aoo0r5TRWYxzKLNZIv1SGNx2A==
X-Google-Smtp-Source: AGHT+IGNo3KhJg5QP36ju2/yoXIF0Zp2ZG5bsZ1tXk9y1qNMqJobPwUGoiHt7x2ZhFQIrevBXc+yJqok5m+4
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:9324:8a19:f8f:8ba9])
 (user=dhavale job=sendgmr) by 2002:a81:9854:0:b0:60a:3d7e:2b98 with SMTP id
 p81-20020a819854000000b0060a3d7e2b98mr3861467ywg.4.1712128023973; Wed, 03 Apr
 2024 00:07:03 -0700 (PDT)
Date: Wed,  3 Apr 2024 00:07:00 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403070700.1716252-1-dhavale@google.com>
Subject: [PATCH v2] erofs-utils: lib: Fix calculation of minextblks when
 working with sparse files
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When we work with sparse files (files with holes), we need to consider
when the contiguous data block starts after each hole to correctly calculate
minextblks so we can merge consecutive chunks later.
Now that we need to recalculate minextblks multiple places, put the logic
in helper function for avoiding repetition and easier reading.

Fixes: 7b46f7a0160a (erofs-utils: lib: merge consecutive chunks if possible)
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v1
  - Better name for helper function
  - Change helper function to modify minextblks directly

 lib/blobchunk.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index ee12194..f7aa986 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -223,6 +223,15 @@ out:
 	return 0;
 }
 
+static void erofs_update_minextblks(struct erofs_sb_info *sbi,
+		    erofs_off_t start, erofs_off_t end, erofs_blk_t *minextblks)
+{
+	erofs_blk_t lb;
+	lb = lowbit((end - start) >> sbi->blkszbits);
+	if (lb && lb < *minextblks)
+		*minextblks = lb;
+}
+
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
@@ -231,8 +240,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	unsigned int count, unit;
 	struct erofs_blobchunk *chunk, *lastch;
 	struct erofs_inode_chunk_index *idx;
-	erofs_off_t pos, len, chunksize;
-	erofs_blk_t lb, minextblks;
+	erofs_off_t pos, len, chunksize, interval_start;
+	erofs_blk_t minextblks;
 	u8 *chunkdata;
 	int ret;
 
@@ -267,9 +276,10 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		goto err;
 	}
 	idx = inode->chunkindexes;
-
 	lastch = NULL;
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
+	interval_start = 0;
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
@@ -294,12 +304,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 
 		if (offset > pos) {
 			len = 0;
+			erofs_update_minextblks(sbi, interval_start, pos,
+						&minextblks);
 			do {
 				*(void **)idx++ = &erofs_holechunk;
 				pos += chunksize;
 			} while (pos < offset);
 			DBG_BUGON(pos != offset);
 			lastch = NULL;
+			interval_start = pos;
 			continue;
 		}
 #endif
@@ -320,13 +333,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		if (lastch && (lastch->device_id != chunk->device_id ||
 		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
 		    erofs_pos(sbi, chunk->blkaddr))) {
-			lb = lowbit(pos >> sbi->blkszbits);
-			if (lb && lb < minextblks)
-				minextblks = lb;
+			erofs_update_minextblks(sbi, interval_start, pos,
+						&minextblks);
+			interval_start = pos;
 		}
 		*(void **)idx++ = chunk;
 		lastch = chunk;
 	}
+	erofs_update_minextblks(sbi, interval_start, pos,
+				&minextblks);
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
 	free(chunkdata);
 	return erofs_blob_mergechunks(inode, chunkbits,
-- 
2.44.0.478.gd926399ef9-goog

