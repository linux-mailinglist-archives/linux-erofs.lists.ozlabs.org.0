Return-Path: <linux-erofs+bounces-3636-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXzSG/RYMWrghQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3636-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:08:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C66903EE
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M5Ulyvr3;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3636-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3636-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpkT4JcMz3c4P;
	Wed, 17 Jun 2026 00:08:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618929;
	cv=none; b=nCpoXqsM20LPPYNEKVEi4kGkclxZIuN3hybwB1EV4HgvbAl5ZIO7PHJsDJ8LnGGm6729lA1CcV5EYNkTznqhmzp4FhLVgGVO1/1rcBUmggV+oyUMMh1Kabx+28T6MVwF1/5eAXlxEbM/kvVaM+tGCqUOUSHUapyO9WGjmYzVd7Z5f1HX5Z5mf9/Ke/lBaIWBnFmlRPqUsouxIlp0vKoqBdVfO4y1v1pto6p3St7Hk95lJRZIZuF+UD3LwsC/UgeXMUxGkYTtSrgKkEAjyeM9ETtIIHU4I9VkarGBu/49GvzhdHgdFQ71GcLDveydBEvES8ltpg3l+N4J/NRJJsh+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618929; c=relaxed/relaxed;
	bh=WjwR9vH2WMcKI4lWeyLWZRoEHjyG3qd8eI9XdYYTssg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNRy0BOZyaYgtidoVotBfAMmTlq9/kck9ePGr1LGIk829sjTVRsjZSELtJepkcBGWvO4xI6zeZIKYuMZ7LqWTCYDs26/VDwHrRb7Cj8Wvz4qnjej/zXetRrMHVxMnOUnp+7Ec1m80+Z8gOgb4gQS3X4vob55RyTUaETGPu0x/UpCZebe5H2+0U2KQsEFfOSi03/GWz7IWm+aiQ++L0InrdRNJ4hAbt5FqUwSS1K2GiSG+1jKDzRHtu+Kt1VybU2kCRv9YUnqNVqOj5OS9e+QDTJ5lQNfU5sA1glCtjkWNEJJ9t8e3BaMcVpBmVeOnrjUJlSHHgQfB4EPD9dMS6Cosg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5Ulyvr3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpkS53Xfz3c3v
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:08:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9470409D8;
	Tue, 16 Jun 2026 14:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6791F00AC4;
	Tue, 16 Jun 2026 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618926;
	bh=WjwR9vH2WMcKI4lWeyLWZRoEHjyG3qd8eI9XdYYTssg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M5Ulyvr3daRP5zh6cUjMPi43jyuPuURwEOEBaRzTHiwelTGy8K2bTfBE0TK6fY9J1
	 oWddHvGy4bkAg7UgN1bR3hLuGNEg8zCMs1zz+jZ6n/jZkEBScIyvoJMBqPd8557EfY
	 67hi6jiK8fRG72FT6OYFCApiEkJi2NfI28GNq0VPn2rD6mQhb4OFIhyZ7zEhSjm3m9
	 HTVjEJySwhBKTqrABFIE6IB1LpP92V3mvf/OF0OvzaZdoTgk5EDhYw6LQoqCWSCL+I
	 JQYEz+RJt0819L4/hDh3W3sSg9nWrg9l9hp6xaF4ad5qRgCKBL1KWYF7DkyROTuV67
	 s6ueMsJwUVBYA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:19 +0200
