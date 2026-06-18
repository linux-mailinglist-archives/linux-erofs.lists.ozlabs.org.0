Return-Path: <linux-erofs+bounces-3665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 621OF6yXM2q1DwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:01:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE369DF61
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:00:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=4Ab2podc;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3665-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3665-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggs7l1tcYz2yRF;
	Thu, 18 Jun 2026 17:00:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781766051;
	cv=none; b=jPA1iD3M+iCPtOe1OOAJm3PNeShqdojdc5E5OqpzAaugZhd/jhphmJeyIoNFxvw6VEz7AeHaSbiGEHc3C6uxc4KONwphn0P/AXhl6GFjvlsQTm/9onER0n4wdnGffPMsV4MH+c58kHW227f0ewFlC4BIB6Gwwp5KZ24ooC440Z5jJ18QjuZ6BK70RrbbiGiSTPGFbPt4i8j2K/Gc5ag+wuMW2v9/VvFg+J9aCpbAyaB1dM1rK8kHkqZOg1qF06ENu1bSgluJwa3rp5iA9ooPvjDaLs6kBbMq5dpZZMovLWlk7Y7MQKbF1MIcy9gG7FhYOWmfOFm7qxbZUu2GLcj/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781766051; c=relaxed/relaxed;
	bh=Qso22bj0XK4NAsY+bnOHREWhwF3O+1FNHXuXwE/6NKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJTql2Vi5qP1tpMqFxuzSI9lFToaWc9qjsV4swIKnwhLAStDkyMhbg9+/6aDGUq2qV20xAUNkjY1N5Tv2RmuOluZcLeuJL0dLZ1ECpArJorlFjcMhj50W0uaRzRCCN0M7j+znY+aF1Zr7L+o/rf9B0f5ZOOSqPLxfM9Z9wNSXzLfbYTjGtoTFOtitU/aTwH6KiKgx5Cd1VUCpdExJfRBE1obyv/JejBm9JfeBILlkVUZcqqqNlTvDkNBSwO0JfrofIwT/896rJSo+4qwl7aOT4DAeH7rlQSgvlh+szWgLvLE6XGYlRJYkSC4DooEepK0BNkWcUtsRowYSUTVCcpGGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4Ab2podc; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggs7f3ryHz2yNn
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:00:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qso22bj0XK4NAsY+bnOHREWhwF3O+1FNHXuXwE/6NKE=;
	b=4Ab2podcRPLZHoCLQNP+GQ+r5dybv7oCJ9JBExIB/vJhbr33q2xbL7wNSSNFk8kF+ZtZaCojp
	ArSibs1E+Vk6gNzrDoW2xKSzLCkpPBU4hqEoEEx8+LHKkTRbA9URFWr0QcHIiBZE1VpQBqd/w8Y
	H3jlHpK1Rhz/mafCiGkzZL4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4ggryB00XnzpTKs;
	Thu, 18 Jun 2026 14:52:33 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id AC26D40363;
	Thu, 18 Jun 2026 15:00:38 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Jun
 2026 15:00:38 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <yekelu1@huawei.com>, <jingrui@huawei.com>, <zhukeqian1@huawei.com>,
	<zhaoyifan28@huawei.com>
Subject: [RFC PATCH 2/3] erofs-utils: refactor inode data source vfiles
Date: Thu, 18 Jun 2026 14:59:21 +0800
Message-ID: <20260618065922.1004653-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
References: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3665-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69AE369DF61

Collect inode data source state into struct erofs_inode_datasource
instead of carrying separate fields on the inode. Add a vfile wrapper
for local path, diskbuf, and rebuild blob sources.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 include/erofs/blobchunk.h |   4 +-
 include/erofs/internal.h  |  32 ++--
 lib/blobchunk.c           |  24 +--
 lib/compress.c            |   7 +
 lib/inode.c               | 330 +++++++++++++++++++++++++++-----------
 lib/liberofs_compress.h   |   2 +
 lib/rebuild.c             |  20 +--
 lib/remotes/s3.c          |  25 +--
 lib/tar.c                 |  23 +--
 9 files changed, 323 insertions(+), 144 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 1761fdd..e2e306f 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -19,8 +19,8 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 void erofs_inode_fixup_chunkformat(struct erofs_inode *inode);
 int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
 			      erofs_off_t off);
