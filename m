Return-Path: <linux-erofs+bounces-2957-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I4zE3lDwWnPRwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2957-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9FB2F3313
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffZBD1DHzz2yds;
	Tue, 24 Mar 2026 00:43:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774273396;
	cv=none; b=Aw9fLGgo/W94GwYjs79GU8Hg0PgSpNwq1BdBHx0/Xw3j0VQOQWuH8GPPvGgNAR+sUM4kgKo+BXmPQ0swxz0wLb/S+l4voOEVL3bpU+m+/wHz525ZKbwRHSazcKgRAQo8X2RaT/XQTP0FXb3t1soZdbDXaPLFQgnpQNcExto3TxmLLRvUu6Bz4mHq8edV7gOFERQrxgqPYVzh+e6KCOL6myK4YQxnMI0wCiCiVY+ncJcSEK31ViU8gz8Prws4A0cNzxQsv1v+buQRfT5yEWK90OnShzPRmYX5R+0Mboqe+NcAaERIpojxza19HQkcg2IrwKTcVSfCoW7E66plha7xFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774273396; c=relaxed/relaxed;
	bh=Jeil9nYCvV7SgDCRDqZ9mvcvYd5ladJjAZqY77L3PcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Famuw5z6uQo7vyyc8Df1YiJOrOhpi4QFKev580/yiZS6AgAuu0bsVFQvTJw+eCDpl4/N4VgZz9b1Cq2PKBK5OcTBtVoJ/psfmRNgrWN1bHa55CGNhtrqQw05Cj4KSrqe0djrLlQ5fziYhM76Ped0taQoTyij5qWUncLYYcpSPjMRHiI4kNaZar0vwE9q0yYlCzkD4nrX2Uv06iw88/2fJPEK1mQoKSYQOPPuKt03g9/UDh2iOFvXl92XU9ntP15IGT45/VzkBmFIRjG8bilwStoW/paYbJf6kekXMLo6GrUfEtD8DCkmHZU+lgVYaRK8sge6x7FQLDBUxD1RPF+Uaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RykamLhq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RykamLhq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffZBC1SQWz2xs4
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 00:43:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D6094430B;
	Mon, 23 Mar 2026 13:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5438AC2BC9E;
	Mon, 23 Mar 2026 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273393;
	bh=xMb657+f1N2xYfPWnb1aj4SEVAPStwIMBVL9Kip7Z3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RykamLhqSYWjJt+ToOQ8ll3+fiO64VfAtG43cB2ExRA37HYrpf5HKnoCa7JBzIuLa
	 eTw6uwZPQlpikhFGRx92pjdL2lGiuIt8E+AzWNy0BnlKcwC5B+hKERTiD6K2om0/V5
	 Oe39pwoAh/VN+63UgcIbQ+02pcg6ljfXWGli1clZV2IQ52jMd1+pISm4FKaKAcl659
	 H6iO1K7JXydcGSIIniaSQSzEdjohE+zTo9/VDKxUNhLA704YKp1tl8c+X3kWZXMRzB
	 sm27wnAfpAiFqCFJEKvaAtBcfxUflVVIIQgES5v3mDmeOoYsaWuxiFeZrvgK90/ukW
	 Yo/cTCzmkfbsQ==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org,
	u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/4] fs/erofs: allocate data buffers on heap with alignment (1/3)
Date: Mon, 23 Mar 2026 14:42:18 +0100
Message-ID: <20260323134305.2675822-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2957-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,m:mwalle@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,konsulko.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: AC9FB2F3313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment).

This will also have the benefit, that large data (4k) isn't eating up
the stack.

The actual change is split across multiple patches. This one contains
all the simple changes.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/data.c  | 11 +++++++++--
 fs/erofs/fs.c    | 14 ++++++++++++--
 fs/erofs/namei.c | 26 +++++++++++++++++++-------
 fs/erofs/super.c | 40 +++++++++++++++++++++++++++++-----------
 fs/erofs/zmap.c  | 32 ++++++++++++++++++++++----------
 5 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 61dbae51a9a..2fe345d80ee 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -55,12 +55,16 @@ int erofs_map_blocks(struct erofs_inode *inode,
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_inode_chunk_index *idx;
-	u8 buf[EROFS_MAX_BLOCK_SIZE];
+	u8 *buf;
 	u64 chunknr;
 	unsigned int unit;
 	erofs_off_t pos;
 	int err = 0;
 
+	buf = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!buf)
+		return -ENOMEM;
+
 	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
