Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D889E594
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Apr 2024 00:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712700895;
	bh=RH5GzvAm797MYUBVHafoSyKwx0jQDdQTZNcpnLrte2M=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=UHwyBbknbUirQa5aphFYtKkX4p6HekiJrDuKHEZ+wWeOjRZCX7ZLzqNlc/ECsfPBM
	 2nBuQ5qI8nnFiF77boXrYPMgNyaF6b+hRpe/hycJbGyezngc5T64w+sMRB4vFb/W8F
	 IVuaLcDFrA9JAyeEeMdOk/qvKPLKgHDg3nTH0Nj0PjjeYlUwn5/g4eBWZK/0icSqPe
	 LLXVBM44UKClKqb3UhY6ei2K72tn4Gxxv8wDazICZ5wvfp8Mx3kE2AGswfDTkldkTJ
	 1aame0DvqR25MZptgRiZgmSdalb4+rMUU8wLk2cdxLWP16CjLHH/+dVbfgcw37fDZp
	 NjbWd5YTlQ8AQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDgHg3bClz3d2W
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Apr 2024 08:14:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KvAmdZ2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=30l0vzgckc9k8c5q5g9bjjbg9.7jhgdips-9mjangdnon.jug56n.jmb@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDgHX5gTqz3bs0
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Apr 2024 08:14:46 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dc64f63d768so10242812276.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Apr 2024 15:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712700881; x=1713305681;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH5GzvAm797MYUBVHafoSyKwx0jQDdQTZNcpnLrte2M=;
        b=mVv9B6gyPTI2VkRAJ3EIOlNz9NU2/v86nNwfBWnsISf0i4pxYwYCBr3smbmhWnNcaf
         0c6YXuqJXsrqshJzWtKzXjFfW27K6sb2C9fZayETYE7wlJgw2mb1I9PRuPqnFQG9Jkr6
         Fm99vh5ZBZEsCXB8OaUjkiPcIRP9toiJvueZs22kmjklolE9VMbiD+zGT7eeiBNdwshK
         O+WZmtl9mAK8as2l1/H60snuJJfsMIVomw3RdkSMfKL+IlJthMYS0Ir/16JJPevxkskg
         I0Xz1KqXd+8I07IcuYlgaFP9uUXyceaMxREuTZixStOkf3uZecGYTbjxHovw+sj0Bg0Q
         aCxw==
X-Gm-Message-State: AOJu0YxXhK6UAwZWLdP4OLcxnY+9oQga/b9pIf1mBCPucirua/qAZr33
	B4LF4VdRFpZs4Yb1LTlIGA6tubrcDO0uYa0U0yXpHo7Kbxb4OwE7i/heymqxxb5nAaHeoTwtA0I
	CISsxKme8a9JCNn5+w7beuP4o3o9ePugKPV4OfDbAKJzyepD4LgBNadplk99eqPwOP1KB7oFlYO
	chX3hIWLx2TLGoGZOs4vDWOwri9ugW69tvV3zg0XrMEBavzA==
X-Google-Smtp-Source: AGHT+IHy9NG5ns6Z+zpM0egVErcWI2HdLZiZyvgDH1qJfaiVLGmbat5zE8ENlSY5Cab2ZxND1M2C47wFUWN8
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:be:e476:7493:2b53])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1820:b0:dc7:9218:df47 with SMTP
 id cf32-20020a056902182000b00dc79218df47mr291986ybb.5.1712700880914; Tue, 09
 Apr 2024 15:14:40 -0700 (PDT)
Date: Tue,  9 Apr 2024 15:14:30 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409221430.3897453-1-dhavale@google.com>
Subject: [PATCH v2] erofs-utils: lib: treat data blocks filled with 0s as a hole
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
Changes since v1:
	- Instead of checking every block for 0s word by word,
	  add a zerochunk in blobs during init. So we effectively
	  detect the zero blocks by comparing the hash.
 include/erofs/blobchunk.h |  2 +-
 lib/blobchunk.c           | 41 ++++++++++++++++++++++++++++++++++++---
 mkfs/main.c               |  2 +-
 3 files changed, 40 insertions(+), 5 deletions(-)

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
index 641e3d4..87c153f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -323,13 +323,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			ret = -EIO;
 			goto err;
 		}
-
 		chunk = erofs_blob_getchunk(sbi, chunkdata, len);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
 			goto err;
 		}
 
+		if (chunk->blkaddr == erofs_holechunk.blkaddr) {
+			*(void **)idx++ = &erofs_holechunk;
+			erofs_update_minextblks(sbi, interval_start, pos,
+						&minextblks);
+			interval_start = pos + len;
+			lastch = NULL;
+			continue;
+		}
+
 		if (lastch && (lastch->device_id != chunk->device_id ||
 		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
 		    erofs_pos(sbi, chunk->blkaddr))) {
@@ -540,7 +548,34 @@ void erofs_blob_exit(void)
 	}
 }
 
-int erofs_blob_init(const char *blobfile_path)
+static int erofs_insert_zerochunk(erofs_off_t chunksize)
+{
+	u8 *zeros;
+	struct erofs_blobchunk *chunk;
+	u8 sha256[32];
+	unsigned int hash;
+
+	zeros = calloc(1, chunksize);
+	if (!zeros)
+		return -ENOMEM;
+
+	erofs_sha256(zeros, chunksize, sha256);
+	hash = memhash(sha256, sizeof(sha256));
+	chunk = malloc(sizeof(struct erofs_blobchunk));
+	if (!chunk)
+		return -ENOMEM;
+
+	chunk->chunksize = chunksize;
+	/* treat chunk filled with zeros as hole */
+	chunk->blkaddr = erofs_holechunk.blkaddr;
+	memcpy(chunk->sha256, sha256, sizeof(sha256));
+
+	hashmap_entry_init(&chunk->ent, hash);
+	hashmap_add(&blob_hashmap, chunk);
+	return 0;
+}
+
+int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
 {
 	if (!blobfile_path) {
 #ifdef HAVE_TMPFILE64
@@ -557,7 +592,7 @@ int erofs_blob_init(const char *blobfile_path)
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
2.44.0.478.gd926399ef9-goog