-int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
-				  erofs_off_t startoff);
+int erofs_blob_write_chunked_file(struct erofs_inode *inode,
+				  struct erofs_vfile *vf);
 int erofs_write_zero_inode(struct erofs_inode *inode);
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2cc9cc8..cba1348 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -204,11 +204,24 @@ EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
 
 struct erofs_diskbuf;
 
-#define EROFS_INODE_DATA_SOURCE_NONE		0
-#define EROFS_INODE_DATA_SOURCE_LOCALPATH	1
-#define EROFS_INODE_DATA_SOURCE_DISKBUF		2
-#define EROFS_INODE_DATA_SOURCE_RESVSP		3
-#define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB	4
+enum erofs_inode_data_source_type {
+	EROFS_INODE_DATA_SOURCE_NONE,
+	EROFS_INODE_DATA_SOURCE_LOCALPATH,
+	EROFS_INODE_DATA_SOURCE_DISKBUF,
+	EROFS_INODE_DATA_SOURCE_RESVSP,
+	EROFS_INODE_DATA_SOURCE_REBUILD_BLOB,
+};
+
+struct erofs_inode_datasource {
+	unsigned char type;
+	union {
+		struct erofs_diskbuf *diskbuf;
+		struct {
+			char *path;
+			erofs_off_t dataoff;
+		} rebuild_blob;
+	};
+};
 
 enum erofs_idata_type {
 	EROFS_IDATA_TYPE_RAW,
@@ -256,17 +269,12 @@ struct erofs_inode {
 	} u;
 
 	char *i_srcpath;
-	union {
-		char *i_link;
-		struct erofs_diskbuf *i_diskbuf;
-	};
-	char *rebuild_blobpath;
-	erofs_off_t rebuild_src_dataoff;
+	char *i_link;
+	struct erofs_inode_datasource datasource;
 	unsigned char datalayout;
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
-	char datasource;
 	bool in_metabox;
 	char idata_type;
 	bool lazy_tailblock;
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e39bf68..8015c05 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -300,8 +300,8 @@ static bool erofs_blob_can_merge(struct erofs_sb_info *sbi,
 
 	return false;
 }
-int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
-				  erofs_off_t startoff)
+int erofs_blob_write_chunked_file(struct erofs_inode *inode,
+				  struct erofs_vfile *vf)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int chunkbits = cfg.c_chunkbits;
@@ -314,7 +314,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	int ret;
 
 	/* if the file is fully sparsed, use one big chunk instead */
