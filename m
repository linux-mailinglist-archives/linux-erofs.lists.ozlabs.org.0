Return-Path: <linux-erofs+bounces-503-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3271AF73D2
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:23:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXwsg05gCz2yPd;
	Thu,  3 Jul 2025 22:23:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751545414;
	cv=none; b=Qj6gGrwDYxTJ4fBe/WW9Fx26/G2F0pc/3f8wT268y+IIeChyfq5+v/Hiwbr6t3bFKAJdrnNPz6MAbJPzR6mcTw5zuKewRy9ctsV9a7tkfybJm0jCjyQGbidgjdqumEq/QJhAA8vwfDSlBgXxwdgqQ5+54APh3xGsOu65WmFEVOaidiMM3iv8AIDPpyc6XL5GQbJoHIgLJOLW7QW3mkB4vB8MaNyZIoOzdOIgXPdFVawCGvYxR6SoVLaNuggs+CrwCr1eNnXsqj2pX3bd2W93hCOzdEsNLr0lJT/fR9o8V08mT7MckBGR1HOoPHWBevHjFdDikcL205WYkezhQGIEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751545414; c=relaxed/relaxed;
	bh=uPijF3iI7QoCn0w1qfdUfB1WMDBTiS+qjci8jnDCXL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FlxXQ1DmruDYzorBH4y2HRh9aNojO0uN9zmXqTcrHkivvZPnRBDZbeedB3pU1BgUwgAVlxhQ0dntAOu/ubHHd33r+nqSHxYt4Ai331TxfAZFxiLEzVYwmDlcKYX8VhoqXXRr0JIT9qUQOiueTJnq8mBBqPAQeh47ALz9lTFMzu9siT8uWfTY0xwo6uH9VFc+8dA77XFG46aHtNuhxlCOciD1yec5FTckZbrUVekW7L6INzlj3F8UI2DQ/G2N1KVslnOA2e8BGj+A4j/xYH5k+Sf6Dge0lUiDxtCCr6L7LVfvbVow/jt4pEswAgEWrJb2tLfDn4kJKNHBFlRBtXB96Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HUfDYqo1; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HUfDYqo1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXwsd5J4hz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:23:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 03F66A53823;
	Thu,  3 Jul 2025 12:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62AAC4CEE3;
	Thu,  3 Jul 2025 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545410;
	bh=NHj/OgTQbNkxMApIz4EDEZmrS7APXBdmx92p5pBOdY8=;
	h=From:Subject:Date:To:Cc:From;
	b=HUfDYqo1xvRz6FU8hAvr79K6atshCVd2chqc5kB1CJL9PykQsFLy/MPQExj79Jhon
	 xb28zCC5k8wTuPc+aT2eyaWudlT2isPY13Q49Ff7Mmf94KBnTjWUxFmPrmJraBzoMp
	 BGXSPO7sU7p21Bc41wZUmxaTegOxQZdMH/vGzk6r4Hro8PiLfGP3BTVyKeCWgyByvs
	 6r+t29xqy/FUtrT9C1WavM4+yNsOUWqp6BSIWaI7YYSY56/28ROVg7PMLTy9Q9lJBo
	 9hiMUtwsEnPg0zeaMDKN3KdEjwrnVzWY+BqnuH4EF9uhSUirYOs9RTyl9/t1qq7IUr
	 43dBTCqRl/LLQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] erofs: allow page cache sharing
Date: Thu, 03 Jul 2025 14:23:09 +0200
Message-Id: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAC12ZmgC/x2MQQrCMBAAv1L27JYk1RS8Cj7Aq3hI041dxKTsS
 hVK/270OAMzKygJk8KxWUFoYeWSK9hdA3EK+U7IY2Vwxh1Mbzp8F3kgSUmKc1RMPnWj6Z3bGws
 1moUSf/7DK1zOJ7hVOQQlHCTkOP1ez6AvknbxrfUo0cK2fQF8IN9ViAAAAA==
X-Change-ID: 20250703-work-erofs-pcs-f6f3d0722401
To: Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Hongzhen Luo <hongzhen@linux.alibaba.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=7816; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NHj/OgTQbNkxMApIz4EDEZmrS7APXBdmx92p5pBOdY8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkldn3LNzdcLPhTU7mg8KHDbXzfN2NQnS9zJbv2CT5O
 ePMW4fujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImE1TAyfHzqpB54z+zKWc4U
 tstmazxL3s9k3ZE0wX/24kltYj/7TjIyTI/wfCTK+ntTo2L9/4i5FXmcD9bm/mRMcBQr3fp6PZ8
 vBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hey!

This series is originally from Hongzhen. I'm picking it back up because
support for page cache sharing is pretty important for container and
service workloads that want to make use of erofs images. The main
obstacle currently is the inability to share page cache contents between
different erofs superblocks.

I think the mechanism that Hongzhen came up with is decent and will
remove one final obstacle.

However, I have not worked in this area in meaningful ways before so to
an experienced page cache person this might all look like a little kid
doodling on a piece of paper.

One obvious question mark I have is around mmap. The current
implementation mimicks what overlayfs is doing and I'm not sure that
it's correct or even necessary to mimick overlayfs behavior here at all.

Anyway, I would really appreciate the help!

[Background]
============
Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

[Implementation]
================
This introduces the page cache share feature in erofs. During the mkfs
phase, the file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
(indicated by the `ano_inode` field). When a read request occurs, the
anonymous inode serves as a "container" whose page cache is shared. The
actual operations involving the iomap are carried out by the original
inode which is mapped to the anonymous inode.

[Effect]
========
I conducted experiments on two aspects across two different minor versions of
container images:

1. reading all files in two different minor versions of container images 

2. run workloads or use the default entrypoint within the containers^[1]

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the reduced
memory usage varies from 16% to 49%, depending on the specific image.
Additionally, the container's runtime memory usage reduction ranges from 10%
to 48%.

[1] Below are the workload for these images:
	- redis: redis-benchmark
	- postgres: sysbench
	- tensorflow: app.py of tensorflow.python.platform
	- mysql: sysbench
	- nginx: wrk
	- tomcat: default entrypoint

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hongzhen Luo (4):
      erofs: move `struct erofs_anon_fs_type` to super.c
      erofs: introduce page cache share feature
      erofs: apply the page cache share feature
      erofs: introduce .fadvise for page cache share

 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |  67 +++++++++++
 fs/erofs/fscache.c         |  13 ---
 fs/erofs/inode.c           |  15 ++-
 fs/erofs/internal.h        |  11 ++
 fs/erofs/pagecache_share.c | 281 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  22 ++++
 fs/erofs/super.c           |  62 ++++++++++
 fs/erofs/zdata.c           |  32 ++++++
 10 files changed, 500 insertions(+), 14 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250703-work-erofs-pcs-f6f3d0722401


