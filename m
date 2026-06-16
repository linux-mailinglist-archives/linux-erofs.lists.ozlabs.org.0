Return-Path: <linux-erofs+bounces-3649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRMfHyJZMWoKhgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE2690438
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HnW1KWUQ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3649-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3649-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplM2hDKz3c3l;
	Wed, 17 Jun 2026 00:09:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618975;
	cv=none; b=QtJNWFGM+CXedX5IFnS3juuGvUOqNiYWF9m6wtG7QVZoJOJ+G+mtuo/wZ2H870JsxilHDiCHrAK97JWXtfej18U1RfIPypOyBTXBZ+LH3jPFL1x4rhkEAOzH60SdEX+qJvEdixMhor7vYtOkaM5lrK1wY2el2kpYyZKtpkeNZFOnazC6smQwLrE3j/h0EB8l/T+sHv5f1AarrH5wSEznXubyy1ulB2g/hHFjW7kqAgSo7SK7RCJbTyWuTBv0qeAlF7B/zet5FLDDgHtsZC8Ya5HLqARG3wC0Nx4L/cusYb3N6l9oEy23ydDGyXKK8mMFkHA9jOJ2Xt4BlB83kHiuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618975; c=relaxed/relaxed;
	bh=ngVpVtPEsS0y60zyrn8nL8QUtzCpNBin4fW6U/edl+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUlyssQftAz4bG3ncCRdjVZgoxT3ICgs7ESEXP0jxGOKLvF2xsJwZD4FvJX5xpR8V7xQ7yTShzfiQ4a96uXDfoUJYgtcd1Rozopbp0FZ+78SzgqkPS3xcYQm2ojOB83poC865uiwK0ce6gvCVCbAqYO/z2vbmLgNR8Htfkq1oOMj9kFlQ9sc6I1e49KtmQMCtdVPgScfMXKnRu0zVVvdkHQHwsxqjxsbQCVQNuAt9RuNbJyVVfOeddK1WbN83tzLm1fenJsfz2KFJIe/C0tBzsr4cbUdF5cXVzbd6sbmoQ94Mh8z9aSVBIwGgxA86patbcRLu56rxQTOVsjpdQOOLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnW1KWUQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplL2PD0z2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D0A443F04;
	Tue, 16 Jun 2026 14:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53EA1F00A3A;
	Tue, 16 Jun 2026 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618972;
	bh=ngVpVtPEsS0y60zyrn8nL8QUtzCpNBin4fW6U/edl+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HnW1KWUQf0mwZMULdxGCVEyINvIM0n/EAbjzjk4r5vKicJTa9a6wgsxMfUd15cDwG
	 SUCvkBe0zx8qLEbgnBl9K3btqqf4NSVP1WugHxcCA+RDPDzo12493NIXcLj12RM4IL
	 58eikrgSTDZDOnAI3nTCugyzKEfF/ACaScFxEIxrdHScbplSAqcsjGwsSSZowaLYgz
	 w9m5atHtpdJkRx/0QCB9LyZLm32p4hYE1gGEoyA3FqVfuPSPxwDCWk+by+ZC/bFE72
	 u9kHGy0X62QjHPh50icDEjTdjjtXAl5blmedM6vcmo2Q9tJm27t7+n3j7SIuyXLwq8
	 EFUXUa3cm8lrQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:31 +0200
Subject: [PATCH RFC v2 15/18] f2fs: open via dedicated fs bdev helpers
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-15-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jAB6+pYQJ7UoWlRzj4R8GAy+N4Bl1gstiAnoaWWXXLY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtw/9H/bl3zWyMWvI16JSJumC+3sXzHNe/f9jxvvP
 rliY3jmcUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEVHYxMqzb4HmUZU3hwdUL
 kl5sNFaqF/iaGszn2G625JG3YIDY9sMMf8U/pp5oietV/l4odl3eqvBSv9Pv3SyK39WWerSx8KQ
 6sQEA
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
	TAGGED_FROM(0.00)[bounces-3649-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 95EE2690438

Route the extra device opens of a multi-device f2fs through
fs_bdev_file_open_by_path() so each device is registered against the
superblock, and convert the matching release in destroy_device_list()
to fs_bdev_file_release(). The first device aliases the main bdev file
opened by setup_bdev_super() and is already registered through it.

f2fs opened its extra devices without holder ops, so a freeze, sync, or
removal of one of them was never propagated to the superblock.
Registering them wires those events up: every device now freezes,
thaws, syncs, and shuts down the filesystem like the main device does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ccf806b676f5..49349262564f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1970,7 +1970,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			bdev_fput(FDEV(i).bdev_file);
+			fs_bdev_file_release(FDEV(i).bdev_file, sbi->sb);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4840,8 +4840,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 						SEGS_TO_BLKS(sbi,
 						FDEV(i).total_segments) - 1;
-				FDEV(i).bdev_file = bdev_file_open_by_path(
-					FDEV(i).path, mode, sbi->sb, NULL);
+				FDEV(i).bdev_file = fs_bdev_file_open_by_path(
+					FDEV(i).path, mode, sbi->sb, sbi->sb);
 			}
 		}
 		if (IS_ERR(FDEV(i).bdev_file))

-- 
2.47.3