-	if (lseek(fd, startoff, SEEK_DATA) < 0 && errno == ENXIO) {
+	if (erofs_io_lseek(vf, 0, SEEK_DATA) == -ENXIO) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
 		if (chunkbits < sbi->blkszbits)
 			chunkbits = sbi->blkszbits;
@@ -366,20 +366,18 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	}
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
-		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
+		off_t offset = erofs_io_lseek(vf, pos, SEEK_DATA);
 
 		if (offset < 0) {
-			if (errno != ENXIO)
+			if (offset != -ENXIO)
 				offset = pos;
 			else
 				offset = ((pos >> chunkbits) + 1) << chunkbits;
 		} else {
-			offset -= startoff;
-
 			if (offset != (offset & ~(chunksize - 1))) {
 				offset &= ~(chunksize - 1);
-				if (lseek(fd, offset + startoff, SEEK_SET) !=
-					  startoff + offset) {
+				if (erofs_io_lseek(vf, offset, SEEK_SET) !=
+						offset) {
 					ret = -EIO;
 					goto err;
 				}
@@ -404,7 +402,13 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		}
 
 		len = min_t(u64, inode->i_size - pos, chunksize);
-		ret = read(fd, chunkdata, len);
+		ret = erofs_io_lseek(vf, pos, SEEK_SET);
+		if (ret != pos) {
+			ret = ret < 0 ? ret : -EIO;
+			goto err;
+		}
+
+		ret = erofs_io_read(vf, chunkdata, len);
 		if (ret < len) {
 			ret = -EIO;
 			goto err;
diff --git a/lib/compress.c b/lib/compress.c
index e7c60b2..633b69a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1914,6 +1914,13 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	return ictx;
 }
 
+void erofs_bind_compressed_file_with_vfile(struct z_erofs_compress_ictx *ictx,
+					   struct erofs_vfile *vf)
+{
+	ictx->vf = vf;
+	ictx->fpos = 0;
+}
+
 void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
 					int fd, u64 fpos)
 {
diff --git a/lib/inode.c b/lib/inode.c
index c225faa..328215b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -76,6 +76,13 @@ static const umode_t erofs_dtype_by_umode[EROFS_FT_MAX] = {
 	[EROFS_FT_SYMLINK]	= S_IFLNK
 };
 
+struct erofs_inode_datasource_vfile {
+	struct erofs_vfile vf;
+	struct erofs_inode *inode;
+	u64 base;
+	u64 pos;
+};
+
 umode_t erofs_ftype_to_mode(unsigned int ftype, unsigned int perm)
 {
 	if (ftype >= EROFS_FT_MAX)
@@ -138,6 +145,172 @@ struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 	return ret;
 }
 
+static void erofs_inode_free_datasource(struct erofs_inode *inode)
+{
+	switch (inode->datasource.type) {
+	case EROFS_INODE_DATA_SOURCE_DISKBUF:
+		erofs_diskbuf_close(inode->datasource.diskbuf);
+		free(inode->datasource.diskbuf);
+		inode->datasource.diskbuf = NULL;
+		break;
+	case EROFS_INODE_DATA_SOURCE_REBUILD_BLOB:
+		free(inode->datasource.rebuild_blob.path);
+		inode->datasource.rebuild_blob.path = NULL;
+		break;
+	default:
+		return;
+	}
+	inode->datasource.type = EROFS_INODE_DATA_SOURCE_NONE;
+}
+
+static ssize_t erofs_inode_vfpread(struct erofs_vfile *vf, void *buf,
+				   size_t len, u64 offset)
+{
+	struct erofs_inode_datasource_vfile *dvf =
+		container_of(vf, struct erofs_inode_datasource_vfile, vf);
+
+	return erofs_io_pread(&(struct erofs_vfile){ .fd = vf->fd },
+			      buf, len, dvf->base + offset);
+}
+
+static ssize_t erofs_inode_vfread(struct erofs_vfile *vf, void *buf,
+				  size_t len)
+{
+	struct erofs_inode_datasource_vfile *dvf =
+		container_of(vf, struct erofs_inode_datasource_vfile, vf);
+	ssize_t ret;
+
+	ret = erofs_inode_vfpread(vf, buf, len, dvf->pos);
+	if (ret > 0)
+		dvf->pos += ret;
+	return ret;
+}
+
+static off_t erofs_inode_vflseek(struct erofs_vfile *vf, u64 offset,
+				 int whence)
+{
+	struct erofs_inode_datasource_vfile *dvf =
+		container_of(vf, struct erofs_inode_datasource_vfile, vf);
+	u64 pos;
+	off_t ret;
+
+	switch (whence) {
+	case SEEK_SET:
+		if (offset > dvf->inode->i_size)
+			return -EINVAL;
+		pos = offset;
+		break;
+	case SEEK_CUR:
+		if (dvf->pos > dvf->inode->i_size ||
+		    offset > dvf->inode->i_size - dvf->pos)
+			return -EINVAL;
+		pos = dvf->pos + offset;
+		break;
+	case SEEK_END:
+		if (offset)
+			return -EINVAL;
+		pos = dvf->inode->i_size;
+		break;
+	case SEEK_DATA:
+	case SEEK_HOLE:
+		if (offset > dvf->inode->i_size)
+			return -ENXIO;
+		if (offset == dvf->inode->i_size) {
+			if (whence == SEEK_DATA)
+				return -ENXIO;
+			dvf->pos = offset;
+			return dvf->pos;
+		}
+
+		ret = erofs_io_lseek(&(struct erofs_vfile){ .fd = vf->fd },
+				     dvf->base + offset, whence);
+		if (ret < 0)
+			return ret;
+		if (ret < dvf->base)
+			return -EIO;
+		if (whence == SEEK_DATA &&
+		    ret >= dvf->base + dvf->inode->i_size)
+			return -ENXIO;
+		if (ret > dvf->base + dvf->inode->i_size)
+			ret = dvf->base + dvf->inode->i_size;
+		dvf->pos = ret - dvf->base;
+		return dvf->pos;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	dvf->pos = pos;
+	return dvf->pos;
+}
+
+static void erofs_inode_vfclose(struct erofs_vfile *vf)
+{
+	struct erofs_inode_datasource_vfile *dvf =
+		container_of(vf, struct erofs_inode_datasource_vfile, vf);
+	struct erofs_inode *inode = dvf->inode;
+
+	if (vf->fd >= 0 &&
+	    (inode->datasource.type == EROFS_INODE_DATA_SOURCE_LOCALPATH ||
+	     inode->datasource.type == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB))
+		close(vf->fd);
+	vf->fd = -1;
+	erofs_inode_free_datasource(inode);
+	free(dvf);
+}
+
+static struct erofs_vfops erofs_inode_vfops = {
+	.pread = erofs_inode_vfpread,
+	.read = erofs_inode_vfread,
+	.lseek = erofs_inode_vflseek,
+	.close = erofs_inode_vfclose,
+};
+
+static struct erofs_inode_datasource_vfile *erofs_inode_open_data_vfile(
+		struct erofs_inode *inode)
+{
+	struct erofs_inode_datasource_vfile *dvf;
+	int ret;
+
+	if (inode->datasource.type != EROFS_INODE_DATA_SOURCE_LOCALPATH &&
+	    inode->datasource.type != EROFS_INODE_DATA_SOURCE_DISKBUF &&
+	    inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB)
+		return NULL;
+
+	dvf = calloc(1, sizeof(*dvf));
+	if (!dvf)
+		return ERR_PTR(-ENOMEM);
+
+	dvf->vf = (struct erofs_vfile) {
+		.ops = &erofs_inode_vfops,
+		.fd = -1,
+	};
+	dvf->inode = inode;
+
+	switch (inode->datasource.type) {
+	case EROFS_INODE_DATA_SOURCE_DISKBUF:
+		dvf->vf.fd = erofs_diskbuf_getfd(inode->datasource.diskbuf,
+						 &dvf->base);
+		break;
+	case EROFS_INODE_DATA_SOURCE_LOCALPATH:
+		dvf->vf.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+		break;
+	case EROFS_INODE_DATA_SOURCE_REBUILD_BLOB:
+		dvf->vf.fd = open(inode->datasource.rebuild_blob.path,
+				  O_RDONLY | O_BINARY);
+		dvf->base = inode->datasource.rebuild_blob.dataoff;
+		break;
+	default:
+		break;
+	}
+	if (dvf->vf.fd < 0) {
+		ret = inode->datasource.type == EROFS_INODE_DATA_SOURCE_DISKBUF ?
+		      dvf->vf.fd : -errno;
+		free(dvf);
+		return ERR_PTR(ret);
+	}
+	return dvf;
+}
+
 unsigned int erofs_iput(struct erofs_inode *inode)
 {
 	struct erofs_dentry *d, *t;
@@ -155,14 +328,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	if (!erofs_is_special_identifier(inode->i_srcpath))
 		free(inode->i_srcpath);
 
-	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
-		erofs_diskbuf_close(inode->i_diskbuf);
-		free(inode->i_diskbuf);
-	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
-		free(inode->rebuild_blobpath);
-	} else {
-		free(inode->i_link);
-	}
+	erofs_inode_free_datasource(inode);
+	free(inode->i_link);
 
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		free(inode->chunkindexes);
@@ -700,30 +867,32 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 	return 0;
 }
 
-int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
+static int erofs_write_unencoded_file(struct erofs_inode *inode,
+				      struct erofs_inode_datasource_vfile *src)
 {
-	struct erofs_vfile vf = { .fd = fd };
+	int ret;
+
+	ret = erofs_io_lseek(&src->vf, 0, SEEK_SET);
+	if (ret)
+		return ret;
 
 	if (cfg.c_chunkbits &&
-	    inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
+	    inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
 		inode->u.chunkbits = cfg.c_chunkbits;
 		/* chunk indexes when explicitly specified */
 		inode->u.chunkformat = 0;
 		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-		return erofs_blob_write_chunked_file(inode, fd, fpos);
+		return erofs_blob_write_chunked_file(inode, &src->vf);
 	}
 
-	if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
-		if (erofs_io_lseek(&vf, fpos, SEEK_SET) != (off_t)fpos)
-			return -EIO;
-		return erofs_write_unencoded_data(inode, &vf, fpos, true, false);
-	}
-
-	inode->datalayout = EROFS_INODE_FLAT_INLINE;
+	if (inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB)
+		inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	/* fallback to all data uncompressed */
-	return erofs_write_unencoded_data(inode, &vf, fpos,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF, false);
+	return erofs_write_unencoded_data(inode, &src->vf, 0,
+			inode->datasource.type == EROFS_INODE_DATA_SOURCE_DISKBUF ||
+			inode->datasource.type == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB,
+			false);
 }
 
 static int erofs_write_dir_file(const struct erofs_importer *im,
@@ -1428,7 +1597,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 		erofs_iput(inode);
 		return ERR_PTR(ret);
 	}
-	inode->datasource = EROFS_INODE_DATA_SOURCE_LOCALPATH;
+	inode->datasource.type = EROFS_INODE_DATA_SOURCE_LOCALPATH;
 	return inode;
 }
 
