Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8C8A8FA8
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 01:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713397745;
	bh=aNhNE2mdpHIuiC75prfGQ6d/xN+71QZ8wEjAAVDxknQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=b55Y4cSw9RQna8JxSZv8tTCWgrQmYAyy18Rh1jqLO/i4+hwLcFy6q/Qghz5H0t2Ep
	 Y1GVv+KAyE/UTv2wERGHtrCFZjRFMk7X4B25q1urYdDQQgKf+ctUtkp98K9C2ryPyl
	 8sg40eMTkhMT+2oezBVcHS9mTo5e6J439Kf0PrYQbzpCYZMAWrHyRqfoeEmjs2evM2
	 q3QKMSUScQwc5kUlm6vEDrmqRW7qIT2YwJ6Vr9Z/mY7DWyw6Efo/wvxpPV4eOrtfUf
	 ZJgizlYkos5AAT2Lip2imZWWHrLeafdkQxutf9sWzcaeiQ77UeTdIHQ3egfFbWdIHn
	 gZoRETYHz869g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKd0c6z0yz3cR2
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 09:49:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=sW5FfcQj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=34l8gzgckc1s6a3o3e79hh9e7.5hfebgnq-7kh8leblml.hse34l.hk9@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKd0R6HcHz2xqq
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 09:48:53 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-615372710c4so4503877b3.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 16:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397731; x=1714002531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNhNE2mdpHIuiC75prfGQ6d/xN+71QZ8wEjAAVDxknQ=;
        b=kdX1l2fKdmaqpBsspEtCNqCU9MuAV+ACMohllMQDAjyFsjkvCRicNSJrfF6M1tISTZ
         nQWCHbx64R10fUcqEeZCStd7Zf2JM28SS1F6cVszNBjmVOU4mectPTmZZZ9pw9BSScvB
         3A17QxBLqcYF65VVwHxO3GsErig8JPlQf5vvUBTigW/kY+rv7fl8BIKpV1GIiOzsmAmZ
         Bu4yg4vFuCBOL++YNTSzkvStqHQUfXz9/HJ1vSoLh1kPnp8zDzpvwQ7YZy7XwqUzRsMS
         ljCY8zna1ky4isOLegbxO3gl6/yn9Fl29nYOcyc3JVSiKCfUwI/ygemFU+cpxXeUkgTn
         4a1g==
X-Gm-Message-State: AOJu0Yz+/7sD6mq0G4+DnZffo081X50obr22lIqqqI0rtW+jnLnvtdiM
	YFEC/EgL16KmEqJZGEW5vI80UTdxE9ZtCEEai92E5QUNrlqmbEvEFm+b0ZahYRhcF31OXZ/kS87
	jJuiKNhjm37XGD3Io31ux9NftksFmtYh15MVfKCLfxIkHfMg2L9NZcIbT6djjm9hUChm+xKefDu
	NDAnVt77ljLjoqpZX80k/f+J1grunUckafqO6DFcUeS3nk7A==
X-Google-Smtp-Source: AGHT+IH8MwogsaR8bmxFEpkAcnwoOS/UOJMDQhmo1U6Ryjnv9e5ji7saiGEwdVco0fJziIRuhAl1XjmD6JbQ
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:75ed:d8bf:5101:cbc8])
 (user=dhavale job=sendgmr) by 2002:a05:6902:50a:b0:de3:c617:b89e with SMTP id
 x10-20020a056902050a00b00de3c617b89emr111806ybs.12.1713397730929; Wed, 17 Apr
 2024 16:48:50 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:48:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417234845.2758882-1-dhavale@google.com>
Subject: [PATCH v3] erofs-utils: lib: treat data blocks filled with 0s as a hole
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

Add optimization to treat data blocks filled with 0s as a hole.
Even though diskspace savings are comparable to chunk based or dedupe,
having no block assigned saves us redundant disk IOs during read.

To detect blocks filled with zeros during chunking, we insert block
filled with zeros (zerochunk) in the hashmap. If we detect a possible
dedupe, we map it to the hole so there is no physical block assigned.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v2:
	- Fix memory leak for zeros buffer
	- Add and use helper erofs_blob_can_merge() as suggested by Gao
	- Return erofs_holechunk directly from erofs_blob_getchunk()
