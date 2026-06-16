Return-Path: <linux-erofs+bounces-3650-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ks+ByZZMWoMhgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3650-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844569043E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QNk8Pde8;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3650-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3650-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplR0nHNz3c52;
	Wed, 17 Jun 2026 00:09:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618979;
	cv=none; b=JoCe7y3KQmipSFwfmsS+Jsw/JaFAOyOXoikUxHvSMCHomvGL2dudVMq6CrOMj7P5uH19qNCJGVgyIr/JKbEnvj+fUbcYeOg/DJU8WvAtnvQ3pMH2hAzKHrjc/XB9sGLi1jxaO7kA4B2ywISLYV75Yj1oyr4YVEcppBhWQKRxOYk8+AQ/HIBc7B/qmRGPKFCDQONDzui5eP3KG4/YeAvKdot6SKmBm5HixTw1uni4X7drHMeNvts6I9KjplLYN+bwyCMIgaYvZp5yUsgutM9t3Ku7tmLHDl+d2INIyAvIQYuRxPQqKLfFytnoWYJnJRYq2P/BT9UeckLST/M2ACO7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618979; c=relaxed/relaxed;
	bh=aTcPWezXgQ5+ASGJFKrfJE2MFrpVhk3GuVEmxFiscQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXJJDMmhDxV2Vwd6Bd65fgi7zIHya44Wrtoi2Z4XxYdGFHuSccy5mJkNCE9kYIu0qmWQ+C7T6gL+EXUURUG5R708gjlDD1LZ4NODL7Vrk0EFpXNT99oBkGs2+w9kMLR4kHTQwTqHr2FFCntLbFX2yDXianxfrbpQoHP+sgb96KMtzO9cgSUR7VQ48GNi5TtgfKrbn7YNV5PLlDIL0/uqK9lWCBA1UpTq2a8Arzs5s/YSVM4gFHNwva8UVR/ZRRMGFedJAAQc3B+TGtr/zgbHM5W+6niJoHqq7fM0GDMwHcLMl8b1zPxMdoWm/xKDw3v2o5/paNv6/s5dfU8GW0EhEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk8Pde8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplQ1cfcz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B28643BF1;
	Tue, 16 Jun 2026 14:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD11F00AC4;
	Tue, 16 Jun 2026 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618976;
	bh=aTcPWezXgQ5+ASGJFKrfJE2MFrpVhk3GuVEmxFiscQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QNk8Pde81+c7bz69IC0LrqDsR1/mXDO52tE+dSEVlTe7lMbb7fhh8KvJfcB+mdK1j
	 L9uA2jfjMpAtXaozInTXS9WAaM48C4YFenMHIKmBY/UuV8up1sH9vRm1cUkjOUBup3
	 ptLH455DhZPnM+LFkkLkNYmUwDc34HwFOVfrQraizZbA0mjELJOz9p3h9r80RVVQwE
	 bEV3aQrkfYrOTN3UtEL+mbqgyUvD3+nFnltDkNASM1m/APM0sO/yJSNZk8W6I+RX3A
	 ib3/4f79FL0DxavjHTYT9JvAij/YnqJSmSNEdL276TmLIkLwbTaAa4ScF2oV0Qha7M
	 U1Dij6CJxoD0A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:32 +0200
Subject: [PATCH RFC v2 16/18] super: make fs_holder_ops private
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-16-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OtwyzN33qcp3Tprake7kNYtJqUhDTVNsJipaTKEubwM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtyXtw26x3kveDp/QJy3R8bk6qXGTds7JFa7tyat3
 +euxxjaUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBExb0aGU/ftebO63h2sKS7X
 uSzP5dE1eULVkapbrpaTd3mZ/b6iyPBPXcGu+N2X7Hsb/v/lOVoVFL9q1QJm7ynK+ttnmixKunW
 BDwA=
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3650-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4844569043E

Now that filesystems open and claim their block devices through
fs_bdev_file_open_by_{dev,path}(), nothing outside fs/super.c references
fs_holder_ops. Make it static and drop its declaration from blkdev.h.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c             | 3 +--
 include/linux/blkdev.h | 7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a83f58755cf8..2d0a07861bfc 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1624,13 +1624,12 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-const struct blk_holder_ops fs_holder_ops = {
+static const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
 };
-EXPORT_SYMBOL_GPL(fs_holder_ops);
 
 static struct super_dev *super_dev_lookup(dev_t dev, struct super_block *sb)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cee548184a7b..45225b4f7193 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1772,13 +1772,6 @@ struct blk_holder_ops {
 		__releases(&bdev->bd_holder_lock);
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

-- 
2.47.3


