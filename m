Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350F55BF1A
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRV1bwnz3bsW
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401318;
	bh=TCuBU9+Ebtl78YYJEE8nANTF1gTekBtlwBuL1hrnFno=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZjNObGizs/uTK2dAKZzc3sYHqQM8D6kJB+Fh2K2qHlVivk4nVi3bOA9lQdnwZ1+rm
	 temXzY0Vn/q2A2HmiBnMiuuugTcfpKx4uVoGx11cP9HHgtSvnYGCpfsuJmPA7fChNm
	 5g+M46u2NB31kSoMtSpS0jnmMKqaRc9okhVbQ6mfgUnAYpSBKbpbsNakNBSpjlSY5U
	 OsFZ8P9Aj31HIm9UE+e64K2sJsi8OFgN9vkHKZpjKIHFRoyGkwxRABXw43kdjtRS6o
	 PamMYNTm1bTn6Z7pWK/ZC0XmEvymUL7XL8R8zga/m6nsYM++2voIQ61QPHuTtDmbzl
	 PUg87zp1HNwrA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=hnsPtvLr;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRQ2bq1z306Y
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:33 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE481FB3C;
	Tue, 28 Jun 2022 07:28:29 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03EFD139E9;
	Tue, 28 Jun 2022 07:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ahE+L5mtumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:25 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Date: Tue, 28 Jun 2022 15:28:00 +0800
Message-Id: <cover.1656401086.git.wqu@suse.com>
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

- Read the aligned range if there is any

- Read the tailing block containing the unaligned range
  And copy the covered range into the destination.

[DISADVANTAGE]
There are mainly two problems:

- Extra memory allocation for every _fs_read() call
  For the leading and tailing block.

- Extra path resolving
  All those supported fs will have to do extra path resolving up to 2
  times (one for the leading block, one for the tailing block).
  This may slow down the read.

[SUPPORTED FSES]

- Btrfs (manually tested*)
- Ext4 (manually tested)
- FAT (manually tested)
- Erofs
- sandboxfs
- ubifs

*: Failed to get the test cases run, thus have to go sandbox mode, and
attach an image with target fs, load the target file (with unaligned
range) and compare the result using md5sum.

For EXT4/FAT, they may need extra cleanup, as their existing unaligned
range handling is no longer needed anymore, cleaning them up should free 
more code lines than the added one.

Just not confident enough to modify them all by myself.

[UNSUPPORTED FSES]
- Squashfs
  They don't support non-zero offset, thus it can not handle the tailing
  block reading.
  Need extra help to add block aligned offset support.

- Semihostfs
  It's using hardcoded trap to do system calls, not sure how it would
  work for stat() call.

Extra testing/feedback is always appreciated.


Qu Wenruo (8):
  fs: fat: unexport file_fat_read_at()
  fs: always get the file size in _fs_read()
  fs: btrfs: move the unaligned read code to _fs_read() for btrfs
  fs: ext4: rely on _fs_read() to pass block aligned range into
    ext4fs_read_file()
  fs: fat: rely on higher layer to get block aligned read range
  fs: sandboxfs: add sandbox_fs_get_blocksize()
  fs: ubifs: rely on higher layer to do unaligned read
  fs: erofs: add unaligned read range handling

 arch/sandbox/cpu/os.c  |  11 +++
 fs/btrfs/btrfs.c       |  24 +++---
 fs/btrfs/inode.c       |  84 ++------------------
 fs/erofs/internal.h    |   1 +
 fs/erofs/super.c       |   6 ++
 fs/ext4/ext4fs.c       |  11 +++
 fs/fat/fat.c           |  17 ++++-
 fs/fs.c                | 169 +++++++++++++++++++++++++++++++++++++++--
 fs/sandbox/sandboxfs.c |  14 ++++
 fs/ubifs/ubifs.c       |  13 ++--
 include/btrfs.h        |   1 +
 include/erofs.h        |   1 +
 include/ext4fs.h       |   1 +
 include/fat.h          |   3 +-
 include/os.h           |   8 ++
 include/sandboxfs.h    |   1 +
 include/ubifs_uboot.h  |   1 +
 17 files changed, 258 insertions(+), 108 deletions(-)

-- 
2.36.1

