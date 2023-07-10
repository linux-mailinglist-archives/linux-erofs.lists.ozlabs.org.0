Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A349D74D41E
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 13:03:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R01M15kKmz3bdm
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 21:03:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R01Lv4zRzz304g
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 21:03:02 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vn2HVty_1688986972;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn2HVty_1688986972)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 19:02:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/4] erofs-utils: add DEFLATE compression support
Date: Mon, 10 Jul 2023 19:02:47 +0800
Message-Id: <20230710110251.89464-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This is the EROFS DEFLATE support which I've been working on these
months, mainly implementing DEFLATE fixed-sized output approach.  Note
that it's still some room to improve but I introduce it just to avoid
external outdated zlib dependencies and the basic zlib encoder.

DEFLATE is a popular generic-purpose compression algorithm for a quite
long time (many advanced formats like zlib, gzip, zip, png are all
based on that), which is made of LZ77 as wells as Huffman code, fully
documented as RFC1951 and quite easy to understand.  DEFLATE encoder
and decoder are also easy to be implemented and they generally have
fairly small code size and runtime memory consumption.

In addition, there are several hardware on-market DEFLATE accelerators
as well, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
accelerator, etc.  Therefore, it's useful to support DEFLATE in order
to use these for async I/Os and get benefits from these later.

As usual, some numbers of enwik8 and silesia.tar are available below:

Commandline option: -zdeflate,9 (to match mksquashfs default level)
Sliding window size: 32768

enwik8:
 ____________________________
|  file system  |    size    |
|_______________|____________|
|___ enwik8 ____|_100000000__|
|_ squashfs_4k _|__46325760__|
|_ squashfs_8k _|__43618304__|
|__ erofs_4k ___|__43073536__| (erofs default)
| squashfs_16k _|__41406464__|
|__ erofs_8k ___|__40873984__|
|__ erofs_16k __|__38998016__|
| squashfs_64k _|__38109184__|
| squashfs_128k |__37306368__| (squashfs default)
|__ erofs_64k __|__37142528__|

silesia.tar (much similar to enwik8 so I omit some):
 ____________________________
|  file system  |    size    |
|_______________|____________|
|_ silesia.tar _|_211957760__|
|_ squashfs_4k _|__86884352__|
|_ squashfs_8k _|__81125376__|
|__ erofs_4k ___|__78970880__| (erofs default)
|__ erofs_8k ___|__74768384__|
| squashfs_64k _|__70447104__|
| squashfs_128k |__69079040__| (squashfs default)
|__ erofs_64k __|__68640768__|

Thanks,
Gao Xiang

changes since v2:
 - add libdeflate compressor support by using the currect APIs.

Gao Xiang (4):
  erofs-utils: add a built-in DEFLATE compressor
  erofs-utils: fuse,fsck: add DEFLATE algorithm support
  erofs-utils: mkfs: add DEFLATE algorithm support
  erofs-utils: mkfs: add libdeflate compressor support

 configure.ac                |   46 ++
 dump/Makefile.am            |    2 +-
 fsck/Makefile.am            |    4 +-
 fuse/Makefile.am            |    2 +-
 include/erofs_fs.h          |    7 +
 lib/Makefile.am             |    5 +
 lib/compress.c              |   24 +
 lib/compressor.c            |    4 +
 lib/compressor.h            |    2 +
 lib/compressor_deflate.c    |   78 +++
 lib/compressor_libdeflate.c |  114 ++++
 lib/decompress.c            |  147 ++++
 lib/kite_deflate.c          | 1270 +++++++++++++++++++++++++++++++++++
 mkfs/Makefile.am            |    2 +-
 14 files changed, 1702 insertions(+), 5 deletions(-)
 create mode 100644 lib/compressor_deflate.c
 create mode 100644 lib/compressor_libdeflate.c
 create mode 100644 lib/kite_deflate.c

-- 
2.24.4

