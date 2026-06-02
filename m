Return-Path: <linux-erofs+bounces-3500-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKqBGBysHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3500-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADF462C3B6
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6612lJLz2ysb;
	Tue, 02 Jun 2026 20:10:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395033;
	cv=none; b=SdYKOX8e2BaXpbowdU+gShCMxc0s5yVrjAjaNYekMk5He5Ca2SgAjzfiNDtTvxI4EcWh1uSOmOtIo+uWyrcQgWh1uVOc6Wy99Z941BV5cQAfpCD3fFP4W7ii8wH+C0QqdTw1rOqqlmCSdtn85XrlNzSDMc4UBbEn/etaRpCcpfjRXrr580OQY1wZ3P+TO9K4/ZTNFE+3lSamQwbAkNvLTTGayprKegFqSOWhAWDL/OAWK9uaPEnluP6cWtu/69QwR3VR21hu+e0AX1DSoMnhkXV0xKwt6CgU7vp6fl25MtJqqvJMNrdpJ0FXPtJ5UB9wNvkEMooNZiW2tzZbe9FVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395033; c=relaxed/relaxed;
	bh=G3AZrfjKA/1cygwXgkK9tiTHubrtfF5j0AYVS7Y8tws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ck+nMDgXBwN++p8ejO3JdYhXTB8qem6L2+C6FC+/fYgocqiJ402VnrbZiS+E6ScWqZKUPciXS/O/lPwJKD8yNjzKkucML0YkPCsZXWzFwlSMgC2Nbd9V2CPwBF7HON/jtwz62RTqmLhBY39D+BQzV1LkuXMZQaLYmB6lJm4og65deIfmDCBylswXs75E5ys1S1oi6aeaBEodQbgPy7KXODIT34mXPjYLkVAFZWCt/emN4uY8phq5bRZr58mbwOtMSph0fQkPFofI3QqIXPljCNVwSE+aZBqG706g32rBkP8hgSJqxkWGA3i2xajnmImGYzGyrNJW9eLF0NO9PABFjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVZt3MZL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVZt3MZL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV65z0pSCz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D18EF40B4C;
	Tue,  2 Jun 2026 10:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F491F00893;
	Tue,  2 Jun 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395028;
	bh=G3AZrfjKA/1cygwXgkK9tiTHubrtfF5j0AYVS7Y8tws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dVZt3MZLgDNbSb846tpmPJili/RzE+FsyHAGY6dnXxpKsCmKIHKa0gBRaK9J6b5gD
	 xroBMbMpom2v+WALmANddzahvK1IpsXSlt5RxM+UAEdjLgI4gFG3GRmXlmO+9rHXKK
	 Kp7UAeZFypoz1UR1oDsi5Zh65E2qCXFuNe6yqjWtA/hjL+rM0zZouL71vwAKfDmNIR
	 OAUTpdWSXg0rlGDeoa/Jz6taGfmOwu4opJERymG8aSJmMvPWy+IqrKwUGWiWypuZov
	 wWO4znM86rH8JHAZzlTSH+ccMiIG9Z5/rM8Xdhm1hWf1ktxr+0NWsF6OcFuvCG253g
	 f34VluspHag3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:08 +0200
Subject: [PATCH RFC 2/8] fs: add a global device to super block hash table
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
Message-Id: <20260602-work-super-bdev_holder_global-v1-2-bb0fd82f3861@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20256; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MYpZz0B6HGCp0PliU5rmIIJhd2BihonSRtJLqed8TeA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreGws0xq7DQ/7fpxEQ9jn9Pk8jtBPidK5DbYvXt4Q
 MjmHPuMjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYvWD4Hx/sFBad8m3JnD4W
 cZ2l6rwaDX4KV36dtWQ3M7g/d5reK0aGy8WNjAWHqv/byRo9DW98cUPJ+0B0+KSZ8TkTNyZlx4n
 wAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7ADF462C3B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3500-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

fs_holder_ops recovers the owning superblock from bdev->bd_holder, which
forces the holder to be exactly one superblock and prevents several
superblocks from sharing one block device. That's what erofs is doing.

