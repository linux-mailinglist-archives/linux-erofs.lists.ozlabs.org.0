Return-Path: <linux-erofs+bounces-3505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB71AC2sHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D162C402
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66L2smCz2ytV;
	Tue, 02 Jun 2026 20:10:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395050;
	cv=none; b=SXTkh1PFChmdnHodX6cs3hu7y9ED+pjLDF/Ndyo1K5fwZX6pscM5ieICfFXjZ28MX/JXz3U3okqmxN1cdCw7troAFKL1z6Ceo1i1a6b8dmtzWeBWiw3cmZTb+OQ6B5gR6kCkpT9y337L+lmiYKnSyIbAnRAWl4CYPCTuXm/WRKqJlcSzhB8dhnfiB1gXLeYQFl884eFEV8XRH2bKtbWnT28T9i61pr0l5BhBWz8UcTHaGm3KQMh1NU2+Hwb8Nkxn/3meIp/aEs85NHw+IUc/gvnNmc/EAoKRYzMYtX7weL1uAXMENbIQWythdykufJ6WkeFEG8tctPxTL5O1NXqTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395050; c=relaxed/relaxed;
	bh=5bBzVi4bBIK5tK2AYeV9dNHzpJuPm4TjbWGXo8xGZGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ibt518RLFnc6u359oLJcwsjnW3/ip4eCGFd6841ceT8HrP7hXqpCEjmn8zl0+Y4wYsTuaOz6GdZy2sq/DUkUdaVodBoEk1o3RaenP6YZh0PYejzw0zqTTLpERSBfark5idJD9ZPM9aGNzvfcr3Z2s27MP2uJisgql40xWb5g8aS9D/T0V6jNCMY4mKZeVNdgWDyRbIDVBut7mY2Q+hKejT5F5COhPOgyXdjlosuUUUOQKTxdMCa8Z95RkGD3IawPZYRg3t9uryFXc6+LFOzDHvxODTjzGxzsWNnOs4i4F3BpLzHkdqEEN4SZDyo7rX5vLSU+Hi+F9lQhaIsPn5OsTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeFRVuEy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeFRVuEy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66K4KzPz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B343A6012B;
	Tue,  2 Jun 2026 10:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216A91F00893;
	Tue,  2 Jun 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395047;
	bh=5bBzVi4bBIK5tK2AYeV9dNHzpJuPm4TjbWGXo8xGZGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AeFRVuEyR0A20ZtgU5dPVf0eDw0c7XFSyhj5dtede4QGcluYMTeYtifMC5iR5XnGX
	 wHUXAPLk+87sonl7T37TwkoLvCUZhbd+gSThgOX309X9rE6TwvVadruCk76Aytlj3N
	 XPa6OOtFtvZXSWMIsWJG0wswkVofTjU6Njtcw2QXDs/57twKmM7AF/YprE14G8CHsY
	 YwKGXHThQducHnEKFUNrDWRB2wS3HC+ZvcQj7kT7ZhJAzd8+UO058UeOS2+IAcBODf
	 pvevE4L1pq85maDAfTFD9Mu4vl2NugCGFtDYmOXe2FsTxnuO2ET/UgGfjRZ4kNnUmK
	 Y3edpjJ2DBISA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:13 +0200
Subject: [PATCH RFC 7/8] erofs: open via dedicated fs bdev helpers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-work-super-bdev_holder_global-v1-7-bb0fd82f3861@kernel.org>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, 
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7744; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rcHD4HbFbUrUpExn6n0CNv7K4b9hWXj4N9RjO33LQqM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreHY5X4o6u+VmAbplGN/S3j3PHN4Y3E6fV/YwhOP9
 xzn0LM811HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRj5MZ/pdG+t3afEJN7Iv4
 7K8VLJ5qPTwuh6dfD5swLYGjfGXyVRNGhgVzy244cyedkOOIP3gw8fjEU3XCp3+/C0wpWreUz2X
 lHhYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 692D162C402
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3505-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Route opens through fs_bdev_file_open_by_path() so each external device
is registered against the correct superblock, and convert the matching
releases.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/erofs/data.c     |  6 +++++
 fs/erofs/internal.h | 10 ++++++++
 fs/erofs/super.c    | 66 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/erofs/zdata.c    | 10 +++++---
 4 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 44da21c9d777..5220585293df 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -69,6 +69,9 @@ int erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
+	if (erofs_is_shutdown(sb))
+		return -EIO;
+
 	buf->file = NULL;
 	if (in_metabox) {
 		if (unlikely(!sbi->metabox_inode))
@@ -236,6 +239,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		}
 		up_read(&devs->rwsem);
 	}
