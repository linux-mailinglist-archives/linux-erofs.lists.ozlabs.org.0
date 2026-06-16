Return-Path: <linux-erofs+bounces-3646-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JDAlNBZZMWr7hQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3646-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCC69041C
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hxujoGIj;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3646-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3646-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpl807xCz3c4P;
	Wed, 17 Jun 2026 00:09:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618963;
	cv=none; b=Lfdft5phe3zqwTv/T12wTp5uXHrXJ1mMCYPzKjeHKnJkYSCm09Kf+q7dznS3oJ58sjygxyvbiByXkynEBA0uWLfXNZrTK9DAzV40GJmc7T0v42PGH4jprZ/JE76ZbvQCJ5nk4ExGQXyDl68wT8AMIF0s5J51l7g287P0h6LgIkBs9ZPCFXsqRPQKIZuCUhXkkmIJbuQud69MdIRxE4BAyxSQKwu5uaoK2nlws1r9wKq0zSJawDMJ3nNRpZLgl9S7NCACqJlzMYWEFMl4KgIMegJJxYhRh9ahhE5LYX5yNsfpsLyMyeWVyXZ+/I3vj6Uabi2IenKqS8BWncnemXuWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618963; c=relaxed/relaxed;
	bh=tTIkFsp5UcXIT6SFLL89oWKMm70T57Mphul+BOM/5zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ8y4sum6vaZafHh/ui4Faa5UZtf1wuqCIMEATxQcpnVDECr7Bf3gcqjYpc4lxtVB1Zlv/UZve6SlksiinZAjd8EGBdzXOPkR2lyOTFV/9hx9syBtLd3zsLW0p+KgKH/KezqQuADshNjIOnz9xT38ZXT/jLGt7gGuGNnuKsrGC7BFAeWXW97IGDmdNioy+yKk40Lu51cGYyblC1h4yvay9jT2K0o2NJuR0tgV9ytL/p+dteId/dplGu6Fu1kwbwVSOBqeFDM91hwn1ElTP2WABC5NyCP7VgaxyITbuNBtfBB6tYREsAelmKlfXjgxjOJW4PCSfzG858ttKu7qWYOYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxujoGIj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpl667Qdz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E4FE060120;
	Tue, 16 Jun 2026 14:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565061F000E9;
	Tue, 16 Jun 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618960;
	bh=tTIkFsp5UcXIT6SFLL89oWKMm70T57Mphul+BOM/5zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hxujoGIj0vJbjP4O4KmdOOHDnWgacJbv2/Dj8ykGUdqqSC92eTEj/Jf/TQz2cYm5H
	 4YRnNNbgnjfE2D6HuttB9z7swbZLSNn9xK7F09Om58Wzhz2hYHvNH2Dfq2fpUsoEY2
	 0SOqlLPecglbhGyU2fmqHpHjaTcRjwgK9+52lZACu5a73tzJw+kyqCnK+IygwTikfZ
	 Nv4fHGMeKbcKhj+8q9WnM+cuDWAKWCHuZsmYjwaooyPDpXO0+++xWbDZZ+igSGy+3e
	 IqUbR163dca6o6/kWltUxf5Na84RkTxkMqRd4dWZOawT84cQ2W9Nd8FSQ660QqcTmZ
	 QnTrlzdCVRi+g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:28 +0200
Subject: [PATCH RFC v2 12/18] fs: look up superblocks via the device table
 in fs_holder_ops
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-12-7df6b864028e@kernel.org>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
 linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, 
 linux-erofs@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=15601; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dHAH9fb9gMmmp4uvFUS5cPVN6cXPG3H8R7+OIHOOk8o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRty/7uCy4vp6nccNNvOeyYkc3LXiUtqTwxKbH5irn
 DyzTjvrYUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjPMZ/umUFk//NLHpRFGH
 d0Ne2/TshruX8rp+3I1/cDo1ZPvKJUsZGdZMY193f+dNpqyTDRa5DI/zGdq05z9sNjnFZ7h0yg9
 THQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3646-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33FCC69041C

Switch the fs_holder_ops callbacks from recovering the single owning
superblock out of bdev->bd_holder to walking the device-to-superblock
table and acting on every superblock registered for the device. The
holder argument becomes purely the block layer's exclusivity token and
is no longer needed by the fs specific callbacks.

All devices opened with fs_holder_ops are registered by now: the main
device since setup_bdev_super() switched to fs_bdev_file_open_by_dev()
and the extra devices (xfs log and realtime devices, btrfs member
devices, the ext4 external journal) since the preceding per-filesystem
conversions. So no event is lost in the switchover.

The walk uses a refcount-pinning cursor: each step takes a reference on
the entry via sd_ref and resumes from its sd_node. Unlinking an entry
is deferred to the last unpin, so a cursor never resumes from a removed
node.