@@ -82,8 +86,10 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		      vi->xattr_isize, unit) + unit * chunknr;
 
 	err = erofs_blk_read(buf, erofs_blknr(pos), 1);
-	if (err < 0)
+	if (err < 0) {
+		free(buf);
 		return -EIO;
+	}
 
 	map->m_la = chunknr << vi->u.chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
@@ -116,6 +122,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	}
 out:
 	map->m_llen = map->m_plen;
+	free(buf);
 	return err;
 }
 
diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index db86928511e..f44af001e96 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -55,7 +55,7 @@ struct erofs_dir_stream {
 	struct fs_dirent dirent;
 
 	struct erofs_inode inode;
-	char dblk[EROFS_MAX_BLOCK_SIZE];
+	char *dblk;
 	unsigned int maxsize, de_end;
 	erofs_off_t pos;
 };
@@ -69,7 +69,7 @@ static int erofs_readlink(struct erofs_inode *vi)
 	if (__builtin_add_overflow(vi->i_size, 1, &alloc_size))
 		return -EFSCORRUPTED;
 
-	target = malloc(alloc_size);
+	target = malloc_cache_aligned(alloc_size);
 	if (!target)
 		return -ENOMEM;
 	target[vi->i_size] = '\0';
@@ -96,6 +96,12 @@ int erofs_opendir(const char *filename, struct fs_dir_stream **dirsp)
 	if (!dirs)
 		return -ENOMEM;
 
+	dirs->dblk = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!dirs->dblk) {
+		free(dirs);
+		return -ENOMEM;
+	}
+
 	err = erofs_ilookup(filename, &dirs->inode);
 	if (err)
 		goto err_out;
@@ -113,6 +119,7 @@ int erofs_opendir(const char *filename, struct fs_dir_stream **dirsp)
 	*dirsp = (struct fs_dir_stream *)dirs;
 	return 0;
 err_out:
+	free(dirs->dblk);
 	free(dirs);
 	return err;
 }
@@ -198,6 +205,9 @@ int erofs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 
 void erofs_closedir(struct fs_dir_stream *fs_dirs)
 {
+	struct erofs_dir_stream *dirs = (struct erofs_dir_stream *)fs_dirs;
+
+	free(dirs->dblk);
 	free(fs_dirs);
 }
 
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index bde995f1bf2..b493ef97a09 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -182,7 +182,7 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 {
 	erofs_nid_t nid = nd->nid;
 	int ret;
-	char buf[EROFS_MAX_BLOCK_SIZE];
+	char *buf;
 	struct erofs_inode vi = { .nid = nid };
 	erofs_off_t offset;
 
@@ -190,6 +190,10 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 	if (ret)
 		return ret;
 
+	buf = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!buf)
+		return -ENOMEM;
+
 	offset = 0;
 	while (offset < vi.i_size) {
 		erofs_off_t maxsize = min_t(erofs_off_t,
@@ -199,28 +203,36 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 
 		ret = erofs_pread(&vi, buf, maxsize, offset);
 		if (ret)
-			return ret;
+			goto out;
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
 		    nameoff >= erofs_blksiz()) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto out;
 		}
 
 		de = find_target_dirent(nid, buf, name, len,
 					nameoff, maxsize);
-		if (IS_ERR(de))
-			return PTR_ERR(de);
+		if (IS_ERR(de)) {
+			ret = PTR_ERR(de);
+			goto out;
+		}
 
 		if (de) {
 			nd->nid = le64_to_cpu(de->nid);
-			return 0;
+			ret = 0;
+			goto out;
 		}
 		offset += maxsize;
 	}
-	return -ENOENT;
+
+	ret = -ENOENT;
+out:
+	free(buf);
+	return ret;
 }
 
 static int link_path_walk(const char *name, struct nameidata *nd)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d405d488fd2..af6953b5ed5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -43,40 +43,54 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	if (!sbi->devs)
 		return -ENOMEM;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
