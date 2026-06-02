Return-Path: <linux-erofs+bounces-3502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC28DCGsHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FE62C3D6
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6663N91z2yrt;
	Tue, 02 Jun 2026 20:10:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395038;
	cv=none; b=e42XqPQkjAbkGDw0v2IJR8+In2VaoFmUgXGrnhH8h9vx8Kdhrc94nSJa5Zzo6e/efuoi28bOW0i0NaAq3AKj4amm5Of5QD2eMbNN1gJu3SCCZ+B3uydGLyn3FpU4TouONrTz00HCzkEi1Hpg7KjQIuQR3Mz2hmyampbiZj2j8MAPQjHAAmjavTCVPCSII+6VXRiInxJlOhNx/r0IOcqXsbU44Vt8cZEYlFc9XaKwDC4J5QfybEqeNPep5+FIarzRKwOLv9WrBoKv/+97l63xL22qv7RYqkfLZtKZ4vhxzyZ9KseTEGJ2GK2WCiQ//5qwUnXvYWFIHJY/rl3WTz7jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395038; c=relaxed/relaxed;
	bh=XXqlEVPtjTumz77I7tYirzGL781sufCUro38/y5OW94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+kt3Zklg1m6Q7pUggvigSQFfCGTT3RhWgQ+EVroNNXdYbceAxrT+7+Y3WEzpZa8QXjphe0y9HEwatrKy8JZWUQIFzxxIOZk/jPAWYjrRnG9GczQI0FD8Xa/hTEiayUC5sHs+GIX3OK93UdzZ2XEZAMc4ZOVG//mKLBab5+idAwElKBLNF0ufWOac3Mvw2DeTvxb7ucy/aFH3Ec0ifVPsd4h+9Rbi8+il+gJvHlRWWket3TjXP0RdDcZRB0MF13ATM9zu2M6ajEJ8vnLT32DNxa3WZTt2N1Gd11Lw1wJ7CfSB0qZ4lIfUJ05BjZfQ/0h/PrKYglGjUprMZx+qngPCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnrvYZ8d; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnrvYZ8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66556xVz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3770643A6E;
	Tue,  2 Jun 2026 10:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67D81F00899;
	Tue,  2 Jun 2026 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395036;
	bh=XXqlEVPtjTumz77I7tYirzGL781sufCUro38/y5OW94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OnrvYZ8d/uudw7IFCwY3+2vEoGJ6Xtsg+t6/CG6GZXH5Cu/a+UI4VZkLuLsPmmhZP
	 6o5H9c7TCjOLYfvJWyQ7hEbbRYWhw70BBhhbJBxs/ExyIWJJncxDblUbaMvr9CROs1
	 Q01KG/rktCCnGP4xLk9oyJmDMD/FzT6LnNGo4+3qUsfjVwdjmm5MoxFZWMFEp43MyO
	 rlhpI4KBhN99dHrUw9gwyCUO1vVnm9WmD+Y6lVT2Ywt2rozkoHb0kksHIyBNZrYRJz
	 jNM/tTxqaM7tEKooZLW4L4jKyDdvZTR2ZlGT9eWCl4b8VZrFS2uLTuPzv9ns5h4Bko
	 VhkPjNUBZqM9g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:10 +0200
Subject: [PATCH RFC 4/8] xfs: port to fs_bdev_file_open_by_path()
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
Message-Id: <20260602-work-super-bdev_holder_global-v1-4-bb0fd82f3861@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YYSwTQpvvqiN+ClwMHMKH84kTVWiiSstmufcfKS+DaQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreEwOvyid52jcmyz7OHVMQca/xYJfXfm1zK+KXT6R
 2bNEu2SjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkwmTAyLPDiey56bvmxsIsP
 RdS936y5+zyoeu3X1308nyyEdyZ9F2P4n5X2ceN6vpucR3JWXQmQ8lxn/toiWGMVx4I7C7qP8Cb
 P5wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7B3FE62C3D6
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
	TAGGED_FROM(0.00)[bounces-3502-lists,linux-erofs=lfdr.de];
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
is registered against mp->m_super, and convert the matching releases.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/xfs/xfs_buf.c   |  2 +-
 fs/xfs/xfs_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 580d40a5ee57..3d3b29edb156 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1601,7 +1601,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		bdev_fput(btp->bt_file);
+		fs_bdev_file_release(btp->bt_file, btp->bt_mount->m_super);
 	kfree(btp);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f8de44443e81..304667210695 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -400,8 +400,8 @@ xfs_blkdev_get(
 	blk_mode_t		mode;
 
 	mode = sb_open_mode(mp->m_super->s_flags);
-	*bdev_filep = bdev_file_open_by_path(name, mode,
-			mp->m_super, &fs_holder_ops);
+	*bdev_filep = fs_bdev_file_open_by_path(name, mode,
+			mp->m_super, mp->m_super);
 	if (IS_ERR(*bdev_filep)) {
 		error = PTR_ERR(*bdev_filep);
 		*bdev_filep = NULL;
@@ -526,7 +526,7 @@ xfs_open_devices(
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
 		if (logdev_file)
-			bdev_fput(logdev_file);
+			fs_bdev_file_release(logdev_file, mp->m_super);
 	}
 
 	return 0;
@@ -538,10 +538,10 @@ xfs_open_devices(
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
 	 if (rtdev_file)
-		bdev_fput(rtdev_file);
+		fs_bdev_file_release(rtdev_file, mp->m_super);
  out_close_logdev:
 	if (logdev_file)
-		bdev_fput(logdev_file);
+		fs_bdev_file_release(logdev_file, mp->m_super);
 	return error;
 }
 

-- 
2.47.3