+	if (erofs_is_shutdown(sb) ||
+	    (map->m_dif && READ_ONCE(map->m_dif->dead)))
+		return -EIO;
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4792490161ec..ca1ed7ce3961 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -48,6 +48,7 @@ struct erofs_device_info {
 
 	erofs_blk_t blocks;
 	erofs_blk_t uniaddr;
+	bool dead;		/* backing device gone; fence I/O */
 };
 
 enum {
@@ -104,6 +105,7 @@ struct erofs_xattr_prefix_item {
 struct erofs_sb_info {
 	struct erofs_device_info dif0;
 	struct erofs_mount_opts opt;	/* options */
+	unsigned long flags;		/* see EROFS_SB_* */
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
@@ -195,6 +197,14 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+/* erofs_sb_info->flags */
+#define EROFS_SB_SHUTDOWN	0	/* primary device gone; fail all I/O */
+
+static inline bool erofs_is_shutdown(struct super_block *sb)
+{
+	return test_bit(EROFS_SB_SHUTDOWN, &EROFS_SB(sb)->flags);
+}
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 802add6652fd..e03cb95be96b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -153,8 +153,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	} else if (!sbi->devs->flatdev) {
 		file = erofs_is_fileio_mode(sbi) ?
 				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
-				bdev_file_open_by_path(dif->path,
-						BLK_OPEN_READ, sb->s_type, NULL);
+				fs_bdev_file_open_by_path(dif->path,
+						BLK_OPEN_READ, sb->s_type, sb);
 		if (IS_ERR(file)) {
 			if (file == ERR_PTR(-ENOTBLK))
 				return -EINVAL;
@@ -843,11 +843,16 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 static int erofs_release_device_info(int id, void *ptr, void *data)
 {
+	struct super_block *sb = data;
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->file)
-		fput(dif->file);
+	if (dif->file) {
+		if (S_ISBLK(file_inode(dif->file)->i_mode))
+			fs_bdev_file_release(dif->file, sb);
+		else
+			fput(dif->file);
+	}
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
@@ -855,18 +860,19 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	return 0;
 }
 
-static void erofs_free_dev_context(struct erofs_dev_context *devs)
+static void erofs_free_dev_context(struct erofs_dev_context *devs,
+				   struct super_block *sb)
 {
 	if (!devs)
 		return;
-	idr_for_each(&devs->tree, &erofs_release_device_info, NULL);
+	idr_for_each(&devs->tree, &erofs_release_device_info, sb);
 	idr_destroy(&devs->tree);
 	kfree(devs);
 }
 
-static void erofs_sb_free(struct erofs_sb_info *sbi)
+static void erofs_sb_free(struct erofs_sb_info *sbi, struct super_block *sb)
 {
-	erofs_free_dev_context(sbi->devs);
+	erofs_free_dev_context(sbi->devs, sb);
 	kfree(sbi->fsid);
 	kfree_sensitive(sbi->domain_id);
 	if (sbi->dif0.file)
@@ -879,8 +885,13 @@ static void erofs_fc_free(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (sbi) /* free here if an error occurs before transferring to sb */
-		erofs_sb_free(sbi);
+	/*
+	 * Freed here only if an error occurs before the sb is set up; at that
+	 * point no block-backed device has been claimed (that happens in
+	 * fill_super), so the NULL sb never reaches fs_bdev_file_release().
+	 */
+	if (sbi)
+		erofs_sb_free(sbi, NULL);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -936,7 +947,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-	erofs_sb_free(sbi);
+	erofs_sb_free(sbi, sb);
 	sb->s_fs_info = NULL;
 }
 
@@ -948,7 +959,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
 	erofs_drop_internal_inodes(sbi);
-	erofs_free_dev_context(sbi->devs);
+	erofs_free_dev_context(sbi->devs, sb);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
 }
@@ -1121,6 +1132,35 @@ static void erofs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+/*
+ * A blob device may back several erofs superblocks; fence only the affected
+ * one and keep the rest of the mount alive.  The primary device falls back to
+ * the generic teardown (return non-zero).
+ */
+static int erofs_remove_bdev(struct super_block *sb, struct block_device *bdev)
+{
+	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
+	struct erofs_device_info *dif;
+	int id;
+
+	if (bdev == sb->s_bdev)
+		return 1;
+
+	down_read(&devs->rwsem);
+	idr_for_each_entry(&devs->tree, dif, id) {
+		if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode) &&
+		    file_bdev(dif->file)->bd_dev == bdev->bd_dev)
+			WRITE_ONCE(dif->dead, true);
+	}
+	up_read(&devs->rwsem);
+	return 0;
+}
+
+static void erofs_shutdown(struct super_block *sb)
+{
+	set_bit(EROFS_SB_SHUTDOWN, &EROFS_SB(sb)->flags);
+}
+
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = erofs_alloc_inode,
@@ -1128,6 +1168,8 @@ const struct super_operations erofs_sops = {
 	.evict_inode = erofs_evict_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
+	.remove_bdev = erofs_remove_bdev,
+	.shutdown = erofs_shutdown,
 };
 
 module_init(erofs_module_init);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 43bb5a6a9924..89ae91935364 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1697,11 +1697,15 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 			continue;
 		}
 
-		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
 			.m_pa = round_down(pcl->pos, sb->s_blocksize),
 		};
-		(void)erofs_map_dev(sb, &mdev);
+		if (erofs_map_dev(sb, &mdev)) {
+			/* the backing device is gone; fail the batch */
+			q[JQ_SUBMIT]->eio = true;
+			qtail[JQ_SUBMIT] = &pcl->next;
+			continue;
+		}
 
 		cur = mdev.m_pa;
 		end = round_up(cur + pcl->pageofs_in + pcl->pclustersize,
@@ -1785,7 +1789,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 	 * although background is preferred, no one is pending for submission.
 	 * don't issue decompression but drop it directly instead.
 	 */
-	if (!*force_fg && !nr_bios) {
+	if (!*force_fg && !nr_bios && !q[JQ_SUBMIT]->eio) {
 		kvfree(q[JQ_SUBMIT]);
 		return;
 	}

-- 
2.47.3