+
+	struct erofs_deviceslot *dis;
+
+	dis = malloc_cache_aligned(sizeof(*dis));
+	if (!dis)
+		return -ENOMEM;
+
 	for (i = 0; i < ondisk_extradevs; ++i) {
-		struct erofs_deviceslot dis;
 		int ret;
 
-		ret = erofs_dev_read(0, &dis, pos, sizeof(dis));
+		ret = erofs_dev_read(0, dis, pos, sizeof(*dis));
 		if (ret < 0) {
 			free(sbi->devs);
+			free(dis);
 			return ret;
 		}
 
-		sbi->devs[i].mapped_blkaddr = dis.mapped_blkaddr;
-		sbi->total_blocks += dis.blocks;
+		sbi->devs[i].mapped_blkaddr = dis->mapped_blkaddr;
+		sbi->total_blocks += dis->blocks;
 		pos += EROFS_DEVT_SLOT_SIZE;
 	}
+	free(dis);
+
 	return 0;
 }
 
 int erofs_read_superblock(void)
 {
-	u8 data[EROFS_MAX_BLOCK_SIZE];
+	u8 *data;
 	struct erofs_super_block *dsb;
 	int ret;
 
-	ret = erofs_blk_read(data, 0, erofs_blknr(sizeof(data)));
+	data = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!data)
+		return -ENOMEM;
+
+	ret = erofs_blk_read(data, 0, erofs_blknr(EROFS_MAX_BLOCK_SIZE));
 	if (ret < 0) {
 		erofs_dbg("cannot read erofs superblock: %d", ret);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_dbg("cannot find valid erofs superblock");
-		return ret;
+		goto out;
 	}
 
 	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
@@ -86,9 +100,9 @@ int erofs_read_superblock(void)
 	    sbi.blkszbits > ilog2(EROFS_MAX_BLOCK_SIZE)) {
 		erofs_err("blksize %llu isn't supported on this platform",
 			  erofs_blksiz() | 0ULL);
-		return ret;
+		goto out;
 	} else if (!check_layout_compatibility(&sbi, dsb)) {
-		return ret;
+		goto out;
 	}
 
 	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
@@ -104,5 +118,9 @@ int erofs_read_superblock(void)
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+	ret = erofs_init_devices(&sbi, dsb);
+
+out:
+	free(data);
+	return ret;
 }
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4f64258b004..1ded934a5d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -25,15 +25,21 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	int ret;
 	erofs_off_t pos;
 	struct z_erofs_map_header *h;
-	char buf[sizeof(struct z_erofs_map_header)];
+	char *buf;
 
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
+	buf = malloc_cache_aligned(sizeof(struct z_erofs_map_header));
+	if (!buf)
+		return -ENOMEM;
+
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = erofs_dev_read(0, buf, pos, sizeof(buf));
-	if (ret < 0)
-		return -EIO;
+	ret = erofs_dev_read(0, buf, pos, sizeof(struct z_erofs_map_header));
+	if (ret < 0) {
+		ret = -EIO;
+		goto err_out;
+	}
 
 	h = (struct z_erofs_map_header *)buf;
 	/*
@@ -54,7 +60,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
 		erofs_err("unknown compression format %u for nid %llu",
 			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto err_out;
 	}
 
 	vi->z_logical_clusterbits = sbi.blkszbits + (h->h_clusterbits & 7);
@@ -63,7 +70,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid * 1ULL);
-		return -EFSCORRUPTED;
+		ret = -EFSCORRUPTED;
+		goto err_out;
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
@@ -76,10 +84,11 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
 			erofs_err("invalid tail-packing pclustersize %llu",
 				  map.m_plen | 0ULL);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto err_out;
 		}
 		if (ret < 0)
-			return ret;
+			goto err_out;
 	}
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
 	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
@@ -89,11 +98,14 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		ret = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (ret < 0)
-			return ret;
+			goto err_out;
 	}
 out:
 	vi->flags |= EROFS_I_Z_INITED;
-	return 0;
+	ret = 0;
+err_out:
+	free(buf);
+	return ret;
 }
 
 struct z_erofs_maprecorder {
-- 
2.47.3