@@ -1489,9 +1658,8 @@ static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
 
 struct erofs_mkfs_job_ndir_ctx {
 	struct erofs_inode *inode;
+	struct erofs_inode_datasource_vfile *src;
 	void *ictx;
-	int fd;
-	u64 fpos;
 };
 
 static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
@@ -1499,39 +1667,20 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 	struct erofs_inode *inode = ctx->inode;
 	int ret;
 
-	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF &&
-	    lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
-		ret = -errno;
-		goto out;
-	}
-
 	if (ctx->ictx) {
+		ret = erofs_io_lseek(&ctx->src->vf, 0, SEEK_SET);
+		if (ret)
+			goto out;
 		ret = erofs_write_compressed_file(ctx->ictx);
 		if (ret != -ENOSPC)
 			goto out;
-		if (lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
-			ret = -errno;
-			goto out;
-		}
 	}
 	/* fallback to all data uncompressed */
-	ret = erofs_write_unencoded_file(inode, ctx->fd, ctx->fpos);
+	ret = erofs_write_unencoded_file(inode, ctx->src);
 out:
-	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
-		erofs_diskbuf_close(inode->i_diskbuf);
-		free(inode->i_diskbuf);
-		inode->i_diskbuf = NULL;
-		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
-	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
-		free(inode->rebuild_blobpath);
-		inode->rebuild_blobpath = NULL;
-		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
-		DBG_BUGON(ctx->fd < 0);
-		close(ctx->fd);
-	} else {
-		DBG_BUGON(ctx->fd < 0);
-		close(ctx->fd);
-	}
+	DBG_BUGON(!ctx->src || ctx->src->vf.fd < 0);
+	erofs_io_close(&ctx->src->vf);
+	ctx->src = NULL;
 	return ret;
 }
 
