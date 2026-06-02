Return-Path: <linux-erofs+bounces-3499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD0JFRasHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43062C3A8
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV65v5CmBz2ybR;
	Tue, 02 Jun 2026 20:10:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395027;
	cv=none; b=jcXRH2EK0C1AQWpRshmih3ilC7TNaSBqIIS6ZpZv5HotXyFZKkypUuH6tZjFQdS+9L4DjRVkvqqPzSR1cSAX7kisXla5Q88rTqVrX9No4pr6k5edKxcQgWE0XR4XUYaooqmwzTkZ7YfXI4Xs52CBtWIgXHKKfVkbFfXjWyFMGW9g52oIHzEm6YbPam9w9yPxjB9qxigaWb2vc4y9WuCYshyRfvQSzf28kp7YBG3+JqE6tE54d2kIJOc3puKx1MCaqQfStbboDoBHCYJZMDsYHpoBblxIqDOZZyrxMR+q8N+wPPTiUIhKn360d5D6E4+x1cAM9Ofvv6hJlF74k5qFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395027; c=relaxed/relaxed;
	bh=QUhM5h4C1WnXSL2tEPYUniUgKT/hUDIJ/vXilp+tDFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHEKFhfvjoilb54hCaJAkrEE/rblENFuyJxDyRBYoQv5GUyWOX6mGegpEoaD8EGgL1DifPZ/dw+WphYa0o8mHifWwBSX6GbAwIjeqJlrSXLWWo1SAH57k31gnbDW5c03gLBx3V+w4miWzzjQYOOsCf5R1/xk9ELdIwsy8Ufo0CUfgazE5hC1iNBCXF6GusTpHMsfyY5ywYOD93lOLy09tzatxhtrrwXiOf4wC84XDWwYHJZbM0gG8DbJA5rnKiI8uX2BPtKUrAjh3jH3v6EUXr84+y64oS4gLf44p4lsrRXTzv5E6icbpPLriZRpfPzmesJ9aw2c1V96HCQNwZtOMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyfVmOmz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyfVmOmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV65t6SCdz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E4D5E601DE;
	Tue,  2 Jun 2026 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEB71F00898;
	Tue,  2 Jun 2026 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395024;
	bh=QUhM5h4C1WnXSL2tEPYUniUgKT/hUDIJ/vXilp+tDFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MyfVmOmzX7hd/4gWE9I1HAP/tDKLvZhsRpaF0AF23wvS4sNb3Xx0sJuwzDIkbfDaY
	 FsjPXGFT3LWBJ11nfCzL1IsgItbFt8v/ksAh9q4fYdWKCRAccQxAc4jxDSN2NkQn0K
	 eY38uDZhStmD6xXuv8afkp2SHzSXcsbad+Ke/JhlJXTO7XIsGDNYOKscFTgMpf5sg8
	 jIW2Bk3szsshYcD+t0Twms+Bqnsaau186Rw1A/ruY0DQDE8M20cf3PbYzb7WGuGxs+
	 w47n+mxCjsQSBAa0DZ11hagsIDAIEDnl7/4kcTCJ7YlAYbw9I1tyAav6MqFcLlx2aQ
	 X9caJzyyrZdAg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 02 Jun 2026 12:10:07 +0200
Subject: [PATCH RFC 1/8] fs, block: move blk_mode_t and fop_flags_t into
 <linux/types.h>
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
Message-Id: <20260602-work-super-bdev_holder_global-v1-1-bb0fd82f3861@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LHr7gBg6PtJCZf6/6mkuc3vnbKC5yndXujDfy0HTjfM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreGQ0tbvuCvNPbdnY7ncU9PyXVtSrr4UOXPnm57kl
 sqwU8b/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS6cHI8IFJyzT/iD9n3TUF
 yYePNC5UyCp2aSR8/9TYf9xL5drecIb/cbfU15913s30r980eIpVTc3qw1+uhF5de2BJ2qn/hsy
 TWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: BD43062C3A8
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
	TAGGED_FROM(0.00)[bounces-3499-lists,linux-erofs=lfdr.de];
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

blk_mode_t and fop_flags_t are both plain 'unsigned int __bitwise' flag
typedefs, exactly like the gfp_t, slab_flags_t and fmode_t that already
live in <linux/types.h>. Move them there so they are available
everywhere without having to drag in a subsystem header.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/blkdev.h | 2 --
 include/linux/fs.h     | 2 --
 include/linux/types.h  | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..c8494d64a69d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -126,8 +126,6 @@ struct blk_integrity {
 	unsigned char				pi_tuple_size;
 };
 
-typedef unsigned int __bitwise blk_mode_t;
-
 /* open for reading */
 #define BLK_OPEN_READ		((__force blk_mode_t)(1 << 0))
 /* open for writing */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..e9346be8470f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1921,8 +1921,6 @@ struct dir_context {
 struct io_uring_cmd;
 struct offset_ctx;
 
-typedef unsigned int __bitwise fop_flags_t;
-
 struct file_operations {
 	struct module *owner;
 	fop_flags_t fop_flags;
diff --git a/include/linux/types.h b/include/linux/types.h
index 608050dbca6a..ef026585420b 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -163,6 +163,8 @@ typedef u32 dma_addr_t;
 typedef unsigned int __bitwise gfp_t;
 typedef unsigned int __bitwise slab_flags_t;
 typedef unsigned int __bitwise fmode_t;
+typedef unsigned int __bitwise blk_mode_t;
+typedef unsigned int __bitwise fop_flags_t;
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 typedef u64 phys_addr_t;

-- 
2.47.3


