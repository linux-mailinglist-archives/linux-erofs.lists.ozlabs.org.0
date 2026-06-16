Return-Path: <linux-erofs+bounces-3634-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wH0WE+tYMWrXhQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3634-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:08:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3E6903D7
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:08:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZugUIHc6;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3634-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3634-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpkH5YhDz3c3l;
	Wed, 17 Jun 2026 00:08:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618919;
	cv=none; b=Qw7q/pX5dXyrPoAkrpfYh+ZpSx+PSoLyLh1MkQB0OML3Rj1IXJ89lfIO9KKw9Gq60ZJKabkS/Sa7aLORe/5jk9nB0kKub03fLsDaLwHzbHaHIWTMvGqWwi5artTjEQymSVHOaWe7ytTCI94YCn/9LMxtxf3GLopqa2WGn9tc/efMX1G9KWB1da3NGvnZqIoGrE54+ORhSDAb11lmVKxVgz93uHitrkaImQXlFFT9sM0fNPETaZI9cSPRkDkl+VP4FjDWXRHKwUuvXy8+QC1VORFOw10SPcSxoV8dceAanj7c0jdZ8+8KFQWNi9+rHyNZapmBnFjYuJqb+0/emLa+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618919; c=relaxed/relaxed;
	bh=vrChKgbTI+0aqivTF5YP6Yuwbv2q4OzzhaoctlYZpaM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A32nsQ1q0w7O7s+zEuKrD95hA4LI616BQO7Lj4f1Lmjq9ykZihJr79zGfJRQinct2+Qp6htjfZ9vjbXcMfY/s2G8luTP1+fy8Yk8VN5QFNrIr/VsqT8LjQ8Man8mab1ojNGu3wcY4471PfyVkKfMMpUXB2Q00Uq7Yjq21YHVVIfi0AVYqUoBXYhSXtjeXyHxYrKwYrOQf998B2ua/ccKNDVqiEIBIz07g5Ap+BYwchTDj+v5VFUfhP4NT7SF66pA/dUSf60mJNeY5ciTDkVwY2LbP/2Sm8IupEShTc4AR4CgM5zHX+rm4hg1M//XthxoBVFa1WeFPUoOdHq8LwGNvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZugUIHc6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpkG05rBz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:08:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82D43600AB;
	Tue, 16 Jun 2026 14:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD56D1F000E9;
	Tue, 16 Jun 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618915;
	bh=vrChKgbTI+0aqivTF5YP6Yuwbv2q4OzzhaoctlYZpaM=;
	h=From:Subject:Date:To:Cc;
	b=ZugUIHc6Aq2rgs4tUnGQK0fzxOeCN1jy0iKf7Vf80qCDDLK6ylLvc7KuHXyUyhlJo
	 AZ4pjovOvM3AIeDSgPv6PO7A3whILphjqK9LHMVXxNFU1VZF7lkNhlYMB1jOWnB6Sz
	 UhG//CfYLOufFNQ3ZrNvx+91YNRibbLrP0hKQDE9bHZeHr42naAiKqwRFynVRymqLi
	 tthie1w5XTiStq4bfzD81mlkabTxkvEI+0KDgVDwLsuvBOSI4blFtuQ3tL7AkjR3Th
	 e+/ppRyquEfTGTEP7bmj54Wozv4CxsR3CgH6qa1mkKZw9x2vuID8QiTAyb+NUfiPxK
	 UlR6GzLBYJVZg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 00/18] fs: support freeze/thaw/mark_dead/sync with
 shared devices
Date: Tue, 16 Jun 2026 16:08:16 +0200
Message-Id: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIANBYMWoC/42OQW6DMBRErxJ5XSPjCIS6ilSpB+i2ipA/HsAJt
 dE3kKYRdw8mF+hyRjNv5iEi2CGK98NDMBYXXfCb0G8H0fTGd5DOblpopUtVKi1vga8yziNYksV
 S92Gw4LobAplBVg2ZAoUm2EJsjJHRut+d/y2+Pj/E+WXGmS5opkROMTIRktj4pk9W2sj2jaxl4
 A+1hb/X8xgnhvlJjd7FKfB9/73kO/6fF5dcKkmkWlvp9liV+ekK9hiywJ04r+v6BAABAjoUAQA
 A
X-Change-ID: 20260602-work-super-bdev_holder_global-8cba5e52bed5
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
 linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, 
 linux-erofs@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 syzbot@syzkaller.appspotmail.com, Gao Xiang <xiang@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7470; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Do5i3EDmjVE1e/AZzgM+lKWOADPulnojqc5162s3uhI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtybLbr8y1c30W0vfldvvn/t+KZpW5xrNywXP/AsY
 8Z9Kb8S3Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJbJ3LyLDwJO/0vkcmKru2
 6XiG/mJda+zzliVE2GuCZfDrg0x9zVUM/1St7sWmptTujS90iCkP2LhzYvzXgFUePaVnmsr+zs5
 +wQMA
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
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-3634-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60F3E6903D7

This is a generalization of the device number to superblock so it works
for actual block device and anonymous (or even mtd) devices.

fs_holder_ops recovers the affected superblock from bdev->bd_holder. That
forces the holder of a block device to be exactly one superblock and makes
it impossible for several superblocks to share a single device.

erofs does exactly that. It can mount read-only "blob" devices that are
shared between many superblocks: a metadata-only erofs that indexes a set
of per-layer blobs (one filesystem instead of one per OCI layer), or an
incremental image whose base device is shared by several updates. Because
the block layer only tracks a single holder, a freeze, thaw, removal or
sync on such a device is never propagated to all the superblocks using it,
and the current infrastructure has no way to find them.

