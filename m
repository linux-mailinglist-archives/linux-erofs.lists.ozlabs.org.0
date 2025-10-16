Return-Path: <linux-erofs+bounces-1191-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E3BE1504
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7g4T8vz306d;
	Thu, 16 Oct 2025 13:48:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582911;
	cv=none; b=Kv7v2NL2vhAQKF8numluxxFJmbVWQNAA5uI/wRbsFV3+00ZpISEtVu+lto0pWnaoeaFq9KW31WXcZYBXL7zPAyFVpvdUGXZ9pfMuJfkxK2AWt8XUL1LhA475s0YxzTwHJEeHu9Wzb8swLQpdlV9RfLFiP23Aodk31vEPS/3yw5YbjsYjOGKZRNc+VCkX961O187gYbRi4FHex7AlSISsnroTFe3cs9fs4orzyQwL2A8fLrTpBwEWoc953tzzBsqd5gM+Ii8ZJwxOe2Lk3r7WuwFFWx/3m6FfoH4SyStBX0dNnQxPN4kB1auqB25CWFPXhgwTTA/qJAineVLt5W6pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582911; c=relaxed/relaxed;
	bh=gZIG05n5QXaTZ/2KSv40ccCRoSyvyQhhSnw4GSIhD8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze64+hUrEKDuBzCxrAmCLz7n0wb2G80nOdUGV7G4dbfVsDErHi6R8P8YGz/5BEQt+6CrI5lQbeiQJ7M8WbNNMEIFBoL1fW9kpge1WCa958zcIjgH1OK4/WtnHgihcDycz7L+CRpMCvCf2tRNhP+Moi5YFztmkADO5Q9Ag5qk1enN6zw35ikvQZ2fnTLS6uKbZrU2nBAA+njicUQlgrFDWNrZ++Gaf+zIo5urv5VjYyRcUFkFIIeWpM0y8HzfSgxsMCAIRKCu3ib+mfX7XPdGJsNfrCH5cPJEJDjySnyciz6Hdn+QlAIsAa4S6nPssJoQx+MMstg5FDKB4pYYH2eXRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZGJT9ter; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZGJT9ter;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7f2S65z2yqq
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582906; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gZIG05n5QXaTZ/2KSv40ccCRoSyvyQhhSnw4GSIhD8c=;
	b=ZGJT9terY1aase6MCro+LBt0RZt1jcRN9wNxtZjm75S/2VuSNmC3IfhNUbLeXXImRR5WzkLcPnBZ0Q/bF8BknRSUTNSum061Xz0S3MG0ZRpKmwmyxNJY3PpfK1TPkva3sVug6YQDGZcjq/+81ZrUoWY2YA3cAH6JzlLeALkvr/Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVkb_1760582904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 7/7] erofs-utils: lib: introduce directory writer
Date: Thu, 16 Oct 2025 10:48:15 +0800
Message-ID: <20251016024815.2750927-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

Directories are now written to disk using virtual files too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 153 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 63 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 264c4ae..7587248 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -377,16 +377,6 @@ static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 	memset(buf + q, 0, size - q);
 }
 
-static int write_dirblock(struct erofs_sb_info *sbi,
-			  unsigned int q, struct erofs_dentry *head,
-			  struct erofs_dentry *end, erofs_blk_t blkaddr)
-{
-	char buf[EROFS_MAX_BLOCK_SIZE];
-
-	fill_dirblock(buf, erofs_blksiz(sbi), q, head, end);
-	return erofs_blk_write(sbi, buf, blkaddr, 1);
-}
-
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *const bh = inode->bh;
@@ -515,64 +505,85 @@ static int erofs_rebuild_inode_fix_pnid(struct erofs_inode *parent,
 	return -EFSCORRUPTED;
 }
 
