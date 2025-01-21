Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1AA17FDF
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 15:34:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcqTj0vvhz30Vf
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2025 01:34:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737470055;
	cv=none; b=UcA4IvvA+H6X+eIosCH7Jat3cFFG0yAKG2QLUKVvzrKDl27tBN1IrFSeIMTHaTuwv9ESrE7tC4llv8YqvwAdhrnCDNrgSFZEowbkS7Y6HEZ9y0HpFHegIFNeuU/jbaj2HAu4WJy1JmzW0cw1s8gv6vxNcheP1yAecSO5MMbStkfvnm/PLA7lN1v1fw9JX/8hi1O/SHP+KcVmcldh/4gASG4VUed3WqoLpECzxCdxnD7Aqg8nrBr2MSwEzNcb+krR+gNr0tvNjcN/6mjdztAGQgtdEEAhex9bRBvP5luTiYI2ZYbWBOnlBnztniZkAVL4Ef5v3xIyVAy5oEbx0SBIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737470055; c=relaxed/relaxed;
	bh=ucToi05wmq7fyixVv3OV3D9SGCWtVHRD1f79guZM8IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfpByfD0oiUVNY61tSFhT1sdd9qmf26QaGCAYPSN7yBisc4eCeJ7eOQxJ1OLujgA/t+cCZhngqwYM3i2ZkzyZnlis8WBRB11E+h1B7aK5Tpqkp+aus1APZPgrdOldYNBd1NpET2lzVzuwFbNHmQoiPo6CDbq8y07pbReyV8s3VTB6zW7NPxy1F5DtuXwUU1tMGOX8brafUHy0x6VUuKucFkZ8lI1HGUrXFt4x+m8wRrvvBVqZAeLZXjV00twglgzCfhB1uJAY/MD/Kxq1il7jcQ8SbAzFV4GJhtf10yB14SSC0FUaB9bJpdAn4UV2f/caYouqVqhgPmIqjwULRpHWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yGnAokEJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yGnAokEJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcqTc59QJz301Y
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2025 01:34:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737470047; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ucToi05wmq7fyixVv3OV3D9SGCWtVHRD1f79guZM8IE=;
	b=yGnAokEJWmjYZa6FfSY4cabIrPzbW+bhEacpW7a4LNI1XXqvTLz71RcaPuPz4BJzdfT5D9I6nsm78c/rcrY8t3ZQtPJRsyGLJ09fNfFZo1WR0+KvuN3qW5QN1y4jtD52S/b0FV0xZtAFOfccgCNmTRWAehE2vBPZPH0uXkJewf4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WO5jA7W_1737470041 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 22:34:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix inefficient fragment deduplication
Date: Tue, 21 Jan 2025 22:34:00 +0800
Message-ID: <20250121143400.1857269-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Neal Gompa <ngompa13@gmail.com>, Jonathan Lebon <jonathan@jlebon.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, long fragment comparisons could cause suboptimal results,
leading to final image sizes still larger than expected:
 _________________________________________________________________________
|______ Testset _____|        Vanilla          |          After           | Command Line
|  CoreOS [1]        |   802107392 (765 MiB)   |   687501312 (656 MiB)    | -zlzma,6 -Eall-fragments,fragdedupe=inode -C131072
|____________________|__ 771715072 (736 MiB) __|__ 658485248 (628 MiB)  __| -zlzma,6 -Eall-fragments,fragdedupe=inode -C1048576
|  Fedora KIWI [2]   |_ 2584076288 (2465 MiB) _|_ 2550837248 (2433 MiB) __| -zlzma,6 -Eall-fragments,fragdedupe=inode -C1048576
|____________________|_ 2843598848 (2712 MiB) _|_ 2810359808 (2681 MiB) __| (Fedora-KDE-Desktop-Live-Rawhide.0.x86_64.iso)

Almost all images that use `-Eall-fragments` could benefit from this.

[1] https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/41.20241215.3.0/x86_64/fedora-coreos-41.20241215.3.0-live.x86_64.iso
[2] https://pagure.io/fedora-kiwi-descriptions.git
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c  |   3 +-
 lib/fragments.c | 123 ++++++++++++++++++++++--------------------------
 2 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index eb3190d..5c9c051 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1534,7 +1534,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 
 		if (cfg.c_fragdedupe == FRAGDEDUPE_INODE &&
 		    inode->fragment_size < inode->i_size) {
-			erofs_dbg("Discard the sub-inode tail fragment @ nid %llu", inode->nid);
+			erofs_dbg("Discard the sub-inode tail fragment of %s",
+				  inode->i_srcpath);
 			inode->fragment_size = 0;
 		}
 	}
diff --git a/lib/fragments.c b/lib/fragments.c
index f662cbc..32ac6f5 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -33,6 +33,7 @@ struct erofs_fragment_dedupe_item {
 	u8			data[];
 };
 
+#define EROFS_FRAGMENT_INMEM_SZ_MAX	EROFS_CONFIG_COMPR_MAX_SZ
 #define EROFS_TOF_HASHLEN		16
 
 #define FRAGMENT_HASHSIZE		65536
@@ -62,96 +63,82 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	struct erofs_fragment_dedupe_item *cur, *di = NULL;
 	struct list_head *head = &epi->hash[FRAGMENT_HASH(crc)];
+	unsigned int s1, e1;
+	erofs_off_t deduped;
 	u8 *data;
