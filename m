Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C034258DC
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Oct 2021 19:06:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQHm35x4cz2yxL
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Oct 2021 04:06:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tMUKpEvG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tMUKpEvG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQHlx20HLz2yPM
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Oct 2021 04:06:21 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE5D76101A;
 Thu,  7 Oct 2021 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633626377;
 bh=Ux3XZPeUC6HTXcSQafNCJCdBwt4Gii0aCWwGuNCo3W8=;
 h=From:To:Cc:Subject:Date:From;
 b=tMUKpEvGdO2toosMnghyufaU2uG30Zzp36JlGHzS5563/OClBdOd1vaX21IlYx6HB
 2WtjYkiEoVyPTWjcD8+rCTULhZZXYYZaPADS1LwsTi3EQyVwlz9nvllFxRUuy9n5tm
 b/HUD5pRV1cYkE2Du4Zqy9DZNlACmgc7XQCurpPfD2cx4hxaLvYJBwegAwZU38zwZY
 ixZ9G8FKYdUiRLg2BF+G3Mg0ZX2rcN8qOQD6zXL4jTJcnybf0Ocz7sBKLqvEHG3Hmn
 kgOXymfyzf3Wb0Od6f7DjLNlgtK8E+x5fs1QGpyN/QcEjvmpVhryau5B+crJHz7aIL
 zrHS1WaT0iRhQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 0/3] erofs: some decompression improvements
Date: Fri,  8 Oct 2021 01:06:02 +0800
Message-Id: <20211007170605.7062-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This patchset is mainly intended for the upcoming LZMA preparation,
but they still have some benefits to the exist LZ4 decompression.

The first patch looks up compression algorithms on mapping instead
of in the decompression frontend, which is used for the rest patches.

The second patch introduces another compression HEAD (HEAD2) so that
each file can be compressed with two different algorithms at most,
which can be used for the upcoming LZMA compression and LZ4 range
dictionary compression for various data patterns.

The third patch introduces a new readmore decompression strategy to
avoid partial decompression for large big pcluster. It resolves the
randread issue mentioned in the original big pcluster patchset [1]:

randread
Kernel: 5.15.0-rc2+
pclustersize		Vanilla		Patched
 4096			 54.6 MiB/s	 54.0 MiB/s
16384			117.4 MiB/s	143.8 MiB/s
32768			113.6 MiB/s	199.6 MiB/s
65536			 72.8 MiB/s	236.4 MiB/s

The latest version can also be fetched from
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/readmore

[1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org

Thanks,
Gao Xiang

Gao Xiang (3):
  erofs: get compression algorithms directly on mapping
  erofs: introduce the secondary compression head
  erofs: introduce readmore decompression strategy

 fs/erofs/compress.h          |   5 --
 fs/erofs/erofs_fs.h          |   8 ++-
 fs/erofs/internal.h          |  28 ++++++++-
 fs/erofs/zdata.c             | 106 ++++++++++++++++++++++++++---------
 fs/erofs/zmap.c              |  57 ++++++++++++-------
 include/trace/events/erofs.h |   2 +-
 6 files changed, 150 insertions(+), 56 deletions(-)

-- 
2.20.1

