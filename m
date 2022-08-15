Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10402592E5F
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 13:46:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M5stS6Hrvz3bdy
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 21:46:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660563968;
	bh=IG+W3GPsQxJWKRJrpoGUzYeFPdMahNbOtgGnByA4Hcw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=EaGzA+jQjL1BaTVhwxGfusWz0jTBjZyyBL5XRBr/Qwn3TsbItoFu/LcD0zs8SDUwF
	 BasUsd6/ZWqpDnomGQB7aTL0shfLrd6DVupaU2vvksldllN9plxxRZMwrmNggtGgNJ
	 P1ctxn8aV72H9FTAxyRtYWkQpplIGE9yVh7Y+sTGx1Elc1LZ7JGqrGC1PQe69fpZi6
	 BjK5CJwZ1LMAazWlSxkGhqAO7xaTsH6IgiJvT8X1s1I3R6luhlY0FcdBPY3mEPk8xp
	 kvp8RsdcakOLM3b2F86S7LbaQq58zh2/axvrYjTuZ5omU3cd57s+NzSp7Lt/LUxdYR
	 hOH1OEN+vQMeQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=meKxjjkm;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M5stB4pfrz305P
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Aug 2022 21:45:54 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D794A20839;
	Mon, 15 Aug 2022 11:45:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 469D413A93;
	Mon, 15 Aug 2022 11:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hiARA+Ex+mLsGAAAMHmgww
	(envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:37 +0000
To: u-boot@lists.denx.de
Subject: [PATCH v3 0/8] U-boot: fs: add generic unaligned read offset handling
Date: Mon, 15 Aug 2022 19:45:11 +0800
Message-Id: <cover.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
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
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[CHANGELOG]
v3:
- Fix an error that we always return 0 actread bytes for unsupported fses
  For unsupported fses, we should also populate @total_read.
  Or we will just read the data but still return 0 for actually bytes.

  Now it pass all test_fs* cases.

v2
- Fix a linkage error where (U64 % U32) is called without proper helper
  Fix it with U64 & (U32 - 1), as the U32 value (@blocksize) should
  always be power of 2, thus (@blocksize - 1) is the mask we want to
  calculate the offset inside the block.

  Above change only affects the 4th patch, everything else is not
  touched.

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
2.37.1