@@ -1549,7 +1698,7 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 	ret = erofs_prepare_xattr_ibody(inode,
 					btctx->incremental && IS_ROOT(inode));
 	if (ret)
-		return ret;
+		goto out;
 
 	if (S_ISLNK(inode->i_mode)) {
 		char *symlink = inode->i_link;
@@ -1568,16 +1717,22 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 		free(symlink);
 		inode->i_link = NULL;
 	} else if (inode->i_size) {
-		if (inode->datasource == EROFS_INODE_DATA_SOURCE_RESVSP)
+		if (inode->datasource.type == EROFS_INODE_DATA_SOURCE_RESVSP)
 			ret = erofs_inode_reserve_data_blocks(inode);
-		else if (ctx->fd >= 0)
+		else if (ctx->src)
 			ret = erofs_mkfs_job_write_file(ctx);
 	}
 	if (ret)
-		return ret;
+		goto out;
 	erofs_prepare_inode_buffer(btctx->im, inode);
 	erofs_write_tail_end(btctx->im, inode);
 	return 0;
+out:
+	if (ctx->src) {
+		erofs_io_close(&ctx->src->vf);
+		ctx->src = NULL;
+	}
+	return ret;
 }
 
 static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
@@ -1760,7 +1915,8 @@ static int erofs_mkfs_go(const struct erofs_mkfs_btctx *ctx,
 	struct erofs_mkfs_jobitem item;
 
 	item.type = type;
-	memcpy(&item.u, elem, size);
+	if (size)
+		memcpy(&item.u, elem, size);
 	return erofs_mkfs_jobfn(ctx, &item);
 }
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
@@ -1983,12 +2139,12 @@ static int erofs_prepare_dir_inode(const struct erofs_mkfs_btctx *ctx,
 	return 0;
 }
 