Introduce a global dev_t-keyed rhltable mapping each block device to the
superblock(s) using it. The holder argument becomes purely the block
layer's exclusivity token (a superblock, or a file_system_type for
shared devices) and is no longer needed by the fs specific callbacks.

Registration keeps one entry per (device, superblock). When a filesystem
claims a device it already uses (xfs with its log on the data device), no
second entry is added, so each superblock is acted on once.

Each table entry holds a passive reference (s_count) on its superblock,
so the struct stays valid for as long as the entry is reachable. The
callbacks look the device up in the table and act on every superblock
using it:

Unlinking an entry is deferred to the last unpin, so a cursor never
resumes from a removed node. After this it's possible to act on all
superblocks that share a given device.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c               | 430 +++++++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h   |   7 -
 include/linux/fs/super.h |   7 +
 3 files changed, 309 insertions(+), 135 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 378e81efe643..e0174d5819a0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/rhashtable.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
@@ -1411,186 +1412,234 @@ EXPORT_SYMBOL(sget_dev);
 
 #ifdef CONFIG_BLOCK
 /*
- * Lock the superblock that is holder of the bdev. Returns the superblock
- * pointer if we successfully locked the superblock and it is alive. Otherwise
- * we return NULL and just unlock bdev->bd_holder_lock.
- *
- * The function must be called with bdev->bd_holder_lock and releases it.
+ * Filesystems claim block devices through fs_bdev_file_open_by_{dev,path}(),
+ * which records a {dev_t -> super_block} entry in the global @fs_bdev_supers
+ * table.  The fs_holder_ops callbacks resolve a device event to the
+ * superblock(s) using that device by looking it up there rather than reading
+ * bdev->bd_holder, so several superblocks may share one block device -- the
+ * holder is then only the block layer's exclusivity token.
  */
-static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
-	__releases(&bdev->bd_holder_lock)
+struct fs_bdev_holder {
+	dev_t			dev;		/* @fs_bdev_supers key */
+	struct super_block	*sb;
+	refcount_t		fs_bdev_passive;	/* @fs_bdev_active>0 bias + cursor pins */
+	refcount_t		fs_bdev_active;		/* open claims for (dev, sb) */
+	struct rhlist_head	node;
+	struct rcu_head		rcu;
+};
+
+static struct rhltable fs_bdev_supers;
+static const struct rhashtable_params fs_bdev_params = {
+	.key_len	= sizeof(dev_t),
+	.key_offset	= offsetof(struct fs_bdev_holder, dev),
+	.head_offset	= offsetof(struct fs_bdev_holder, node),
+};
+
+static int __init fs_bdev_supers_init(void)
 {
-	struct super_block *sb = bdev->bd_holder;
-	bool locked;
+	if (rhltable_init(&fs_bdev_supers, &fs_bdev_params))
+		panic("VFS: Cannot initialise fs_bdev_supers\n");
+	return 0;
+}
+fs_initcall(fs_bdev_supers_init);
 
-	lockdep_assert_held(&bdev->bd_holder_lock);
-	lockdep_assert_not_held(&sb->s_umount);
-	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
+static void fs_bdev_holder_put(struct fs_bdev_holder *h)
+{
+	/* Unlink only once unpinned, so a cursor never resumes from a removed node. */
+	if (refcount_dec_and_test(&h->fs_bdev_passive)) {
+		rhltable_remove(&fs_bdev_supers, &h->node, fs_bdev_params);
+		put_super(h->sb);
+		kfree_rcu(h, rcu);
+	}
+}
 