mark_dead and sync only need the passive reference the entry holds plus
s_umount, which they take with super_lock_shared(). freeze and thaw
additionally need an active reference and acquire it with
get_active_super(), which waits for the superblock to be born before
taking s_active. Taking s_active before the superblock is born would
pin a still-mounting superblock so a racing mount that aborts could
never drop s_active to zero and reach SB_DYING, deadlocking the wait
for SB_BORN. This is how filesystems_freeze() and filesystems_thaw()
acquire it too.

One semantic change: when no live superblock uses the device anymore
(the holder is dying or was never registered), fs_bdev_freeze() and
fs_bdev_thaw() now return 0 - freeze after syncing the block device -
where they used to return -EINVAL.

The freeze-deny release path moves to the table in the same switchover.
A device made unfreezable for a btrfs membership change must drop its
table entry before re-allowing freezing; otherwise a freeze racing the
release reaches the superblock through the still-registered entry and is
stranded once the release unlinks it. Split fs_bdev_unregister() out of
fs_bdev_file_release() - the inverse of fs_bdev_register() - so
btrfs_release_device_allow_freeze() can drop the {dev, sb} entry, re-allow
freezing on the still-open device, then close it. Re-allowing only after
the entry is gone keeps a racing freeze from reaching the superblock, and
doing it while the file is still open avoids touching the block device
after the close. btrfs previously yielded bd_holder before re-allowing,
which this commit makes irrelevant to freeze resolution.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/btrfs/volumes.c       |   6 +-
 fs/super.c               | 269 +++++++++++++++++++++++------------------------
 include/linux/fs/super.h |   1 +
 3 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 02abbfce5ea3..d827d83722c1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1137,10 +1137,10 @@ void btrfs_release_device_allow_freeze(struct file *bdev_file)
 {
 	struct super_block *sb = bdev_file->private_data;
 
-	/* Yield before allow (strand-safe); file still open for the allow (UAF-safe). */
-	bdev_yield_claim(bdev_file);
+	/* Unregister before re-allowing (strand-safe); file still open (UAF-safe). */
+	fs_bdev_unregister(bdev_file, sb);
 	bdev_allow_freeze(file_bdev(bdev_file));
-	fs_bdev_file_release(bdev_file, sb);
+	bdev_fput(bdev_file);
 }
 
 static void btrfs_close_bdev(struct btrfs_device *device, bool allow_freeze)
diff --git a/fs/super.c b/fs/super.c
index 3d166c7f578a..236e868209a4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -501,6 +501,42 @@ static int super_dev_register(struct super_block *sb)
 	return err;
 }
 
+#ifdef CONFIG_BLOCK
+static struct super_dev *super_dev_get(struct rhlist_head *pos)
+{
+	struct super_dev *sb_dev;
+
+	for (; pos; pos = rcu_dereference_all(pos->next)) {
+		sb_dev = container_of(pos, struct super_dev, sd_node);
+		if (refcount_inc_not_zero(&sb_dev->sd_ref))
+			return sb_dev;
+	}
+	return NULL;
+}
+
+static struct super_dev *super_dev_first(dev_t dev)
+{
+	struct super_dev *sb_dev;
+
+	rcu_read_lock();
+	sb_dev = super_dev_get(rhltable_lookup(&super_dev_table, &dev, super_dev_params));
+	rcu_read_unlock();
+	return sb_dev;
+}
+
+static struct super_dev *super_dev_next(struct super_dev *prev)
+{
+	struct super_dev *sb_dev;
+
+	rcu_read_lock();
+	sb_dev = super_dev_get(rcu_dereference_all(prev->sd_node.next));
+	rcu_read_unlock();
+
+	super_dev_put(prev);
+	return sb_dev;
+}
+#endif
+
 static void kill_super_notify(struct super_block *sb)
 {
 	lockdep_assert_not_held(&sb->s_umount);
@@ -1443,185 +1479,131 @@ struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
 EXPORT_SYMBOL(sget_dev);
 
 #ifdef CONFIG_BLOCK
-/*
- * Lock the superblock that is holder of the bdev. Returns the superblock
- * pointer if we successfully locked the superblock and it is alive. Otherwise
- * we return NULL and just unlock bdev->bd_holder_lock.
- *
- * The function must be called with bdev->bd_holder_lock and releases it.
- */
-static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
-	__releases(&bdev->bd_holder_lock)
+static int fs_super_freeze(struct super_block *sb)
 {
-	struct super_block *sb = bdev->bd_holder;
-	bool locked;
-
-	lockdep_assert_held(&bdev->bd_holder_lock);
-	lockdep_assert_not_held(&sb->s_umount);
-	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
-
-	/* Make sure sb doesn't go away from under us */
-	refcount_inc(&sb->s_passive);
-
-	mutex_unlock(&bdev->bd_holder_lock);
-
-	locked = super_lock(sb, excl);
-
-	/*
-	 * If the superblock wasn't already SB_DYING then we hold
-	 * s_umount and can safely drop our temporary reference.
-         */
-	put_super(sb);
-
-	if (!locked)
-		return NULL;
-
-	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
-		super_unlock(sb, excl);
-		return NULL;
-	}
+	if (sb->s_op->freeze_super)
+		return sb->s_op->freeze_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+	return freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+}
 
