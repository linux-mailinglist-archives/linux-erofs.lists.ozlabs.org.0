Return-Path: <linux-erofs+bounces-3501-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELefIB6sHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3501-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EF62C3BF
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6632j9Lz2yb9;
	Tue, 02 Jun 2026 20:10:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395035;
	cv=none; b=f6+wuYAcB9FsiNeW2hfkJ5jmo76zp5Ql04A6Ckokm20Rm463GkCjCwVKGF/yuUKHQLHm3UXPjU9foYOW+IO/B/yIeAi2Qmt79VfC0qRDj+blb7CjjkckhmLBvhfYAs2NhvioDDvh0LwfQObUeTDHRdak/koJLtyViVwpcdUMDelV1ZVDFLmLKdt1knS89iWWIXNkOTwJJfLVzByUATpv1eaHH28VITlglXlEfKUXe/iVCvzkc38hzge+Y7V2niChUiT/2kvLwzA75sEC+uJxWO8hG3W79RCWrTajmzxz2mTQTLRTa26EL5ShImHJG8lT9uyXIlxTFkoxR0yHwaWurw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395035; c=relaxed/relaxed;
	bh=NK64pa3OIIduaAGDL2mfn4zWcijZV5LoX5Ft+Wnsf7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVLh+APWboN8/vVvq4LTTMpBmlz5/DluYcmTegCzWqUmJoPSsONsE8HOqd4tURG7CFuTbjktdvVIk4L9jPXG25e1LI4meITK2C2TcKi2WCE9alTKrGSlopY6gtafPLMkFG+M3l6E2LhKXpVS2nQt4NtltFExoS+OvMGY0WS1Fl8pn3w1w7oQnN4Tw8IEBIzq015T+PU5ny1D0tow3Kx6uWgQh7UdzcsvKZPIxuwaT9B+rcsTlw+BMufCk07f/SSPQLQytV0/apxdnpTlWzBfhTyVstzr2n6OCS7k6zZ/0myI3hQLxK9fmfpGFGEm2ncxDs/lBZtF9Qjvmrn/LEJZ5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp2K8pYF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp2K8pYF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV6623wkQz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A235E60138;
	Tue,  2 Jun 2026 10:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC3B1F00898;
	Tue,  2 Jun 2026 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395032;
	bh=NK64pa3OIIduaAGDL2mfn4zWcijZV5LoX5Ft+Wnsf7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kp2K8pYF9IK72GeyOkPwzo7GUvAWWaOEr21bmKOrIJEzmi41bqRKfVIKJ/lnf5TDz
	 vRtyo28Hguuoovis00BvGY3miPGttRBlQUlJgGPH5x+1jTAaO+dkVf7NC0xhqZbHqA
	 xwCM96IcndMPK8Hcj7KqTAx89q2N4tMbEgPHDS+j93lrC1bPERJdIGAWTVDb0YFHVQ
	 YTGkWCF6LjCsisbqOVqoNTZqBGTBcKV8c+Fsm2IzfjqcCnqlPI20ft85fimFKLRrIT
	 n9jaS31lrRaDdhC57KzUl2Hl7mEOa3JJav2W9Cdq0gY4MLx80rad67M8cbYD9l0wnJ
	 4CKNEtwuw8krA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:09 +0200
Subject: [PATCH RFC 3/8] fs: refuse to claim any frozen block device
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
Message-Id: <20260602-work-super-bdev_holder_global-v1-3-bb0fd82f3861@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xIWw97lxG+sc/8l9SC3RHLuViltxzsWW1ctwJfp2JrM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreEwus30kUP9ttJBxaMH5KyWR7OvFH771srmQUU3l
 7iBsYNnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUbzD8Dz/ef67iYaNnjD5T
 8b0z1YoV83MnWEdLFr6Y0WK47uSCUIb/YemVN96ZyjHXTuG6afanfnv4q5A5c3ffNNC9qHnUwPY
 QFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: D67EF62C3BF
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
	TAGGED_FROM(0.00)[bounces-3501-lists,linux-erofs=lfdr.de];
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

setup_bdev_super() already refuses to bring a filesystem up on a frozen
block device but only for the primary device. Now that filesystems claim
every device through fs_bdev_file_open_by_{dev,path}(), do that check
once in the registration helper so it covers all of them.

Drop the now-redundant check from setup_bdev_super().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index e0174d5819a0..cea743f699e4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1690,6 +1690,17 @@ static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
 	sb->s_count++;
 	spin_unlock(&sb_lock);
 
+	/*
+	 * Don't bring a filesystem up on a frozen device.  The entry is already
+	 * published, so a freeze either is seen here or finds it and waits in
+	 * super_lock() until this mount is born or (on -EBUSY) dies.  The mount
+	 * aborts, so the entry is torn down without rebalancing @fs_bdev_active.
+	 */
+	if (atomic_read(&file_bdev(bdev_file)->bd_fsfreeze_count) > 0) {
+		fs_bdev_holder_put(h);
+		return -EBUSY;
+	}
+
 	return 0;
 }
 
@@ -1801,16 +1812,6 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		return -EACCES;
 	}
 
-	/*
-	 * It is enough to check bdev was not frozen before we set
-	 * s_bdev as freezing will wait until SB_BORN is set.
-	 */
-	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
-		if (fc)
-			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		fs_bdev_file_release(bdev_file, sb);
-		return -EBUSY;
-	}
 	spin_lock(&sb_lock);
 	sb->s_bdev_file = bdev_file;
 	sb->s_bdev = bdev;

-- 
2.47.3