-static int erofs_write_dir_file(struct erofs_inode *dir)
-{
-	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
-						     struct erofs_dentry,
-						     d_child);
-	struct erofs_sb_info *sbi = dir->sbi;
-	struct erofs_dentry *d;
-	int ret;
-	unsigned int q, used, blkno;
-
-	q = used = blkno = 0;
-
-	/* allocate dir main data */
-	ret = erofs_allocate_inode_bh_data(dir, erofs_blknr(sbi, dir->i_size));
-	if (ret)
-		return ret;
-
-	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		unsigned int len = d->namelen + sizeof(struct erofs_dirent);
-
-		/* XXX: a bit hacky, but to avoid another traversal */
-		if (d->flags & EROFS_DENTRY_FLAG_FIXUP_PNID) {
-			ret = erofs_rebuild_inode_fix_pnid(dir, d->nid);
-			if (ret)
-				return ret;
-		}
-
-		erofs_d_invalidate(d);
-		if (used + len > erofs_blksiz(sbi)) {
-			ret = write_dirblock(sbi, q, head, d,
-					     dir->u.i_blkaddr + blkno);
-			if (ret)
-				return ret;
+struct erofs_dirwriter_vf {
+	struct erofs_vfile vf;
+	struct erofs_inode *dir;
+	struct list_head *head;
+	erofs_off_t offset;
+	char dirdata[];
+};
 
-			head = d;
+static ssize_t erofs_dirwriter_vfread(struct erofs_vfile *vf,
+				      void *buf, size_t len)
+{
+	struct erofs_dirwriter_vf *dwv = (struct erofs_dirwriter_vf *)vf;
+	struct erofs_inode *dir = dwv->dir;
+	unsigned int bsz = erofs_blksiz(dir->sbi);
+	size_t processed = 0;
+
+	if (len > dir->i_size - dwv->offset)
+		len = dir->i_size - dwv->offset;
+	while (processed < len) {
+		unsigned int off, dblen, count;
+
+		off = dwv->offset & (bsz - 1);
+		dblen = min_t(u64, dir->i_size - dwv->offset + off, bsz);
+		/* generate a directory block to `dwv->dirdata` */
+		if (!off) {
+			struct erofs_dentry *head, *d;
+			unsigned int q, used, len;
+			int err;
+
+			d = head = list_entry(dwv->head,
+					      struct erofs_dentry, d_child);
 			q = used = 0;
-			++blkno;
+			do {
+				/* XXX: a bit hacky, but avoids another traversal */
+				if (d->flags & EROFS_DENTRY_FLAG_FIXUP_PNID) {
+					err = erofs_rebuild_inode_fix_pnid(dir, d->nid);
+					if (err)
+						return err;
+				}
+				len = d->namelen + sizeof(struct erofs_dirent);
+				erofs_d_invalidate(d);
+				if ((used += len) > bsz)
+					break;
+				d = list_next_entry(d, d_child);
+				q += sizeof(struct erofs_dirent);
+			} while (&d->d_child != &dir->i_subdirs);
+			fill_dirblock(dwv->dirdata, dblen, q, head, d);
+			dwv->head = &d->d_child;
 		}
-		used += len;
-		q += sizeof(struct erofs_dirent);
+		count = min_t(size_t, dblen - off, len - processed);
+		memcpy(buf + processed, dwv->dirdata + off, count);
+		processed += count;
+		dwv->offset += count;
 	}
+	return processed;
+}
 
-	DBG_BUGON(used > erofs_blksiz(sbi));
-	if (used == erofs_blksiz(sbi)) {
-		DBG_BUGON(dir->i_size % erofs_blksiz(sbi));
-		DBG_BUGON(dir->idata_size);
-		return write_dirblock(sbi, q, head, d, dir->u.i_blkaddr + blkno);
-	}
-	DBG_BUGON(used != dir->i_size % erofs_blksiz(sbi));
-	if (used) {
-		/* fill tail-end dir block */
-		dir->idata = malloc(used);
-		if (!dir->idata)
-			return -ENOMEM;
-		DBG_BUGON(used != dir->idata_size);
-		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
-	}
-	return 0;
+void erofs_dirwriter_vfclose(struct erofs_vfile *vf)
+{
+	free((void *)vf);
+}
+
+static struct erofs_vfops erofs_dirwriter_vfops = {
+	.read = erofs_dirwriter_vfread,
+	.close = erofs_dirwriter_vfclose,
+};
+
+static struct erofs_vfile *erofs_dirwriter_open(struct erofs_inode *dir)
+{
+	struct erofs_dirwriter_vf *dwv;
+
+	dwv = malloc(sizeof(*dwv) + erofs_blksiz(dir->sbi));
+	if (!dwv)
+		return ERR_PTR(-ENOMEM);
+	dwv->vf.ops = &erofs_dirwriter_vfops;
+	dwv->dir = dir;
+	dwv->head = dir->i_subdirs.next;
+	dwv->offset = 0;
+	return (struct erofs_vfile *)dwv;
 }
 
 int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
@@ -686,6 +697,22 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
 }
 
+static int erofs_write_dir_file(struct erofs_inode *dir)
+{
+	unsigned int bsz = erofs_blksiz(dir->sbi);
+	struct erofs_vfile *vf;
+	int err;
+
+	DBG_BUGON(dir->idata_size != (dir->i_size & (bsz - 1)));
+	vf = erofs_dirwriter_open(dir);
+	if (IS_ERR(vf))
+		return PTR_ERR(vf);
+
+	err = erofs_write_unencoded_data(dir, vf, 0, true);
+	erofs_io_close(vf);
+	return err;
+}
+
 int erofs_iflush(struct erofs_inode *inode)
 {
 	u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
-- 
2.43.5


