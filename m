Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C4B6B7981
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Mar 2023 14:53:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PZymJ6nhXz3c79
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 00:53:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PZymF0Q8jz30Lt
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 00:53:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VdoOEkX_1678715589;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdoOEkX_1678715589)
          by smtp.aliyun-inc.com;
          Mon, 13 Mar 2023 21:53:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 0/2] erofs: set block size to the on-disk block size
Date: Mon, 13 Mar 2023 21:53:07 +0800
Message-Id: <20230313135309.75269-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changes since v5:
- patch 1: calculate len of crc range correctly considering when
  blocksize <= EROFS_SUPER_OFFSET, i.e. blocksize is 512 or 1024 bytes
  (Gao Xiang)
- patch 2: remove sbi->dirblkbits for now (Gao Xiang)

changes since v4:
- patch 1: convert several remained call sites of sb->s_blocksize_bits
  to erofs_blknr() and erofs_pos() (Yue Hu)
- patch 2: revise comment for blkszbits and dirblkbits (Yue Hu)

changes since v3:
- patch 1: remove redundant newline when printing messages (Gao Xiang)
- patch 2: introduce dirblkbits in on-disk superblock and disable this
  feature for now, so that the current kernel won't break with the image
  with this feature enabled later (Gao Xiang)


v1: https://lore.kernel.org/all/20230216094745.47868-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230217055016.71462-2-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230220025046.103777-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230302143915.111739-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20230306100200.117684-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: avoid hardcoded blocksize for subpage block support
  erofs: set block size to the on-disk block size

 fs/erofs/data.c              | 50 +++++++++++++------------
 fs/erofs/decompressor.c      |  6 +--
 fs/erofs/decompressor_lzma.c |  4 +-
 fs/erofs/dir.c               | 22 +++++------
 fs/erofs/erofs_fs.h          |  5 ++-
 fs/erofs/fscache.c           |  5 ++-
 fs/erofs/inode.c             | 23 +++++++-----
 fs/erofs/internal.h          | 28 ++++----------
 fs/erofs/namei.c             | 14 +++----
 fs/erofs/super.c             | 72 ++++++++++++++++++++++--------------
 fs/erofs/xattr.c             | 40 ++++++++++----------
 fs/erofs/xattr.h             | 10 ++---
 fs/erofs/zdata.c             | 18 +++++----
 fs/erofs/zmap.c              | 29 ++++++++-------
 include/trace/events/erofs.h |  4 +-
 15 files changed, 171 insertions(+), 159 deletions(-)

-- 
2.19.1.6.gb485710b