-static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
-				       erofs_off_t pos)
+static int erofs_set_inode_fingerprint(struct erofs_inode *inode,
+				       struct erofs_vfile *vf)
 {
 	u8 ishare_xattr_prefix_id = inode->sbi->ishare_xattr_prefix_id;
 	erofs_off_t remaining = inode->i_size;
-	struct erofs_vfile vf = { .fd = fd };
+	erofs_off_t pos = 0;
 	struct sha256_state md;
 	u8 out[32 + sizeof("sha256:") - 1];
 	int ret;
@@ -1999,7 +2155,7 @@ static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
 	do {
 		u8 buf[32768];
 
-		ret = erofs_io_pread(&vf, buf,
+		ret = erofs_io_pread(vf, buf,
 				     min_t(u64, remaining, sizeof(buf)), pos);
 		if (ret < 0)
 			return ret;
@@ -2018,51 +2174,45 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 					 struct erofs_inode *inode)
 {
 	struct erofs_importer *im = btctx->im;
-	struct erofs_mkfs_job_ndir_ctx ctx =
-		{ .inode = inode, .fd = -1 };
+	struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
 	int ret;
 
 	if (S_ISREG(inode->i_mode) && inode->i_size) {
-		switch (inode->datasource) {
-		case EROFS_INODE_DATA_SOURCE_DISKBUF:
-			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
-			if (ctx.fd < 0)
-				return ctx.fd;
-			break;
-		case EROFS_INODE_DATA_SOURCE_LOCALPATH:
-			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-			if (ctx.fd < 0)
-				return -errno;
-			break;
-		case EROFS_INODE_DATA_SOURCE_REBUILD_BLOB:
-			ctx.fd = open(inode->rebuild_blobpath, O_RDONLY | O_BINARY);
-			if (ctx.fd < 0)
-				return -errno;
-			ctx.fpos = inode->rebuild_src_dataoff;
-			break;
-		default:
+		ctx.src = erofs_inode_open_data_vfile(inode);
+		if (IS_ERR(ctx.src))
+			return PTR_ERR(ctx.src);
+		if (!ctx.src)
 			goto out;
-		}
 
-		ret = erofs_set_inode_fingerprint(inode, ctx.fd, ctx.fpos);
+		ret = erofs_set_inode_fingerprint(inode, &ctx.src->vf);
 		if (ret < 0)
-			return ret;
+			goto err_close;
 
-		if (inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
+		if (inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
 		    inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
-			if (IS_ERR(ctx.ictx))
-				return PTR_ERR(ctx.ictx);
-			erofs_bind_compressed_file_with_fd(ctx.ictx,
-							   ctx.fd, ctx.fpos);
+			if (IS_ERR(ctx.ictx)) {
+				ret = PTR_ERR(ctx.ictx);
+				goto err_close;
+			}
+			erofs_bind_compressed_file_with_vfile(ctx.ictx,
+							      &ctx.src->vf);
 			ret = erofs_begin_compressed_file(ctx.ictx);
 			if (ret)
-				return ret;
+				goto err_close;
 		}
 	}
 out:
-	return erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
+	ret = erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
+#ifdef EROFS_MT_ENABLED
+	if (ret && ctx.src)
+		erofs_io_close(&ctx.src->vf);
+#endif
+	return ret;
+err_close:
+	erofs_io_close(&ctx.src->vf);
+	return ret;
 }
 
 static int erofs_mkfs_handle_inode(const struct erofs_mkfs_btctx *ctx,
@@ -2402,7 +2552,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	ret = erofs_write_unencoded_data(inode,
 			&(struct erofs_vfile){ .fd = fd }, 0,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF,
+			inode->datasource.type == EROFS_INODE_DATA_SOURCE_DISKBUF,
 			false);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index da6eb1a..55a8943 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -17,6 +17,8 @@ struct z_erofs_compress_ictx;
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 void *erofs_prepare_compressed_file(struct erofs_importer *im,
 				    struct erofs_inode *inode);
+void erofs_bind_compressed_file_with_vfile(struct z_erofs_compress_ictx *ictx,
+					   struct erofs_vfile *vf);
 void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
 					int fd, u64 fpos);
 int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 51dfe18..abe3b74 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -233,24 +233,26 @@ static int erofs_rebuild_write_full_data(struct erofs_inode *inode)
 				return -EFSCORRUPTED;
 			return 0;
 		}
-		inode->rebuild_blobpath = strdup(src_sbi->devname);
-		if (!inode->rebuild_blobpath)
+		inode->datasource.rebuild_blob.path = strdup(src_sbi->devname);
+		if (!inode->datasource.rebuild_blob.path)
 			return -ENOMEM;
-		inode->rebuild_src_dataoff =
+		inode->datasource.rebuild_blob.dataoff =
 			erofs_pos(src_sbi, erofs_inode_dev_baddr(inode));
-		inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+		inode->datasource.type = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
 	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
 		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
 		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
 
 		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR) {
-			inode->rebuild_blobpath = strdup(src_sbi->devname);
-			if (!inode->rebuild_blobpath)
+			inode->datasource.rebuild_blob.path =
+				strdup(src_sbi->devname);
+			if (!inode->datasource.rebuild_blob.path)
 				return -ENOMEM;
-			inode->rebuild_src_dataoff =
+			inode->datasource.rebuild_blob.dataoff =
 				erofs_pos(src_sbi,
 					  erofs_inode_dev_baddr(inode));
-			inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+			inode->datasource.type =
+				EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
 		}
 
 		inode->idata_size = inline_size;
@@ -330,7 +332,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 		if (datamode == EROFS_REBUILD_DATA_BLOB_INDEX)
 			err = erofs_rebuild_write_blob_index(dst_sb, inode);
 		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
-			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+			inode->datasource.type = EROFS_INODE_DATA_SOURCE_RESVSP;
 		else if (datamode == EROFS_REBUILD_DATA_FULL)
 			err = erofs_rebuild_write_full_data(inode);
 		else
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 245efe5..fb8a1a5 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1063,33 +1063,36 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 			return ret;
 		resp.vf = &sbi->bdev;
 		resp.pos = erofs_pos(inode->sbi, inode->u.i_blkaddr);
-		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+		inode->datasource.type = EROFS_INODE_DATA_SOURCE_NONE;
 	} else {
-		if (!inode->i_diskbuf) {
-			inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
-			if (!inode->i_diskbuf)
+		if (!inode->datasource.diskbuf) {
+			inode->datasource.diskbuf =
+				calloc(1, sizeof(*inode->datasource.diskbuf));
+			if (!inode->datasource.diskbuf)
 				return -ENOSPC;
 		} else {
-			erofs_diskbuf_close(inode->i_diskbuf);
+			erofs_diskbuf_close(inode->datasource.diskbuf);
 		}
 
 		vf = (struct erofs_vfile) {.fd =
-			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &diskbuf_off)};
+			erofs_diskbuf_reserve(inode->datasource.diskbuf, 0,
+					       &diskbuf_off)};
 		if (vf.fd < 0)
 			return -EBADF;
 		resp.pos = diskbuf_off;
 		resp.vf = &vf;
