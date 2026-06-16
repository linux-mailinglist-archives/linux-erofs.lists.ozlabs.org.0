Return-Path: <linux-erofs+bounces-3651-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FYnqESpZMWoShgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3651-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:46 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFF690446
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fGv1SWC6;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3651-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3651-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplW3fdlz3c4l;
	Wed, 17 Jun 2026 00:09:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618983;
	cv=none; b=o3FHsfQ3Vob2M9JzDEQakgNjr6EsoFBsiZuC/XStLdpi1pxT9ht07JJ3n4cTf9Vdq+StHnYgJ5CH8oBpG9cSknlLNCYGX+mjc8rwZlZEJ0wL8tewRw8T73S7fg2j0OE85QlM9MYVSF0fyeqIOiexPDwTBJz9kjG1jcOguBXUYderHTKzfUHQR4ynw+aWDwVbSbPl9fNcoEknPrhOVG4DHSagW6NZ/8v63MiyHEkuGjFm50AB3iA249egMHQlfH43s8yv/3OY8c5zAZW/Iqr65f0JmSzD4rmrtZboNgjXUOGQEa4XiNLnzFsjDf4VrWc8TFz68ivBPcn2S1b/xJ2Wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618983; c=relaxed/relaxed;
	bh=rRMc9kMufhtL5v6eg77W3bJ5eLcFDC/5FLFQgRBwgUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajZFlLLKcy+ZvtZ/+mq0T+0W1ck+oJsfdyo8/xhb/zdxjtY8dgqazjJyXvs6qPQ4biiOMZTOS4t7AYBe5SjU1MKwGmv+mjKq6p3rzcL+GthWmdSqHwGMdf8bSratKAKverOt7b6WxvwgqRGFHtXmos4jwlIq3lfQTYsJMEcSGvJODBr3nfGW0rZ6d3Mn2SFw3GLoWAfnEqg1iV/StBB3SugjCmG3L0B+rNDnJqbgg+xEmLXEOVTe4t+2BIk3CNhifqc5HAErkQSXVWhb3GUUwhwowfUenPOEh0uYd236mUHXj0qClz33iH92tdrZUt0R8xI0DB58N494QoVtkZphDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGv1SWC6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplV4Xp7z2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DFDE74322A;
	Tue, 16 Jun 2026 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDB11F000E9;
	Tue, 16 Jun 2026 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618979;
	bh=rRMc9kMufhtL5v6eg77W3bJ5eLcFDC/5FLFQgRBwgUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fGv1SWC6fLifdCoGjEb6SbAJe65q/UaRIrA50zk5LlsWkOyH6SSrYS9935kLj3fxJ
	 waRRSXfPj4o4aqawZav1zjhouAaabY0b+APeY3yyL/nHbb3Ul0qYiZUvo2X6+y4AWG
	 qI+5mSwNTdG1AsQvul/ds2mgHaHr8ZAfPCvpXaJBCnLxcrheWDhZB0CNx8PXfVIqUP
	 b45Bugt4XIyBtZKyEnmt7ZLlJIT7cU07X6nEAMkcAYxE0RRWCQ3180uppikYxDuA6A
	 VG6Jw6Rd/c2IK2c/PSP7mnU93etJ9AjGbGiIMtIoERDyv4mFjzZ+CPLbyzivUbkONs
	 YrOKlwiW8iK/A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:33 +0200
Subject: [PATCH RFC v2 17/18] fs: look up the superblock via the device
 table in user_get_super()
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-17-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3616; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9HmtDEDStqmbZmIMCUWgddWqXAIThv58DpWYSnfHEN8=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGoxWN+g2BMFfjjyx0eEgKp8uxwbtpLCXZ1u++jmYieteacES
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmoxWN8ACgkQkcYbwGV43KKB9gEApvkp
 dtTqpOq8kInsSwhVrk/cmhKt1ogA/Y6whKasJtYBAN3/I0SnAfnUmjGkBjhaY+GrRiNnPZgQ+sC
 FYmb5s2oE
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
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
	TAGGED_FROM(0.00)[bounces-3651-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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
X-Rspamd-Queue-Id: 9DCFF690446

user_get_super() still finds the superblock for a device number by
walking the global super_blocks list under sb_lock. Every superblock is
registered in the device table under its s_dev since sget_fc() inserts
it there, including superblocks on anonymous devices, so use the table
instead.

The refcount-pinning cursor helpers super_dev_{get,first,next}() only
touch table state and do not depend on CONFIG_BLOCK, so drop the
CONFIG_BLOCK guard around them: their new caller serves anonymous
devices as well (ustat() on e.g. tmpfs) and is built without
CONFIG_BLOCK. The guard falls in this patch rather than separately
since without this caller the helpers would be unused without
CONFIG_BLOCK.

The pinned entry holds a passive reference on the superblock so
super_lock() can be called directly; once the superblock is locked grab
a passive reference for the caller before dropping the pin.

The device table contains more than the old walk could find: a
superblock is also registered for every additional device it claims
(the xfs log and realtime devices, btrfs member devices, the ext4
external journal, erofs blob devices). Don't filter those out:
specifying any device a filesystem uses now resolves to that
filesystem, so ustat() and quotactl() work on e.g. the xfs log device
or a btrfs member device (the latter used to fail outright as btrfs
superblocks carry an anonymous s_dev that never matches a member
device). When several superblocks share a device (erofs blob devices)
the first live superblock wins.

The cursor also keeps scanning past dying superblocks where the old
walk gave up after the first s_dev match, so a mount racing with the
unmount of the same device (or with the reuse of a recycled anonymous
dev_t) finds the live superblock where the old walk could spuriously
return NULL.

This removes the last s_dev-keyed walk of the super_blocks list and
takes ustat() and quotactl()'s block device lookup off sb_lock
entirely.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 2d0a07861bfc..93f24aea75c4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -501,7 +501,6 @@ static int super_dev_register(struct super_block *sb)
 	return err;
 }
 
-#ifdef CONFIG_BLOCK
 static struct super_dev *super_dev_get(struct rhlist_head *pos)
 {
 	struct super_dev *sb_dev;
@@ -535,7 +534,6 @@ static struct super_dev *super_dev_next(struct super_dev *prev)
 	super_dev_put(prev);
 	return sb_dev;
 }
-#endif
 
 static void kill_super_notify(struct super_block *sb)
 {
@@ -1044,29 +1042,19 @@ EXPORT_SYMBOL(iterate_supers_type);
 
 struct super_block *user_get_super(dev_t dev, bool excl)
 {
-	struct super_block *sb;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		bool locked;
+	struct super_dev *sb_dev;
 
-		if (sb->s_dev != dev)
-			continue;
+	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
+		struct super_block *sb = sb_dev->sd_sb;
 
-		if (!refcount_inc_not_zero(&sb->s_passive))
+		if (!super_lock(sb, excl))
 			continue;
 
-		spin_unlock(&sb_lock);
-
-		locked = super_lock(sb, excl);
-		if (locked)
-			return sb;
-
-		put_super(sb);
-		spin_lock(&sb_lock);
-		break;
+		/* The pinned entry holds a passive reference, take our own. */
+		refcount_inc(&sb->s_passive);
+		super_dev_put(sb_dev);
+		return sb;
 	}
-	spin_unlock(&sb_lock);
 	return NULL;
 }
 

-- 
2.47.3


