Return-Path: <linux-erofs+bounces-3643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FcAhAQtZMWryhQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C9690411
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jxIgQkgg;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3643-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3643-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpkw17hQz3c4r;
	Wed, 17 Jun 2026 00:09:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618952;
	cv=none; b=mWASAyu0R4wNw5F47x9P1wxsInZxqHrxx6Y5YyTvrTTQnzzWJsYMn6dvO0PlNqd6SLkAx1W2mKdHUJRFfgNLZbowRYhq0YwGw9b3NhBPUCtv4ss6NE44GTzfyqkC5ogOfJwlR0RtF5mihs2U2NmoHKVvhZ86Z7rnqzZvsvpU4Zfa/O6ugADFmY/SxIlqEFbnitpGGtDJ/ZL2lL99WfaIS37+HqKcU0L4DKggpPm65RlDxKydPdyH+xuUVu7QG4C7IhGu34qS1Qelw2W1hINgficrpdLpVVImaektuIY7YrwS6MLM9gDS8APIkMKkxr3NAJJak/VSairMx7uMY5bQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618952; c=relaxed/relaxed;
	bh=yVqmR6yUhdFiz0D8/tPr4iSOtue0uElM7fSTRsojiXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5i8l5T/HcxYHCTPI7iNk7QZwrnF6tfHwL78VDNFe6VTziYWvOyDm5URrhgBhTjqRZdcXDLW7bEG8FjOx1gQkQm8fhRKHQgu7l3tvkQAcaLQ6YyT+VWoY9VcCTLW6+e5iLUi6j30OEwJHaIEo3IRCqpvjlhrAbYP5YqFctGoEVa4PkI8fWB/nNnlG05Hd2aJ1V7zRyAGmiztOZEdkhYqy7fn9XPQtq3r/zgxeq4xJY7mK6F7K2Z9S8nMyI2q1tfcPWZyd4DEFtEfVRhAfomwukRdH06PbTASCPQWlZhRHhGbNA8YUDj9r5bWiNsGGll3u2IB1OAuG5d+f3zOuqB3yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxIgQkgg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpkv2Sx9z2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79AD9600B0;
	Tue, 16 Jun 2026 14:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12061F000E9;
	Tue, 16 Jun 2026 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618949;
	bh=yVqmR6yUhdFiz0D8/tPr4iSOtue0uElM7fSTRsojiXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jxIgQkgg5i64Ryp1YKtKrVIZ5QwaaWo6uKEnw9b6Ri3Qp0U9UiFsRZHlA6lcaW9WM
	 TA3/e3+3pZBM9zzAQRVdfXnuZxhV7t53RNeXKTy+WfioIiivnozYwi/nJoBW47OVTT
	 vca0pXXi8TB75EnvDNTRfizeQrNmOgJAIecbyZlrVGv5SIu08v5pjELm0H2EfixNuG
	 hK+9icSWCRmx03A/1Qvz04/2zldQuz6NiuimqPJ2DYEJTIGGrGp/RxWA1mX+MnDRVZ
	 ozVdtJNaTH4oyS/y3IJsV4WKeNDorHhDDOLbJIsiCLgHUsdK1Y7uafSx3auLmxZ15X
	 hJuWv22jUjAkw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:25 +0200
Subject: [PATCH RFC v2 09/18] xfs: port to fs_bdev_file_open_by_path()
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-9-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rQISsay0vb1AxKcAUqf2E+n9KQH1UtKI/nxIAHlSVSU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtx7tyXm9bQFD76e972/ss813zsu7c6b+XvuvGa8+
 OLgz4CbAh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATUeBkZFhexX/J7xHPv0tc
 q97lTosLL/GZ6m3gPrns2osMi45k1g5GhsNafLvytjLfXr79yJQrRRnVFdVMIZ0mBz6ed536rtR
 2HRMA
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
	TAGGED_FROM(0.00)[bounces-3643-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 350C9690411

Route the log and rt device opens through fs_bdev_file_open_by_path() so
each external device is registered against mp->m_super, and convert the
matching releases to fs_bdev_file_release(). The data device is still
opened and released by setup_bdev_super()/kill_block_super(); when the
log lives on the data device the open resolves to the existing (dev, sb)
entry so the superblock is acted on once.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/xfs/xfs_buf.c   |  2 +-
 fs/xfs/xfs_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 3ce12fe1c307..2eddd60aaa67 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1615,7 +1615,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		bdev_fput(btp->bt_file);
+		fs_bdev_file_release(btp->bt_file, btp->bt_mount->m_super);
 	kfree(btp);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8531d526fc44..d1c622f0a957 100644
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
@@ -541,10 +541,10 @@ xfs_open_devices(
 	mp->m_ddev_targp = NULL;
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