-	unsigned int length, e2, deduped;
-	erofs_off_t pos;
 	int ret;
 
 	if (list_empty(head))
 		return 0;
 
-	/* XXX: no need to read so much for smaller? */
-	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
-		length = inode->i_size;
-	else
-		length = EROFS_CONFIG_COMPR_MAX_SZ;
-
-	data = malloc(length);
+	s1 = min_t(u64, EROFS_FRAGMENT_INMEM_SZ_MAX, inode->i_size);
+	data = malloc(s1);
 	if (!data)
 		return -ENOMEM;
 
-	if (erofs_lseek64(fd, inode->i_size - length, SEEK_SET) < 0) {
-		ret = -errno;
-		goto out;
-	}
-
-	ret = read(fd, data, length);
-	if (ret != length) {
-		ret = -errno;
-		goto out;
+	ret = pread(fd, data, s1, inode->i_size - s1);
+	if (ret != s1) {
+		free(data);
+		return -errno;
 	}
-
-	DBG_BUGON(length <= EROFS_TOF_HASHLEN);
-	e2 = length - EROFS_TOF_HASHLEN;
+	e1 = s1 - EROFS_TOF_HASHLEN;
 	deduped = 0;
-
 	list_for_each_entry(cur, head, list) {
-		unsigned int e1, mn, i = 0;
+		unsigned int e2, mn;
+		erofs_off_t i, pos;
 
 		DBG_BUGON(cur->length <= EROFS_TOF_HASHLEN);
-		e1 = cur->length - EROFS_TOF_HASHLEN;
+		e2 = cur->length - EROFS_TOF_HASHLEN;
 
-		if (memcmp(cur->data + e1, data + e2, EROFS_TOF_HASHLEN))
+		if (memcmp(data + e1, cur->data + e2, EROFS_TOF_HASHLEN))
 			continue;
 
+		i = 0;
 		mn = min(e1, e2);
-		while (i < mn && cur->data[e1 - i - 1] == data[e2 - i - 1])
+		while (i < mn && cur->data[e2 - i - 1] == data[e1 - i - 1])
 			++i;
 
-		if (!di || i + EROFS_TOF_HASHLEN > deduped) {
-			deduped = i + EROFS_TOF_HASHLEN;
-			di = cur;
+		i += EROFS_TOF_HASHLEN;
+		if (i >= s1) {		/* full short match */
+			DBG_BUGON(i > s1);
+			pos = cur->pos + cur->length - s1;
+			while (i < inode->i_size && pos) {
+				char buf[2][16384];
+				unsigned int sz;
+
+				sz = min_t(u64, pos, sizeof(buf[0]));
+				sz = min_t(u64, sz, inode->i_size - i);
+				if (pread(fileno(epi->file), buf[0], sz,
+					  pos - sz) != sz)
+					break;
+				if (pread(fd, buf[1], sz,
+					  inode->i_size - i - sz) != sz)
+					break;
 
-			/* full match */
-			if (i == e2)
-				break;
+				if (memcmp(buf[0], buf[1], sz))
+					break;
+				pos -= sz;
+				i += sz;
+			}
 		}
-	}
-	if (!di)
-		goto out;
-
-	DBG_BUGON(di->length < deduped);
-	pos = di->pos + di->length - deduped;
-	/* let's read more to dedupe as long as we can */
-	if (deduped == di->length) {
-		fflush(epi->file);
-
-		while(deduped < inode->i_size && pos) {
-			char buf[2][16384];
-			unsigned int sz = min_t(unsigned int, pos,
-						sizeof(buf[0]));
-
-			if (pread(fileno(epi->file), buf[0], sz,
-				  pos - sz) != sz)
-				break;
-			if (pread(fd, buf[1], sz,
-				  inode->i_size - deduped - sz) != sz)
-				break;
 
-			if (memcmp(buf[0], buf[1], sz))
-				break;
-			pos -= sz;
-			deduped += sz;
-		}
+		if (i <= deduped)
+			continue;
+		di = cur;
+		deduped = i;
+		if (deduped == inode->i_size)
+			break;
 	}
-	inode->fragment_size = deduped;
-	inode->fragmentoff = pos;
 
-	erofs_dbg("Dedupe %llu tail data at %llu", inode->fragment_size | 0ULL,
-		  inode->fragmentoff | 0ULL);
-out:
 	free(data);
-	return ret;
+	if (deduped) {
+		DBG_BUGON(!di);
+		inode->fragment_size = deduped;
+		inode->fragmentoff = di->pos + di->length - deduped;
+		erofs_dbg("Dedupe %llu tail data at %llu",
+			  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
+	}
+	return 0;
 }
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
@@ -186,10 +173,10 @@ static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
 
 	if (len <= EROFS_TOF_HASHLEN)
 		return 0;
-	if (len > EROFS_CONFIG_COMPR_MAX_SZ) {
-		data += len - EROFS_CONFIG_COMPR_MAX_SZ;
-		pos += len - EROFS_CONFIG_COMPR_MAX_SZ;
-		len = EROFS_CONFIG_COMPR_MAX_SZ;
+	if (len > EROFS_FRAGMENT_INMEM_SZ_MAX) {
+		data += len - EROFS_FRAGMENT_INMEM_SZ_MAX;
+		pos += len - EROFS_FRAGMENT_INMEM_SZ_MAX;
+		len = EROFS_FRAGMENT_INMEM_SZ_MAX;
 	}
 	di = malloc(sizeof(*di) + len);
 	if (!di)
-- 
2.43.5