This series replaces the bd_holder-based lookup with a global, dev_t-keyed
table mapping each block device to the superblock(s) using it. The holder
argument becomes purely the block layer's exclusivity token -- a superblock,
or the file_system_type for a device shared within one filesystem type --
and the fs_holder_ops callbacks look the device up in the table and act on
every superblock registered for it: 1:1 for most filesystems, 1:many for
erofs.

Filesystems claim and release their devices through new
fs_bdev_file_open_by_{dev,path}() and fs_bdev_file_release() helpers; the
per-fs patches convert xfs, btrfs, ext4, f2fs and erofs over to them and
fix cramfs and romfs, which released the registered main device with a
raw bdev_fput().

Since every superblock is registered under its s_dev the table also
replaces the last s_dev-keyed walk of the super_blocks list:
user_get_super() resolves device numbers through it, so ustat() and
quotactl() now work on any device a filesystem claims and no longer
take sb_lock.

The longer-term motivation is to let userspace decide which devices may be
onlined from one central place, without having to teach every filesystem
about it individually.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- super: rework the device-to-superblock table reference counting: each
  (device, superblock) entry carries a single claim count and holds one
  passive reference on its superblock for the entry's lifetime. New prep
  patches convert s_count to refcount_t s_passive and make put_super()
  self-locking.
- super: preallocate the entry in alloc_super() and register it from the
  set callbacks through set_anon_super()/set_bdev_super(); an insert
  failure unwinds exactly like a set callback failure. The superblock
  stashes the entry in sb->s_super_dev and kill_super_notify() drops the
  claim through it.
- super: initialize the table from mnt_init(); the rootfs and shm mounts
  are created long before any initcall runs.
- super: fold the v1 "refuse to claim a frozen block device" patch into
  the registration helper and restore the EBUSY check for the primary
  device in setup_bdev_super(): additional devices (the xfs log, the ext4
  journal, erofs blobs) are now refused while frozen as well, answering
  Jan's question on v1 3/8.
- Split the core patch into table/helpers/switch-over and move the
  xfs/btrfs/ext4 conversions before the fs_holder_ops switch so no
  freeze/mark_dead events are lost mid-series; erofs follows the switch.
- New prep patches: the ext4 KUnit tests allocate anonymous devices and
  ocfs2 stops resetting s_dev on dismount.
- New: convert user_get_super() to the device table, plus a ustat()
  selftest.
- New: fix a pre-existing double release of the realtime device file and
  dangling buftarg pointers in xfs_open_devices()'s error unwind.
- New: convert f2fs's additional devices to the helpers; fix cramfs and
  romfs releasing the registered main device with a raw bdev_fput().
- erofs: drop the .shutdown() and .remove_bdev() implementations and the
  per-device "dead" flag. Immutable filesystems don't need them: the block
  layer sets GD_DEAD before fs_bdev_mark_dead() so in-flight bios fail
  anyway, erofs has no write path or journal to stop, and the read-only
  loop_change_fd() case must not be forced to -EIO. Patch from Gao Xiang,
  applied verbatim - thanks!
- btrfs: fix a general protection fault in close_fs_devices() on a failed
  mount (reported by syzbot). The release path took the superblock from
  device->fs_info, which is still NULL if open_ctree() fails before
  btrfs_init_devices_late(); it now uses bdev_file->private_data.
- erofs: the v1 conversion was sent with a generic boilerplate changelog;
  superseded by Gao's patch above.
- Collect Reviewed-by from Jan Kara and Tested-by from syzbot.
- Rebase onto v7.1-rc1.
- Link to v1: https://patch.msgid.link/20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org

---
Christian Brauner (18):
      xfs: fix the error unwind in xfs_open_devices()
      super: convert s_count to refcount_t s_passive
      super: take lock after last reference count
      fs, block: move blk_mode_t and fop_flags_t into <linux/types.h>
      ext4: use anonymous devices for KUnit test superblocks
      ocfs2: don't reset s_dev on dismount
      fs: maintain a global device-to-superblock table
      fs: add dedicated block device open helpers for filesystems
      xfs: port to fs_bdev_file_open_by_path()
      btrfs: open via dedicated fs bdev helpers
      ext4: open via dedicated fs bdev helpers
      fs: look up superblocks via the device table in fs_holder_ops
      fs: tolerate per-superblock freeze errors on shared devices
      erofs: open via dedicated fs bdev helpers
      f2fs: open via dedicated fs bdev helpers
      super: make fs_holder_ops private
      fs: look up the superblock via the device table in user_get_super()
      selftests/filesystems: add ustat() coverage

 fs/btrfs/volumes.c                               |  31 +-
 fs/cramfs/inode.c                                |   2 +-
 fs/erofs/super.c                                 |  35 +-
 fs/ext4/extents-test.c                           |   9 +-
 fs/ext4/mballoc-test.c                           |   9 +-
 fs/ext4/super.c                                  |  12 +-
 fs/f2fs/super.c                                  |   6 +-
 fs/internal.h                                    |   1 +
 fs/namespace.c                                   |   2 +
 fs/ocfs2/super.c                                 |   1 -
 fs/romfs/super.c                                 |   2 +-
 fs/super.c                                       | 620 ++++++++++++++++-------
 fs/xfs/xfs_buf.c                                 |   2 +-
 fs/xfs/xfs_super.c                               |  13 +-
 include/linux/blkdev.h                           |   9 -
 include/linux/fs.h                               |   2 -
 include/linux/fs/super.h                         |   8 +
 include/linux/fs/super_types.h                   |   4 +-
 include/linux/types.h                            |   2 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/ustat_test.c | 135 +++++
 22 files changed, 647 insertions(+), 261 deletions(-)
---
base-commit: 0c0d974f62e6603d4514e1a8035658edb353c68f
change-id: 20260602-work-super-bdev_holder_global-8cba5e52bed5


