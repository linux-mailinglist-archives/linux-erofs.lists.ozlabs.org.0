Return-Path: <linux-erofs+bounces-1227-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78642BE8472
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 13:20:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp2Rj3Pgqz3cYg;
	Fri, 17 Oct 2025 22:20:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760700017;
	cv=none; b=KWixwTnLoUjLTid93QBOHEJuj2HgQ0y8cZ4ak8bUqvqju9YjFZ//kUSGjAbz98zPt5bQGyTjOG7EDZBCyg7wHa23Kd7aQDCOICqrLNTFBEdDNapnPGF1QmqzWs8RIChPGoqX819IOrvMqTIWHPGUBAv/XzDnhmrWvFkLARBmjTidiiDWGcVI7sTjNIV6ZAZ1/MBL1f12vqJZqsejQgF/1ECVWiP7bDQpM9PmKY7fsXZ8QEzpRkMIgDmbXv1j199ikBTsjJk9No56zNlRGfoZvZ0HLqw53DbmO4jbAXnQzzcZDEwAMhqIYKXoReJJFjvkEsZ78XWMMHNSbI4hKnJa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760700017; c=relaxed/relaxed;
	bh=IE9hN1yAVZm/V1CqjtazVEmJ95d/UhTcdOkqSFk1jbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJN+BDLXAAjUCydhwGPx4xRhz+wDX6qCNqunGLkT9qUwSwoopwjQxWlXdCusF6GDB1CWCQPfok1lLf/FKUJR4cz3zoflwIDOw2HVH7QmzjLTStlgj5ukHYPs8pHIib+JPF4qLOvftn2sK/6hsyPdt98tqnVfp+NxdnpSrtOOVb8woAB+F65w2rOLCrLgjxDgZyLZU30E14qiLtyskeiTjdvG+eV4FxnpPQP6Vs/nY0iNEYvAR/KkpMOh/nQn45FXmhSfw4/aa9Wa1yKIWDVahSLG/QvrafsEQFUuG76Y0muKpBDNNQ2PPOGIkgy6q93zsTBb5KLvauCIssr4PvSWjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qMflv84N; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qMflv84N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp2Rg0VGhz3cZ2
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 22:20:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760700010; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IE9hN1yAVZm/V1CqjtazVEmJ95d/UhTcdOkqSFk1jbU=;
	b=qMflv84NKrUsdI+NbXL94xp3oRl5Wt+5hdk7sKpOIRrzr6j+ShDjBMc1QBZ1t46hxMKw75nlk2yJdxX9SHjQ4x8yiAuEnetTfpAeJjTinqNrnThzqN94D3qI04lLcQI9OrFuvouJP2y/qtpuUUSMvR7IZ5INUGBKZB3fSTeXYr4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqPWSqT_1760700008 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 19:20:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Neal Gompa <ngompa13@gmail.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: support directory compression
Date: Fri, 17 Oct 2025 19:20:02 +0800
Message-ID: <20251017112002.1254940-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251017112002.1254940-1-hsiangkao@linux.alibaba.com>
References: <20251017112002.1254940-1-hsiangkao@linux.alibaba.com>
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

Although directories can be compressed using various approaches
supported by regular inodes, it is difficult to predict the total
compressed size due to a lack of (parent) NIDs or child NIDs at
that time.

To simplify this, dump entire directory data into the packed
inode (all-fragments) as a first step.  Therefore, Linux 6.1+ is
required for directory compression for now.

 _____________________________________________________________________
|__ Testset __|_________|_______ Command line _________|____ Size ____|
|             | Vanilla | -zlzma -Efragments -C1048576 |  2553946112  |
|             |         |______________________________|_ [2436 MiB] _|
|             |         | [..] -m4096                  |  2524413952  |
| Fedora KIWI |_________|______________________________|_ [2408 MiB] _|
|             | After   | [..] --zD                    |  2542051328  |
|             |         |______________________________|_ [2425 MiB] _|
|             |         | [..] -m4096 --zD             |  2521423872  |
|_____________|_________|______________________________|_ [2405 MiB] _|
|             | Vanilla | -zlzma -Efragments -C1048576 |   4837376    |
|   OpenWrt   |_________|______________________________|_ [4724 KiB] _|
|             | After   | [..] -m4096 --zD             |   4730880    |
|_____________|_________|______________________________|_ [4620 KiB] _|

`-m4096`  Enable inode metadata compression in 4K pclusters.
`--zD`    Enable directory data compression.

