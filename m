Return-Path: <linux-erofs+bounces-3498-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCXtEBSsHmq3IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3498-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEE62C390
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Jun 2026 12:10:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV65s35jkz2xmX;
	Tue, 02 Jun 2026 20:10:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395025;
	cv=none; b=Qs0g39kOQtCrhQ/9sBxycZox81bOKb04CV6saYkHhOGbF52ag/u6Bl6cQFGq9vZpzoXVRs5h20vnlksRxPD5C+sqxVG9/lTnaJ7NNKdurZVBEJepIO5F5dUjQLgJwcsrRgr04ajs6gn7FbHyWLheHzof9pG1RlSNlgYfvD8z0/wCf7GUM+yXlhOETFphUklIhMS8l4D7xkwc0N9d/IrXUthR854HgMCGA4I8lU8yEKI0Uh10kSl6TfTm2SHkdDwZUk8X1fSiizvKum1uFtcPrksTE7lUSj1P2leA81QIFZtkEU/kS+020S7Lwfgva2BNI9rPKCk/wOaEGb199/KVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395025; c=relaxed/relaxed;
	bh=0sPLzsNzNrE5sYBDRc7UQyK3KG2m+vueA9urvjX/WEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=njYhm5/CLx+ZCbZS4pdayGajRFU8CREA7eqc00tQmYG7TNI6qFEAPYka8PmdzJK8MtiKMDJMlsYQvw2ZpDVEO60JUVdX3/IVPEaN81yVziMg6Uh5Cn3P0s8l7Eb13PPY6tH0UfR2oLS6MoV/dtDYyy/MmdZb0l+zsbgMP9GTExoBIWUMw+MIUmpM6LfNNtbuAd/BD+PvDwvnhAprahqD9+rJfawz6SAUu8H5sUle1PsdLUWwVi7ej7CfgvWnIaDypMuyQX+/9fiY+m2t7kXMnxrkNINQIM5VTRThjLaqMkka38pLNWrghcyqhgqfDhQ4w07X53ein5hk42N3Xazi0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4YSpK4f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4YSpK4f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV65r2gkjz2xdh
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A9F560141;
	Tue,  2 Jun 2026 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2201F00893;
	Tue,  2 Jun 2026 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395020;
	bh=0sPLzsNzNrE5sYBDRc7UQyK3KG2m+vueA9urvjX/WEs=;
	h=From:Subject:Date:To:Cc;
	b=S4YSpK4f2pH92GwKlT/TH7osx/3MRT19koRieRsuI8QrPrzw9Y4FYYnYq0otMcoyp
	 VSHl8KQnZDBBKDmDUPyKjCMUWJ6ZGoOengV4oTpi2xqiMC4Yjmy78OEQcCssvY+VZu
	 DqL0TX5jcsKhAYFp0YcTJIZz7cPNS7drfGUuWJbMB9lNcwUoC7WbeQWEf0vvEytf4g
	 E2hEwx3SZQkoNeSkVDldR9nbV1lcHQM+HfWvflJSfugCh/uOt4BzAXg3uR21ZxXMDF
	 TQG+Ip0ZgtZRMEhGNLTRZiLwK11BdWG0F8eUdP2xTsna7AngAggXRan6Z6nnT86IXO
	 VpU0aTWvxNBfQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/8] fs: support freeze/thaw/mark_dead/sync with shared
 devices
Date: Tue, 02 Jun 2026 12:10:06 +0200
Message-Id: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAP+rHmoC/yWM0QqCQBAAf0X2uRU90KLXoA/oNUJu7za9Mk921
 QLx39N6nGGYGZQlsMIxmUF4Chpit0K+S8A1tqsZg18ZTGbKrMwMvqM8UceeBcnzVDWx9SxV3Ua
 yLR4c2YILQ+wLWB+98D18fv8rXM4nuP2ljvRgN2znLSOrjCS2c82mXlYHlnTapzmKy2FZvtNKv
 tmoAAAA
X-Change-ID: 20260602-work-super-bdev_holder_global-8cba5e52bed5
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8PAOYH0N838UHayA/tOONu2IcWfdoIg+edZyFkLDa8o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJreG4GXYx+0Zi52NGHc+ynRf2b+1hern5Se/Jry/CN
 IQiT9qzdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzktTsjw7bF/kr3QxgvK7a9
 qGtq7bnpZLzseI7IvqWc+y5dOfCuehYjw8kbi46lLWmzqL7e/awsJuK+hcjZUx3XwhU5tbNsg4Q
 ucwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 6FBEE62C390
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
	TAGGED_FROM(0.00)[bounces-3498-lists,linux-erofs=lfdr.de];
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

Note, this is on the border between RFC/POC and so I haven't pushed this
through testing yet. But I don't want to waste more time on this before
showing it.

I surveyed various fs implementations because I want the ability to
extend userspace the ability to manage what devices can be onlined in a
centralized way without having to force every fs to care about this.

I realized that erofs allows sharing block devices with multiple
superblocks. Any freeze, thaw, removal, or sync on those devices will
not be communicated to the superblocks using it and our current
infrastructure is unable to deal with this.

This attempts to add the ability to go from device number to all the
superblock using that device, iterate through them one-by-one and
perform actions on them. For most fses this is a 1:1 mapping but for
erofs its a 1:many mapping.

This is not unreasonable infastructure to support in my opinion. I
played around with some ideas for this and I want to send out an RFC to
gather some early input.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (8):
      fs, block: move blk_mode_t and fop_flags_t into <linux/types.h>
      fs: add a global device to super block hash table
      fs: refuse to claim any frozen block device
      xfs: port to fs_bdev_file_open_by_path()
      btrfs: open via dedicated fs bdev helpers
      ext4: open via dedicated fs bdev helpers
      erofs: open via dedicated fs bdev helpers
      super: make fs_holder_ops private

 fs/btrfs/dev-replace.c   |   6 +-
 fs/btrfs/ioctl.c         |   4 +-
 fs/btrfs/volumes.c       |  26 ++-
 fs/erofs/data.c          |   6 +
 fs/erofs/internal.h      |  10 ++
 fs/erofs/super.c         |  66 +++++--
 fs/erofs/zdata.c         |  10 +-
 fs/ext4/super.c          |  12 +-
 fs/super.c               | 452 ++++++++++++++++++++++++++++++++---------------
 fs/xfs/xfs_buf.c         |   2 +-
 fs/xfs/xfs_super.c       |  10 +-
 include/linux/blkdev.h   |   9 -
 include/linux/fs.h       |   2 -
 include/linux/fs/super.h |   7 +
 include/linux/types.h    |   2 +
 15 files changed, 433 insertions(+), 191 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260602-work-super-bdev_holder_global-8cba5e52bed5