-		inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+		inode->datasource.type = EROFS_INODE_DATA_SOURCE_DISKBUF;
 	}
 	resp.end = resp.pos + inode->i_size;
 
 	ret = s3erofs_request_perform(s3, &req, &resp);
 	if (resp.vf == &vf) {
-		erofs_diskbuf_commit(inode->i_diskbuf, resp.pos - diskbuf_off);
+		erofs_diskbuf_commit(inode->datasource.diskbuf,
+				     resp.pos - diskbuf_off);
 		if (ret) {
-			erofs_diskbuf_close(inode->i_diskbuf);
-			inode->i_diskbuf = NULL;
-			inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+			erofs_diskbuf_close(inode->datasource.diskbuf);
+			inode->datasource.diskbuf = NULL;
+			inode->datasource.type = EROFS_INODE_DATA_SOURCE_NONE;
 		}
 	}
 	if (ret)
diff --git a/lib/tar.c b/lib/tar.c
index 9e53af5..420275a 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -715,7 +715,7 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 			erofs_sha256_process(&md, buf, ret);
 	}
 	inode->idata_size = 0;
-	inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+	inode->datasource.type = EROFS_INODE_DATA_SOURCE_NONE;
 	if (ret < 0)
 		return ret;
 
@@ -738,15 +738,16 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 	int fd, nread;
 	u64 off, j;
 