Changes since v1:
	- Instead of checking every block for 0s word by word,
	  add a zerochunk in blobs during init. So we effectively
	  detect the zero blocks by comparing the hash.
 include/erofs/blobchunk.h |  2 +-
 lib/blobchunk.c           | 74 +++++++++++++++++++++++++++++++++------
 mkfs/main.c               |  2 +-
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index a674640..ebe2efe 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -23,7 +23,7 @@ int erofs_write_zero_inode(struct erofs_inode *inode);
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
-int erofs_blob_init(const char *blobfile_path);
+int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize);
 int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 
 #ifdef __cplusplus
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 641e3d4..5830498 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -69,6 +69,10 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
 	if (chunk) {
 		DBG_BUGON(chunksize != chunk->chunksize);
+
+		if (chunk->blkaddr == erofs_holechunk.blkaddr)
+			chunk = &erofs_holechunk;
+
 		sbi->saved_by_deduplication += chunksize;
 		erofs_dbg("Found duplicated chunk at %u", chunk->blkaddr);
 		return chunk;
@@ -231,7 +235,21 @@ static void erofs_update_minextblks(struct erofs_sb_info *sbi,
 	if (lb && lb < *minextblks)
 		*minextblks = lb;
 }
-
+static bool erofs_blob_can_merge(struct erofs_sb_info *sbi,
+				 struct erofs_blobchunk *lastch,
+				 struct erofs_blobchunk *chunk)
+{
+	if (!lastch)
+		return true;
+	if (lastch == &erofs_holechunk && chunk == &erofs_holechunk)
+		return true;
+	if (lastch->device_id == chunk->device_id &&
+		erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize ==
+		erofs_pos(sbi, chunk->blkaddr))
+		return true;
+
+	return false;
+}
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
@@ -303,16 +321,19 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		}
 
 		if (offset > pos) {
-			len = 0;
-			erofs_update_minextblks(sbi, interval_start, pos,
-						&minextblks);
+			if (!erofs_blob_can_merge(sbi, lastch,
+							&erofs_holechunk)) {
+				erofs_update_minextblks(sbi, interval_start,
+							pos, &minextblks);
+				interval_start = pos;
+			}
 			do {
 				*(void **)idx++ = &erofs_holechunk;
 				pos += chunksize;
 			} while (pos < offset);
 			DBG_BUGON(pos != offset);
-			lastch = NULL;
-			interval_start = pos;
+			lastch = &erofs_holechunk;
+			len = 0;
 			continue;
 		}
 #endif
@@ -330,9 +351,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			goto err;
 		}
 
-		if (lastch && (lastch->device_id != chunk->device_id ||
-		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
-		    erofs_pos(sbi, chunk->blkaddr))) {
+		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
 			erofs_update_minextblks(sbi, interval_start, pos,
 						&minextblks);
 			interval_start = pos;
@@ -540,7 +559,40 @@ void erofs_blob_exit(void)
 	}
 }
 
-int erofs_blob_init(const char *blobfile_path)
+static int erofs_insert_zerochunk(erofs_off_t chunksize)
+{
+	u8 *zeros;
+	struct erofs_blobchunk *chunk;
+	u8 sha256[32];
+	unsigned int hash;
+	int ret = 0;
+
+	zeros = calloc(1, chunksize);
+	if (!zeros)
+		return -ENOMEM;
+
+	erofs_sha256(zeros, chunksize, sha256);
+	hash = memhash(sha256, sizeof(sha256));
+	chunk = malloc(sizeof(struct erofs_blobchunk));
+	if (!chunk) {
+		ret = -ENOMEM;
+		goto out_free_zeros;
+	}
+
+	chunk->chunksize = chunksize;
+	/* treat chunk filled with zeros as hole */
+	chunk->blkaddr = erofs_holechunk.blkaddr;
+	memcpy(chunk->sha256, sha256, sizeof(sha256));
+
+	hashmap_entry_init(&chunk->ent, hash);
+	hashmap_add(&blob_hashmap, chunk);
+
+out_free_zeros:
+	free(zeros);
+	return ret;
+}
+
+int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
 {
 	if (!blobfile_path) {
 #ifdef HAVE_TMPFILE64
@@ -557,7 +609,7 @@ int erofs_blob_init(const char *blobfile_path)
 		return -EACCES;
 
 	hashmap_init(&blob_hashmap, erofs_blob_hashmap_cmp, 0);
-	return 0;
+	return erofs_insert_zerochunk(chunksize);
 }
 
 int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
diff --git a/mkfs/main.c b/mkfs/main.c
index 2fb4a57..d632f74 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1255,7 +1255,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_chunkbits) {
-		err = erofs_blob_init(cfg.c_blobdev_path);
+		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
 			return 1;
 	}
-- 
2.44.0.683.g7961c838ac-goog