-	/* Make sure sb doesn't go away from under us */
-	spin_lock(&sb_lock);
-	sb->s_count++;
-	spin_unlock(&sb_lock);
+/*
+ * Walk the superblocks sharing a block device the way __iterate_supers() walks
+ * super_blocks: fs_bdev_first()/fs_bdev_next() return each entry with its node
+ * pinned (refcount) so the chain link survives the RCU drop and the sleeping
+ * work the callbacks do between iterations; fs_bdev_next() also unpins the
+ * previous entry.  The entry's fs_bdev_passive ref keeps @h->sb valid; callers
+ * take s_active and/or super_lock_shared() as needed and skip dying superblocks.
+ * A shared per-entry list node can't replace this because mark_dead and sync
+ * are not mutually serialised.
+ */
+static struct fs_bdev_holder *fs_bdev_pin(struct rhlist_head *pos)
+{
+	struct fs_bdev_holder *h;
 
-	mutex_unlock(&bdev->bd_holder_lock);
+	/* Caller holds rcu_read_lock(). */
+	for (; pos; pos = rcu_dereference_all(pos->next)) {
+		h = container_of(pos, struct fs_bdev_holder, node);
+		if (refcount_inc_not_zero(&h->fs_bdev_passive))
+			return h;
+	}
+	return NULL;
+}
 
-	locked = super_lock(sb, excl);
+static struct fs_bdev_holder *fs_bdev_first(dev_t dev)
+{
+	struct fs_bdev_holder *h;
 
-	/*
-	 * If the superblock wasn't already SB_DYING then we hold
-	 * s_umount and can safely drop our temporary reference.
-         */
-	put_super(sb);
+	rcu_read_lock();
+	h = fs_bdev_pin(rhltable_lookup(&fs_bdev_supers, &dev, fs_bdev_params));
+	rcu_read_unlock();
+	return h;
+}
 
-	if (!locked)
-		return NULL;
+static struct fs_bdev_holder *fs_bdev_next(struct fs_bdev_holder *prev)
+{
+	struct fs_bdev_holder *h;
 
-	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
-		super_unlock(sb, excl);
-		return NULL;
-	}
+	rcu_read_lock();
+	h = fs_bdev_pin(rcu_dereference_all(prev->node.next));
+	rcu_read_unlock();
+
+	fs_bdev_holder_put(prev);
+	return h;
+}
 
-	return sb;
+static int fs_super_freeze(struct super_block *sb)
+{
+	if (sb->s_op->freeze_super)
+		return sb->s_op->freeze_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+	return freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+}
+
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
+	struct fs_bdev_holder *h;
+	dev_t dev = bdev->bd_dev;
 
-	sb = bdev_super_lock(bdev, false);
-	if (!sb)
-		return;
+	mutex_unlock(&bdev->bd_holder_lock);
 