Subject: [PATCH RFC v2 03/18] super: take lock after last reference count
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-3-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4988; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KF0v8pHPVEotJs4Vm14KV+E8jIKihwjzaTF127NKnwI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtw7Jz+vQe2eqESxmfqUV2y+rd/CI/wftyRMiHNf9
 1ttUWhjRwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES4pBm+F0awyQaUuy171exY
 n2I2z+xP49fS6+Z+GYV5hl+5Hh1m+F9vYrSkxc9+ySQv0YM1a4zTj1rHnxQNfcY7o3eJlo+JCBs A
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
	TAGGED_FROM(0.00)[bounces-3636-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: C56C66903EE

__put_super() required the caller to hold sb_lock, so put_super()
wrapped it. The per-device superblock table introduced later drops its
passive references from contexts that do not hold sb_lock, so make
put_super() self-locking: drop the count first and take sb_lock only for
the final list_del.

With the count now dropped outside sb_lock a superblock can briefly sit
on @super_blocks with s_passive == 0 before it is unlinked, so the list
walkers (__iterate_supers(), iterate_supers_type(), user_get_super())
switch to refcount_inc_not_zero() and skip it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 63 ++++++++++++++++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 25dd72b550e0..a771a0ad4c9a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -403,12 +403,17 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 /* Superblock refcounting  */
 
 /*
- * Drop a superblock's refcount.  The caller must hold sb_lock.
+ * Drop a superblock's passive reference.  Must be called WITHOUT sb_lock held;
+ * put_super() acquires sb_lock itself when the final reference is dropped.
  */
-static void __put_super(struct super_block *s)
+void put_super(struct super_block *s)
 {
 	if (refcount_dec_and_test(&s->s_passive)) {
+
+		spin_lock(&sb_lock);
 		list_del_init(&s->s_list);
+		spin_unlock(&sb_lock);
+
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(s->s_mounts);
@@ -416,20 +421,6 @@ static void __put_super(struct super_block *s)
 	}
 }
 
-/**
- *	put_super	-	drop a temporary reference to superblock
- *	@sb: superblock in question
- *
- *	Drops a temporary reference, frees superblock if there's no
- *	references left.
- */
-void put_super(struct super_block *sb)
-{
-	spin_lock(&sb_lock);
-	__put_super(sb);
-	spin_unlock(&sb_lock);
-}
-
 static void kill_super_notify(struct super_block *sb)
 {
 	lockdep_assert_not_held(&sb->s_umount);
@@ -478,11 +469,7 @@ void deactivate_locked_super(struct super_block *s)
 
 		kill_super_notify(s);
 
-		/*
-		 * Since list_lru_destroy() may sleep, we cannot call it from
-		 * put_super(), where we hold the sb_lock. Therefore we destroy
-		 * the lru lists right now.
-		 */
+		/* list_lru_destroy() may sleep; put_super() callers may not. */
 		list_lru_destroy(&s->s_dentry_lru);
 		list_lru_destroy(&s->s_inode_lru);
 
@@ -851,14 +838,17 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 	struct super_block *sb, *p = NULL;
 	bool excl = flags & SUPER_ITER_EXCL;
 
-	guard(spinlock)(&sb_lock);
+	spin_lock(&sb_lock);
 
 	for (sb = first_super(flags);
 	     !list_entry_is_head(sb, &super_blocks, s_list);
 	     sb = next_super(sb, flags)) {
 		if (super_flags(sb, SB_DYING))
 			continue;
-		refcount_inc(&sb->s_passive);
+
+		if (!refcount_inc_not_zero(&sb->s_passive))
+			continue;
+
 		spin_unlock(&sb_lock);
 
 		if (flags & SUPER_ITER_UNLOCKED) {
@@ -868,13 +858,14 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 			super_unlock(sb, excl);
 		}
 
-		spin_lock(&sb_lock);
 		if (p)
-			__put_super(p);
+			put_super(p);
 		p = sb;
+		spin_lock(&sb_lock);
 	}
+	spin_unlock(&sb_lock);
 	if (p)
-		__put_super(p);
+		put_super(p);
 }
 
 void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
@@ -903,7 +894,9 @@ void iterate_supers_type(struct file_system_type *type,
 		if (super_flags(sb, SB_DYING))
 			continue;
 
-		refcount_inc(&sb->s_passive);
+		if (!refcount_inc_not_zero(&sb->s_passive))
+			continue;
+
 		spin_unlock(&sb_lock);
 
 		locked = super_lock_shared(sb);
@@ -912,14 +905,14 @@ void iterate_supers_type(struct file_system_type *type,
 			super_unlock_shared(sb);
 		}
 
-		spin_lock(&sb_lock);
 		if (p)
-			__put_super(p);
+			put_super(p);
 		p = sb;
+		spin_lock(&sb_lock);
 	}
-	if (p)
-		__put_super(p);
 	spin_unlock(&sb_lock);
+	if (p)
+		put_super(p);
 }
 
 EXPORT_SYMBOL(iterate_supers_type);
@@ -935,15 +928,17 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 		if (sb->s_dev != dev)
 			continue;
 
-		refcount_inc(&sb->s_passive);
+		if (!refcount_inc_not_zero(&sb->s_passive))
+			continue;
+
 		spin_unlock(&sb_lock);
 
 		locked = super_lock(sb, excl);
 		if (locked)
 			return sb;
 
+		put_super(sb);
 		spin_lock(&sb_lock);
-		__put_super(sb);
 		break;
 	}
 	spin_unlock(&sb_lock);
@@ -1368,9 +1363,7 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
 	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
 
 	/* Make sure sb doesn't go away from under us */
-	spin_lock(&sb_lock);
 	refcount_inc(&sb->s_passive);
-	spin_unlock(&sb_lock);
 
 	mutex_unlock(&bdev->bd_holder_lock);
 

-- 
2.47.3


