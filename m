Return-Path: <linux-erofs+bounces-3647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lXXSMRpZMWr9hQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F29690421
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fCur5czk;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3647-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3647-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplC60VTz3c4Y;
	Wed, 17 Jun 2026 00:09:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618967;
	cv=none; b=LCpQZTTQTJ6lgYKagfzKKoqtYwm7tp3OkY2KF/gWDx0x4iDisY9wSkRn5XgFtnK2UxJm3yoYigGrKFc1ID/yScL2wZVLULr7sJkF0IDpuBc4t/yLh7zB23Xjf+6oWJoqYbdPatJqc9RgAC/9Gx5cKkodWdEEB+YjTlcT8XtQzLOW/eqwn/6fVnegCfUWu+tei/gN7whk8AB9ugqwPdq0ROtGqWeFZnTLFzJ3AjB2tdL2b7+KqieBpjj1431oO14AALW3EB32QTBwOylfCoIQcgM8m0kWqEQZc+Q1y5btBT9F1DM8G7fnu2fGPNWt67Fxjqw4X+KkhbQWhJ7lAQ7Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618967; c=relaxed/relaxed;
	bh=TAVWBMn/0AgwgnXw81P+LkKKHh8ejKGFmQpo5ju/AbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbGE1XVUtV6IXycHNku8PnCDdOtLtA70b7G+pruBYNNYDouJu+J94CjCjgaRyJfs4lgTm8Jr+7DWRFb+SyYHTHvJ01Kc6PRSPow/TvTaCuqzldw31h3QgJyG+yNmAec0hfpOb21Nc3DYHfYUnKgs19Cfk/laYR3QEVANePYkK3mFP4t+mj31YjdZ1QsBFiuT5x7CaWjIz0x7xuhRQbtjbrdbVG15KfwXrHZXh9kstjz6I75ZiS0Gc+BgY8tNttWfwQ70cBjxng2vS8Mvw2/xm7ulZD18mJY+2hJGsJu8aiECez86FdllcYgBbX9ryH3QkpJg3nKwjPnI8+ZZ14k9FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCur5czk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplB5ZQrz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B353343C93;
	Tue, 16 Jun 2026 14:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F451F00A3A;
	Tue, 16 Jun 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618964;
	bh=TAVWBMn/0AgwgnXw81P+LkKKHh8ejKGFmQpo5ju/AbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fCur5czkdS8GxjwXheJ4YcLF8SzC0Fe2x28Ag2om3TK1ymVVaIUggeDoUhhGmcsSB
	 oIHLRM+5XS3IiI/6HCufOvnTnkGUglCX1E3rgy9H9e670/tp2nsEZ/nVjttF7+yuBc
	 sfrF4Kv5XIoCj/hnh6b+3IiY3/jdWfE9vFJl3siQ6HB+6JRhAsiPfn0rdqYnbVTQDo
	 ekEOHBvPncIT+FzUVizMJ/zqAikfr3JmnbP1o+VUN5M/aqIq5O6l2mAp7mV/MiXv6L
	 CZ+JdO01TA+dHlOEC1DLea1pGMslfrOkPA0yQeF1o3YRtnxdfUlFhbyTbEeD8Y//0V
	 +aWnNO/RvaZ3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:29 +0200
Subject: [PATCH RFC v2 13/18] fs: tolerate per-superblock freeze errors on
 shared devices
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-13-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fe1mfAo4ng9tx0MNylpx9ggBk5p6FEGdbQMCTGJTVlU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtznFz6nuNvDtXTpC6NXkSFffb1fNseH3me7rbX/9
 87D/z+u6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIBzOG/+49OsFT5qUILnD0
 NiiaxK6dPOnFO913jco3jZT4xBdck2L4w/99TdwOH1/NEzot97cxczffnBdsXKsb12YgUfbi8TE
 3FgA=
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
	TAGGED_FROM(0.00)[bounces-3647-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 03F29690421

When several superblocks share a device, keep it frozen even if some of
them failed to freeze and swallow the error: rolling the others back
via thaw_super() can fail too, so neither is a clear win. A single
filesystem still reports its error, and a sync_blockdev() failure is
always reported. Thaw follows the same rule.

A device can only be shared once superblocks claim it with a common
exclusivity token, which erofs starts doing in the next patch; for
everyone else the loop visits exactly one superblock and the behavior
is unchanged.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 236e868209a4..a83f58755cf8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1548,13 +1548,15 @@ static void fs_bdev_sync(struct block_device *bdev)
  * devices is frozen once per device and stays frozen until all are thawed; the
  * block layer nests these freezes so the count stays balanced.
  *
- * Return: 0, or the first error from freezing a superblock or syncing the
- *         block device.
+ * Return: 0, or the error from the one superblock on a single-fs device.  When
+ *         several superblocks share @bdev a per-superblock failure is swallowed
+ *         (see below), but a sync_blockdev() failure is always reported.
  */
 static int fs_bdev_freeze(struct block_device *bdev)
 {
 	dev_t dev = bdev->bd_dev;
 	struct super_dev *sb_dev;
+	unsigned int count = 0;
 	int error = 0, err;
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
@@ -1568,8 +1570,17 @@ static int fs_bdev_freeze(struct block_device *bdev)
 		if (err && !error)
 			error = err;
 		deactivate_super(sb_dev->sd_sb);
+		count++;
 	}
 
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
 	return error;
@@ -1583,12 +1594,14 @@ static int fs_bdev_freeze(struct block_device *bdev)
  * A zero return does not imply a superblock is fully unfrozen; it may have been
  * frozen more than once (by the kernel or via another device).
  *
- * Return: 0, or the first error from thawing a superblock.
+ * Return: 0, or the first error on a single-fs device; a shared device swallows
+ *         per-superblock errors, as fs_bdev_freeze() does.
  */
 static int fs_bdev_thaw(struct block_device *bdev)
 {
 	dev_t dev = bdev->bd_dev;
 	struct super_dev *sb_dev;
+	unsigned int count = 0;
 	int error = 0, err;
 
 	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
@@ -1602,8 +1615,12 @@ static int fs_bdev_thaw(struct block_device *bdev)
 		if (err && !error)
 			error = err;
 		deactivate_super(sb_dev->sd_sb);
+		count++;
 	}
 
+	/* Shared device: swallow per-superblock errors, like fs_bdev_freeze(). */
+	if (error && count > 1)
+		error = 0;
 	return error;
 }
 

-- 
2.47.3