-	if (!inode->i_diskbuf) {
-		inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
-		if (!inode->i_diskbuf)
+	if (!inode->datasource.diskbuf) {
+		inode->datasource.diskbuf =
+			calloc(1, sizeof(*inode->datasource.diskbuf));
+		if (!inode->datasource.diskbuf)
 			return -ENOSPC;
 	} else {
-		erofs_diskbuf_close(inode->i_diskbuf);
+		erofs_diskbuf_close(inode->datasource.diskbuf);
 	}
 
-	fd = erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off);
+	fd = erofs_diskbuf_reserve(inode->datasource.diskbuf, 0, &off);
 	if (fd < 0)
 		return -EBADF;
 
@@ -766,8 +767,8 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 		j -= nread;
 		off += nread;
 	} while (j);
-	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
-	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+	erofs_diskbuf_commit(inode->datasource.diskbuf, inode->i_size);
+	inode->datasource.type = EROFS_INODE_DATA_SOURCE_DISKBUF;
 	return nread < 0 ? nread : 0;
 }
 
@@ -1180,14 +1181,16 @@ new_inode:
 			} else if (tar->ddtaridx_mode) {
 				dataoff = le64_to_cpu(*(__le64 *)(th->devmajor));
 				if (tar->rvsp_mode) {
-					inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+					inode->datasource.type =
+						EROFS_INODE_DATA_SOURCE_RESVSP;
 					inode->i_ino[1] = dataoff;
 					ret = 0;
 				} else {
 					ret = tarerofs_write_chunkes(inode, dataoff);
 				}
 			} else if (tar->rvsp_mode) {
-				inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+				inode->datasource.type =
+					EROFS_INODE_DATA_SOURCE_RESVSP;
 				inode->i_ino[1] = dataoff;
 				if (erofs_iostream_lskip(&tar->ios, inode->i_size))
 					ret = -EIO;
-- 
2.47.3