Note that incremental builds are still unsupported for compressed
directories, but this can be implemented later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/importer.h |  1 +
 lib/compress.c           | 45 +++++++++++++++++++++++++++++++++++++++-
 lib/fragments.c          |  8 +++++--
 lib/importer.c           | 17 +++++++--------
 lib/inode.c              | 31 ++++++++++++++++++++-------
 lib/liberofs_compress.h  |  4 ++++
 mkfs/main.c              |  8 +++++++
 7 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 48fe47e..60f81d6 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -48,6 +48,7 @@ struct erofs_importer_params {
 	bool dedupe;
 	bool fragments;
 	bool all_fragments;
+	bool compress_dir;
 	char fragdedupe;
 };
 
diff --git a/lib/compress.c b/lib/compress.c
index 97cb791..1a68841 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1341,7 +1341,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		if (ret)
 			goto err_free_idata;
 		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-		erofs_sb_set_fragments(inode->sbi);
+		erofs_sb_set_fragments(sbi);
 	}
 
 	/* fall back to no compression mode */
@@ -1980,6 +1980,49 @@ out:
 	return ret;
 }
 
+int erofs_begin_compress_dir(struct erofs_importer *im,
+			     struct erofs_inode *inode)
+
+{
+	if (!im->params->compress_dir ||
+	    inode->i_size < Z_EROFS_LEGACY_MAP_HEADER_SIZE)
+		return -ENOSPC;
+
+	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	erofs_sb_set_fragments(inode->sbi);
+	inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+	inode->extent_isize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	inode->compressmeta = NULL;
+	return 0;
+}
+
+int erofs_write_compress_dir(struct erofs_inode *inode, struct erofs_vfile *vf)
+{
+	void *compressmeta;
+	int err;
+
+	if (inode->datalayout != EROFS_INODE_COMPRESSED_FULL ||
+	    inode->extent_isize < Z_EROFS_LEGACY_MAP_HEADER_SIZE) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
+	err = erofs_pack_file_from_fd(inode, vf, 0, ~0U);
+	if (err || !inode->fragment_size)
+		return err;
+	err = erofs_fragment_commit(inode, ~0);
+	if (err)
+		return err;
+
+	compressmeta = calloc(1, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	if (!compressmeta)
+		return -ENOMEM;
+	*(__le64 *)compressmeta =
+		cpu_to_le64(inode->fragmentoff | 1ULL << 63);
+	inode->compressmeta = compressmeta;
+	return 0;
+}
+
 static int z_erofs_build_compr_cfgs(struct erofs_importer *im,
 				    u32 *max_dict_size)
 {
diff --git a/lib/fragments.c b/lib/fragments.c
index 15092e1..0f07e33 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -257,11 +257,13 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode,
 	if (memblock == MAP_FAILED || !memblock) {
 		erofs_off_t remaining = inode->i_size;
 		struct erofs_vfile vout = { .fd = epi->fd };
+		bool noseek = vf->ops && !vf->ops->pread;
 		off_t pos = fpos;
 
 		do {
 			sz = min_t(u64, remaining, UINT_MAX);
-			rc = erofs_io_sendfile(&vout, vf, &pos, sz);
+			rc = erofs_io_sendfile(&vout, vf,
+					       noseek ? NULL : &pos, sz);
 			if (rc <= 0)
 				break;
 			remaining -= rc;
@@ -372,10 +374,12 @@ int erofs_flush_packed_inode(struct erofs_importer *im)
 	struct erofs_inode *inode;
 
 	if (!epi || !erofs_sb_has_fragments(sbi))
-		return -EINVAL;
+		return 0;
 
 	if (lseek(epi->fd, 0, SEEK_CUR) <= 0)
 		return 0;
+
+	erofs_update_progressinfo("Processing packed data ...");
 	inode = erofs_mkfs_build_special_from_fd(im, epi->fd,
 						 EROFS_PACKED_INODE);
 	sbi->packed_nid = erofs_lookupnid(inode);
diff --git a/lib/importer.c b/lib/importer.c
index ad4bed8..c73dde2 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -57,12 +57,14 @@ int erofs_importer_init(struct erofs_importer *im)
 	if (err)
 		goto out_err;
 
-	if (params->fragments || cfg.c_extra_ea_name_prefixes) {
+	if (params->fragments || cfg.c_extra_ea_name_prefixes ||
+	    params->compress_dir) {
 		subsys = "packedfile";
 		if (!params->pclusterblks_packed)
 			params->pclusterblks_packed = params->pclusterblks_def;
 
-		err = erofs_packedfile_init(sbi, params->fragments);
+		err = erofs_packedfile_init(sbi, params->fragments ||
+						params->compress_dir);
 		if (err)
 			goto out_err;
 	}
@@ -90,7 +92,6 @@ out_err:
 
 int erofs_importer_flush_all(struct erofs_importer *im)
 {
-	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
 	unsigned int fsalignblks;
 	int err;
@@ -102,13 +103,9 @@ int erofs_importer_flush_all(struct erofs_importer *im)
 			return err;
 	}
 
-	if ((params->fragments || cfg.c_extra_ea_name_prefixes) &&
-	    erofs_sb_has_fragments(sbi)) {
-		erofs_update_progressinfo("Handling packed data ...");
-		err = erofs_flush_packed_inode(im);
-		if (err)
-			return err;
-	}
+	err = erofs_flush_packed_inode(im);
+	if (err)
+		return err;
 
 	fsalignblks = im->params->fsalignblks ?
 		roundup_pow_of_two(im->params->fsalignblks) : 1;
diff --git a/lib/inode.c b/lib/inode.c
index 7587248..f9b5ee9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -344,12 +344,7 @@ static int erofs_prepare_dir_file(struct erofs_importer *im,
 		return -EFAULT;
 	}
 	dir->i_size = d_size;
-
-	/* no compression for all dirs */
-	dir->datalayout = EROFS_INODE_FLAT_INLINE;
-
-	/* it will be used in erofs_prepare_inode_buffer */
-	dir->idata_size = d_size % erofs_blksiz(sbi);
+	dir->datalayout = EROFS_INODE_DATALAYOUT_MAX;
 	return 0;
 }
 
@@ -703,12 +698,16 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	struct erofs_vfile *vf;
 	int err;
 
-	DBG_BUGON(dir->idata_size != (dir->i_size & (bsz - 1)));
 	vf = erofs_dirwriter_open(dir);
 	if (IS_ERR(vf))
 		return PTR_ERR(vf);
 
-	err = erofs_write_unencoded_data(dir, vf, 0, true);
+	if (erofs_inode_is_data_compressed(dir->datalayout)) {
+		err = erofs_write_compress_dir(dir, vf);
+	} else {
+		DBG_BUGON(dir->idata_size != (dir->i_size & (bsz - 1)));
+		err = erofs_write_unencoded_data(dir, vf, 0, true);
+	}
 	erofs_io_close(vf);
 	return err;
 }
@@ -1510,6 +1509,22 @@ static int erofs_mkfs_jobfn(struct erofs_importer *im,
 		return erofs_mkfs_handle_nondirectory(im, &item->u.ndir);
 
 	if (item->type == EROFS_MKFS_JOB_DIR) {
+		unsigned int bsz = erofs_blksiz(inode->sbi);
+
+		if (inode->datalayout == EROFS_INODE_DATALAYOUT_MAX) {
+			inode->datalayout = EROFS_INODE_FLAT_INLINE;
+
+			ret = erofs_begin_compress_dir(im, inode);
+			if (ret && ret != -ENOSPC)
+				return ret;
+		} else {
+			DBG_BUGON(inode->datalayout != EROFS_INODE_FLAT_PLAIN);
+		}
+
+		/* it will be used in erofs_prepare_inode_buffer */
+		if (inode->datalayout == EROFS_INODE_FLAT_INLINE)
+			inode->idata_size = inode->i_size & (bsz - 1);
+
 		ret = erofs_prepare_inode_buffer(im, inode);
 		if (ret)
 			return ret;
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index 8b39735..4b9dd42 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -22,6 +22,10 @@ void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
 int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
+int erofs_begin_compress_dir(struct erofs_importer *im,
+			     struct erofs_inode *inode);
+int erofs_write_compress_dir(struct erofs_inode *inode, struct erofs_vfile *vf);
+
 int z_erofs_compress_init(struct erofs_importer *im);
 int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 11e3032..f1ea7df 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -100,6 +100,7 @@ static struct option long_options[] = {
 #ifdef OCIEROFS_ENABLED
 	{"oci", optional_argument, NULL, 534},
 #endif
+	{"zD", optional_argument, NULL, 536},
 	{0, 0, 0, 0},
 };
 
@@ -174,6 +175,7 @@ static void usage(int argc, char **argv)
 		"    --all-time         the timestamp is also applied to all files (default)\n"
 		"    --mkfs-time        the timestamp is applied as build time only\n"
 		" -UX                   use a given filesystem UUID\n"
+		" --zD[=<0|1>]          specify directory compression: 0=disable [default], 1=enable\n"
 		" --all-root            make all files owned by root\n"
 #ifdef EROFS_MT_ENABLED
 		" --async-queue-limit=# specify the maximum number of entries in the multi-threaded job queue\n"
@@ -1404,6 +1406,12 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				mkfs_aws_zinfo_file = strdup(optarg);
 			tarerofs_decoder = EROFS_IOS_DECODER_GZRAN;
 			break;
+		case 536:
+			if (!optarg || strcmp(optarg, "1"))
+				params->compress_dir = true;
+			else
+				params->compress_dir = false;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.43.5