-	return sb;
+static int fs_super_thaw(struct super_block *sb)
+{
+	if (sb->s_op->thaw_super)
+		return sb->s_op->thaw_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+	return thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 }
 
 static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
-	struct super_block *sb;
+	struct super_dev *sb_dev;
+	dev_t dev = bdev->bd_dev;
 
-	sb = bdev_super_lock(bdev, false);
-	if (!sb)
-		return;
+	mutex_unlock(&bdev->bd_holder_lock);
 
-	if (sb->s_op->remove_bdev) {
-		int ret;
+	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
+		struct super_block *sb = sb_dev->sd_sb;
 
-		ret = sb->s_op->remove_bdev(sb, bdev);
-		if (!ret) {
-			super_unlock_shared(sb);
-			return;
+		if (!super_lock_shared(sb))
+			continue;
+		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
+			if (!sb->s_op->remove_bdev ||
+			    sb->s_op->remove_bdev(sb, bdev)) {
+				if (!surprise)
+					sync_filesystem(sb);
+				shrink_dcache_sb(sb);
+				evict_inodes(sb);
+				if (sb->s_op->shutdown)
+					sb->s_op->shutdown(sb);
+			}
 		}
-		/* Fallback to shutdown. */
+		super_unlock_shared(sb);
 	}
-
-	if (!surprise)
-		sync_filesystem(sb);
-	shrink_dcache_sb(sb);
-	evict_inodes(sb);
-	if (sb->s_op->shutdown)
-		sb->s_op->shutdown(sb);
-
-	super_unlock_shared(sb);
 }
 
 static void fs_bdev_sync(struct block_device *bdev)
 {
-	struct super_block *sb;
-
-	sb = bdev_super_lock(bdev, false);
-	if (!sb)
-		return;
+	struct super_dev *sb_dev;
+	dev_t dev = bdev->bd_dev;
 
-	sync_filesystem(sb);
-	super_unlock_shared(sb);
-}
+	mutex_unlock(&bdev->bd_holder_lock);
 
-static struct super_block *get_bdev_super(struct block_device *bdev)
-{
-	bool active = false;
-	struct super_block *sb;
+	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
+		struct super_block *sb = sb_dev->sd_sb;
 
-	sb = bdev_super_lock(bdev, true);
-	if (sb) {
-		active = atomic_inc_not_zero(&sb->s_active);
-		super_unlock_excl(sb);
+		if (!super_lock_shared(sb))
+			continue;
+		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
+			sync_filesystem(sb);
+		super_unlock_shared(sb);
 	}
-	if (!active)
-		return NULL;
-	return sb;
 }
 
 /**
- * fs_bdev_freeze - freeze owning filesystem of block device
+ * fs_bdev_freeze - freeze every superblock using a block device
  * @bdev: block device
  *
- * Freeze the filesystem that owns this block device if it is still
- * active.
- *
- * A filesystem that owns multiple block devices may be frozen from each
- * block device and won't be unfrozen until all block devices are
- * unfrozen. Each block device can only freeze the filesystem once as we
- * nest freezes for block devices in the block layer.
+ * Freeze each live superblock using @bdev.  A superblock owning several block
+ * devices is frozen once per device and stays frozen until all are thawed; the
+ * block layer nests these freezes so the count stays balanced.
  *
- * Return: If the freeze was successful zero is returned. If the freeze
- *         failed a negative error code is returned.
+ * Return: 0, or the first error from freezing a superblock or syncing the
+ *         block device.
  */
 static int fs_bdev_freeze(struct block_device *bdev)
 {
-	struct super_block *sb;
-	int error = 0;
+	dev_t dev = bdev->bd_dev;
+	struct super_dev *sb_dev;
+	int error = 0, err;
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
 
-	sb = get_bdev_super(bdev);
-	if (!sb)
-		return -EINVAL;
+	mutex_unlock(&bdev->bd_holder_lock);
+
+	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
+		if (!get_active_super(sb_dev->sd_sb))
+			continue;
+		err = fs_super_freeze(sb_dev->sd_sb);
+		if (err && !error)
+			error = err;
+		deactivate_super(sb_dev->sd_sb);
+	}
 
-	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	else
-		error = freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 	if (!error)
 		error = sync_blockdev(bdev);