-	if (sb->s_op->remove_bdev) {
-		int ret;
+	for (h = fs_bdev_first(dev); h; h = fs_bdev_next(h)) {
+		struct super_block *sb = h->sb;
 
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
+	struct fs_bdev_holder *h;
+	dev_t dev = bdev->bd_dev;
 
-	sb = bdev_super_lock(bdev, false);
-	if (!sb)
-		return;
+	mutex_unlock(&bdev->bd_holder_lock);
 
-	sync_filesystem(sb);
-	super_unlock_shared(sb);
-}
+	for (h = fs_bdev_first(dev); h; h = fs_bdev_next(h)) {
+		struct super_block *sb = h->sb;
 
-static struct super_block *get_bdev_super(struct block_device *bdev)
-{
-	bool active = false;
-	struct super_block *sb;
-
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
+ * Return: 0, or the error from the one superblock on a single-fs device.  When
+ *         several superblocks share @bdev a per-superblock failure is swallowed
+ *         (see below), but a sync_blockdev() failure is always reported.
  */
 static int fs_bdev_freeze(struct block_device *bdev)
 {
-	struct super_block *sb;
-	int error = 0;
+	dev_t dev = bdev->bd_dev;
+	struct fs_bdev_holder *h;
+	unsigned int count = 0;
+	int error = 0, err;
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
 
-	sb = get_bdev_super(bdev);
-	if (!sb)
-		return -EINVAL;
+	mutex_unlock(&bdev->bd_holder_lock);
 
-	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	else
-		error = freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+	for (h = fs_bdev_first(dev); h; h = fs_bdev_next(h)) {
+		if (!atomic_inc_not_zero(&h->sb->s_active))
+			continue;
+		err = fs_super_freeze(h->sb);
+		if (err && !error)
+			error = err;
+		deactivate_super(h->sb);
+		count++;
+	}
+
+	/*
+	 * When several superblocks share the device, keep it frozen even if some
+	 * of them failed to freeze and swallow the error: rolling the rest back
+	 * via thaw_super() can fail too, so neither is a clear win. A single
+	 * filesystem (count == 1) still reports its error.
+	 */
+	if (error && count > 1)
+		error = 0;
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
+ * Return: 0, or the first error on a single-fs device; a shared device swallows
+ *         per-superblock errors, as fs_bdev_freeze() does.
  */
 static int fs_bdev_thaw(struct block_device *bdev)
 {
-	struct super_block *sb;
-	int error;
+	dev_t dev = bdev->bd_dev;
+	struct fs_bdev_holder *h;
+	unsigned int count = 0;
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
 
-	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	else
-		error = thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	deactivate_super(sb);
+	for (h = fs_bdev_first(dev); h; h = fs_bdev_next(h)) {
+		if (!atomic_inc_not_zero(&h->sb->s_active))
+			continue;
+		err = fs_super_thaw(h->sb);
+		if (err && !error)
+			error = err;
+		deactivate_super(h->sb);
+		count++;
+	}
+
+	/* Shared device: swallow per-superblock errors, like fs_bdev_freeze(). */
+	if (error && count > 1)
+		error = 0;
 	return error;
 }
 
@@ -1602,6 +1651,131 @@ const struct blk_holder_ops fs_holder_ops = {
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
+static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
+{
+	dev_t dev = file_bdev(bdev_file)->bd_dev;
+	struct rhlist_head *list, *pos;
+	struct fs_bdev_holder *h;
+	int err;
+
+	/*
+	 * A superblock may claim one device more than once (xfs with its log on
+	 * the data device).  Keep a single entry per (device, superblock) and
+	 * count the claims in @fs_bdev_active; the entry lives until the last one
+	 * is released.
+	 */
+	scoped_guard(rcu) {
+		list = rhltable_lookup(&fs_bdev_supers, &dev, fs_bdev_params);
+		rhl_for_each_entry_rcu(h, pos, list, node)
+			if (h->sb == sb && refcount_inc_not_zero(&h->fs_bdev_active))
+				return 0;
+	}
+
+	h = kmalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+	h->dev = dev;
+	h->sb = sb;
+	refcount_set(&h->fs_bdev_passive, 1);
+	refcount_set(&h->fs_bdev_active, 1);
+
+	err = rhltable_insert(&fs_bdev_supers, &h->node, fs_bdev_params);
+	if (err) {
+		kfree(h);
+		return err;
+	}
+
+	/* The sb->s_count ref keeps @h->sb valid for as long as the entry exists. */
+	spin_lock(&sb_lock);
+	sb->s_count++;
+	spin_unlock(&sb_lock);
+
+	return 0;
+}
+
+/**
+ * fs_bdev_file_open_by_dev - claim a block device on behalf of a superblock
+ * @dev: block device number
+ * @mode: open mode
+ * @holder: block-layer exclusivity token (a superblock, or the file_system_type
+ *          when the device may be shared by several superblocks of that type)
+ * @sb: superblock to drive fs_holder_ops events for
+ *
+ * Open @dev with &fs_holder_ops and register that @sb uses it, so device
+ * removal/sync/freeze/thaw are propagated to @sb (and any other superblock
+ * sharing @dev).  Must be paired with fs_bdev_file_release().
+ *
+ * Return: an opened block-device file or an ERR_PTR().
+ */
+struct file *fs_bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				      struct super_block *sb)
+{
+	struct file *bdev_file;
+	int err;
+
+	bdev_file = bdev_file_open_by_dev(dev, mode, holder, &fs_holder_ops);
+	if (IS_ERR(bdev_file))
+		return bdev_file;
+
+	err = fs_bdev_register(bdev_file, sb);
+	if (err) {
+		bdev_fput(bdev_file);
+		return ERR_PTR(err);
+	}
+	return bdev_file;
+}
+EXPORT_SYMBOL_GPL(fs_bdev_file_open_by_dev);
+
+struct file *fs_bdev_file_open_by_path(const char *path, blk_mode_t mode,
+				       void *holder, struct super_block *sb)
+{
+	struct file *bdev_file;
+	int err;
+
+	bdev_file = bdev_file_open_by_path(path, mode, holder, &fs_holder_ops);
+	if (IS_ERR(bdev_file))
+		return bdev_file;
+
+	err = fs_bdev_register(bdev_file, sb);
+	if (err) {
+		bdev_fput(bdev_file);
+		return ERR_PTR(err);
+	}
+	return bdev_file;
+}
+EXPORT_SYMBOL_GPL(fs_bdev_file_open_by_path);
+
+/**
+ * fs_bdev_file_release - release a block device claimed for a superblock
+ * @bdev_file: file returned by fs_bdev_file_open_by_{dev,path}()
+ * @sb: superblock the device was claimed for
+ *
+ * Drop one claim on the {dev, @sb} entry; the last claim unregisters it (a
+ * pinning cursor defers the actual unlink).  Then close the block device.
+ */
+void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb)
+{
+	dev_t dev = file_bdev(bdev_file)->bd_dev;
+	struct fs_bdev_holder *h, *found = NULL;
+	struct rhlist_head *list, *pos;
+
+	rcu_read_lock();
+	list = rhltable_lookup(&fs_bdev_supers, &dev, fs_bdev_params);
+	rhl_for_each_entry_rcu(h, pos, list, node) {
+		if (h->sb != sb)
+			continue;
+		/* At most one entry per (dev, sb); the last claim drops the bias. */
+		if (refcount_dec_and_test(&h->fs_bdev_active))
+			found = h;
+		break;
+	}
+	rcu_read_unlock();
+	if (found)
+		fs_bdev_holder_put(found);
+	bdev_fput(bdev_file);
+}
+EXPORT_SYMBOL_GPL(fs_bdev_file_release);
+
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
@@ -1609,7 +1783,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	struct file *bdev_file;
 	struct block_device *bdev;
 
-	bdev_file = bdev_file_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	bdev_file = fs_bdev_file_open_by_dev(sb->s_dev, mode, sb, sb);
 	if (IS_ERR(bdev_file)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
@@ -1623,7 +1797,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		bdev_fput(bdev_file);
+		fs_bdev_file_release(bdev_file, sb);
 		return -EACCES;
 	}
 
@@ -1634,7 +1808,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		bdev_fput(bdev_file);
+		fs_bdev_file_release(bdev_file, sb);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
@@ -1725,7 +1899,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		bdev_fput(sb->s_bdev_file);
+		fs_bdev_file_release(sb->s_bdev_file, sb);
 	}
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c8494d64a69d..43d37c02febf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1760,13 +1760,6 @@ struct blk_holder_ops {
 	int (*thaw)(struct block_device *bdev);
 };
 
-/*
- * For filesystems using @fs_holder_ops, the @holder argument passed to
- * helpers used to open and claim block devices via
- * bd_prepare_to_claim() must point to a superblock.
- */
-extern const struct blk_holder_ops fs_holder_ops;
-
 /*
  * Return the correct open flags for blkdev_get_by_* for super block flags
  * as stored in sb->s_flags.
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index f21ffbb6dea5..721d842e3b24 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -235,4 +235,11 @@ int freeze_super(struct super_block *super, enum freeze_holder who,
 int thaw_super(struct super_block *super, enum freeze_holder who,
 	       const void *freeze_owner);
 
+struct file;
+struct file *fs_bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				      struct super_block *sb);
+struct file *fs_bdev_file_open_by_path(const char *path, blk_mode_t mode,
+				       void *holder, struct super_block *sb);
+void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb);
+
 #endif /* _LINUX_FS_SUPER_H */

-- 
2.47.3


