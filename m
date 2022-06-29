Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1A55FEC6
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzxz57V7z3cg2
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502743;
	bh=z3GbE9mx5CCrqo9xfI+63v/1zfie4tXfQ6g0f+eqfy0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=bQZlthQCJvPUnX3T1mh9RAYAhmMiwHAFwTDRZ1FtZNrN2GcyxLuBje8AFuP8K2y2S
	 JnQWwb1LwZ4YrCowyK/OSU8b9HsmFKocHH4H5Tm23Eoy0+3Y/bVZOvaWwRB5CCBKoX
	 RJX1vEGWvCcKXEPseYAF45EgUPIobZOBd8RdWRGo2o+PgPZJYb2acUtmmQWCaQxSaC
	 JDXMsRtoBpRZiJd4qgl0eivYzDJAjQAljzpOXYvtf+DRG0Jmt2+sLwDqWG4034TniS
	 YHFhnAC5DTlPD08mXfWBU/GFjMeW7pvxoXVJTv0zuIeGV2NgGDzvDfh6C5rongKZ34
	 Zj9+lIeY6+BSQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=QMzjdKlM;
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzxq1hrCz3c9K
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:38:53 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CB51220C1;
	Wed, 29 Jun 2022 11:38:49 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D488133D1;
	Wed, 29 Jun 2022 11:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sDjRMsY5vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:38:46 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 0/8] U-boot: fs: add generic unaligned read offset handling
Date: Wed, 29 Jun 2022 19:38:21 +0800
Message-Id: <cover.1656502685.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Qu Wenruo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qu Wenruo <wqu@suse.com>
Cc: trini@konsulko.com, jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[CHANGELOG]
RFC->v1:
- More (manual) testing
  Unfortunately, in the latest master (75967970850a), the fs-tests.sh
  always seems to hang at preparing the fs image.

  Thus still has to do manual testing, tested btrfs, ext4 and fat, with
  aligned and unaligned read, also added soft link read, all looks fine here.

  Extra testing is still appreciated.

- Two more btrfs specific bug fixes
  All exposed during manual tests

- Remove the tailing unaligned block handling
  In fact, all fses can easily handle such case, just a min() call is
  enough.

- Remove the support for sandboxfs
  Since it's using read() calls, really no need to do block alignment
  check.

- Enhanced blocksize check
  Ensure the returned blocksize is not only non-error, but also
  non-zero.

This patchset can be fetched from github:
https://github.com/adam900710/u-boot/tree/fs_unaligned_read

[BACKGROUND]
Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
just pass the request range to underlying fses.

Under most case, this works fine, as U-boot only really needs to read
the whole file (aka, 0 for both offset and len, len will be later
determined using file size).

But if some advanced user/script wants to extract kernel/initramfs from
combined image, we may need to do unaligned read in that case.

[ADVANTAGE]
This patchset will handle unaligned read range in _fs_read():

- Get blocksize of the underlying fs

- Read the leading block contianing the unaligned range
  The full block will be stored in a local buffer, then only copy
  the bytes in the unaligned range into the destination buffer.

  If the first block covers the whole range, we just call it aday.

- Read the remaining range which starts at block aligned offset
  For most common case, which is 0 offset and 0 len, the code will not
  be changed at all.

Just one extra get_blocksize() call, and for FAT/Btrfs/EROFS they all have
cached blocksize, thus it takes almost no extra cost.

Although for EXT4, it doesn't seem to cache the blocksize globally,
thus has to do a path resolve and grab the blocksize.

[DISADVANTAGE]
The involved problem is:

- Extra path resolving
  All those supported fs may have to do one extra path resolve if the
  read offset is not aligned.

  For EXT4, it will do one extra path resolve just to grab the
  blocksize.

For data read which starts at offset 0 (the most common case), it
should cause *NO* difference in performance.
As the extra handling is only for unaligned offset.

The common path is not really modified.

[SUPPORTED FSES]

- Btrfs (manually tested*)
- Ext4 (manually tested)
- FAT (manually tested)
- Erofs
- ubifs (unable to test, due to compile failure)

*: Failed to get the test cases run, thus have to go sandbox mode, and
attach an image with target fs, load the target file (with unaligned
range) and compare the result using md5sum.

For EXT4/FAT, they may need extra cleanup, as their existing unaligned
range handling is no longer needed anymore, cleaning them up should free 
more code lines than the added one.

Just not confident enough to modify them all by myself.

[UNSUPPORTED FSES]
- Squashfs
  They don't support non-zero offset, thus it can not handle the block
  aligned range.
  Need extra help to add block aligned offset support.

- Semihostfs
- Sandboxfs
  They all use read() directly, no need to do alignment check at all.

Extra testing/feedback is always appreciated.

Qu Wenruo (8):
  fs: fat: unexport file_fat_read_at()
  fs: btrfs: fix a bug which no data get read if the length is not 0
  fs: btrfs: fix a crash if specified range is beyond file size
  fs: btrfs: move the unaligned read code to _fs_read() for btrfs
  fs: ext4: rely on _fs_read() to handle leading unaligned block read
  fs: fat: rely on higher layer to get block aligned read range
  fs: ubifs: rely on higher layer to do unaligned read
  fs: erofs: add unaligned read range handling

 fs/btrfs/btrfs.c      |  33 ++++++++---
 fs/btrfs/inode.c      |  89 +++--------------------------
 fs/erofs/internal.h   |   1 +
 fs/erofs/super.c      |   6 ++
 fs/ext4/ext4fs.c      |  22 +++++++
 fs/fat/fat.c          |  17 +++++-
 fs/fs.c               | 130 +++++++++++++++++++++++++++++++++++++++---
 fs/ubifs/ubifs.c      |  13 +++--
 include/btrfs.h       |   1 +
 include/erofs.h       |   1 +
 include/ext4fs.h      |   1 +
 include/fat.h         |   3 +-
 include/ubifs_uboot.h |   1 +
 13 files changed, 212 insertions(+), 106 deletions(-)

-- 
2.36.1