-	deactivate_super(sb);
 	return error;
 }
 
 /**
- * fs_bdev_thaw - thaw owning filesystem of block device
+ * fs_bdev_thaw - thaw every superblock using a block device
  * @bdev: block device
  *
- * Thaw the filesystem that owns this block device.
+ * The counterpart to fs_bdev_freeze(): thaw each live superblock using @bdev.
+ * A zero return does not imply a superblock is fully unfrozen; it may have been
+ * frozen more than once (by the kernel or via another device).
  *
- * A filesystem that owns multiple block devices may be frozen from each
- * block device and won't be unfrozen until all block devices are
- * unfrozen. Each block device can only freeze the filesystem once as we
- * nest freezes for block devices in the block layer.
- *
- * Return: If the thaw was successful zero is returned. If the thaw
- *         failed a negative error code is returned. If this function
- *         returns zero it doesn't mean that the filesystem is unfrozen
- *         as it may have been frozen multiple times (kernel may hold a
- *         freeze or might be frozen from other block devices).
+ * Return: 0, or the first error from thawing a superblock.
  */
 static int fs_bdev_thaw(struct block_device *bdev)
 {
-	struct super_block *sb;
-	int error;
+	dev_t dev = bdev->bd_dev;
+	struct super_dev *sb_dev;
+	int error = 0, err;
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
 
-	/*
-	 * The block device may have been frozen before it was claimed by a
-	 * filesystem. Concurrently another process might try to mount that
-	 * frozen block device and has temporarily claimed the block device for
-	 * that purpose causing a concurrent fs_bdev_thaw() to end up here. The
-	 * mounter is already about to abort mounting because they still saw an
-	 * elevanted bdev->bd_fsfreeze_count so get_bdev_super() will return
-	 * NULL in that case.
-	 */
-	sb = get_bdev_super(bdev);
-	if (!sb)
-		return -EINVAL;
+	mutex_unlock(&bdev->bd_holder_lock);
+
+	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
+		if (!get_active_super(sb_dev->sd_sb))
+			continue;
+		err = fs_super_thaw(sb_dev->sd_sb);
+		if (err && !error)
+			error = err;
+		deactivate_super(sb_dev->sd_sb);
+	}
 
-	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	else
-		error = thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	deactivate_super(sb);
 	return error;
 }
 
@@ -1752,14 +1734,18 @@ struct file *fs_bdev_file_open_by_path(const char *path, blk_mode_t mode,
 EXPORT_SYMBOL_GPL(fs_bdev_file_open_by_path);
 
 /**
- * fs_bdev_file_release - release a block device claimed for a superblock
+ * fs_bdev_unregister - drop a superblock's claim on a block device
  * @bdev_file: file returned by fs_bdev_file_open_by_{dev,path}()
  * @sb: superblock the device was claimed for
  *
- * Drop one claim on the {dev, @sb} entry; the last claim unregisters it (a
- * pinning cursor defers the actual unlink).  Then close the block device.
+ * The inverse of fs_bdev_register(): drop one claim on the {dev, @sb} entry
+ * (the last claim unregisters it; a pinning cursor defers the actual unlink)
+ * without closing the device.  A caller that must act on the still-open device
+ * between unregistering and closing - e.g. re-allow freezing one denied for a
+ * membership change - pairs this with bdev_fput().  fs_bdev_file_release() is
+ * the common unregister-and-close.
  */
-void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb)
+void fs_bdev_unregister(struct file *bdev_file, struct super_block *sb)
 {
 	dev_t dev = file_bdev(bdev_file)->bd_dev;
 	struct super_dev *sb_dev;
@@ -1768,6 +1754,19 @@ void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb)
 	sb_dev = super_dev_lookup(dev, sb);
 	rcu_read_unlock();
 	super_dev_put(sb_dev);
+}
+EXPORT_SYMBOL_GPL(fs_bdev_unregister);
+
+/**
+ * fs_bdev_file_release - release a block device claimed for a superblock
+ * @bdev_file: file returned by fs_bdev_file_open_by_{dev,path}()
+ * @sb: superblock the device was claimed for
+ *
+ * Unregister the {dev, @sb} entry, then close the block device.
+ */
+void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb)
+{
+	fs_bdev_unregister(bdev_file, sb);
 	bdev_fput(bdev_file);
 }
 EXPORT_SYMBOL_GPL(fs_bdev_file_release);
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index 721d842e3b24..8c3987040ed1 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -240,6 +240,7 @@ struct file *fs_bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				      struct super_block *sb);
 struct file *fs_bdev_file_open_by_path(const char *path, blk_mode_t mode,
 				       void *holder, struct super_block *sb);
+void fs_bdev_unregister(struct file *bdev_file, struct super_block *sb);
 void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb);
 
 #endif /* _LINUX_FS_SUPER_H */

-- 
2.47.3


