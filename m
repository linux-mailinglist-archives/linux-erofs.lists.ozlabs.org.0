Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0866191D5
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 08:26:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3XHx65nvz3cMs
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 18:26:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3XHn4jMmz2ywV
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 18:26:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTwBRBs_1667546797;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTwBRBs_1667546797)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 15:26:38 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	xiang@kernel.org,
	chao@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] fscache,cachefiles: add prepare_ondemand_read() interface
Date: Fri,  4 Nov 2022 15:26:35 +0800
Message-Id: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[Rationale]
===========
Fscache has been landed as a generic caching management framework in
the Linux kernel for decades.  It aims to manage cache data availability
or fetch data if needed.  Currently it's mainly used for network fses,
but in principle the main caching subsystem can be used more widely.

We do really like fscache framework and we believe it'd be better to
reuse such framework if possible instead of duplicating other
alternatives for better maintenance and testing.  Therefore for our
container image use cases, we applied the existing fscache to implement
on-demand read for erofs in the past months.  For more details, also see
[1].

In short, here each erofs filesystem is composed of multiple blobs (or
devices).  Each blob corresponds to one fscache cookie to strictly
follow on-disk format and implement the image downloading in a
deterministic manner, which means it has a unique checksum and is signed
by vendors.

Data of each erofs inode can be scattered among multiple blobs (cookie)
since erofs supports chunk-level deduplication.  In this case, each
erofs inode can correspond to multiple cookies, and there's a logical to
physical offset mapping between the logical offset in erofs inode and
the physical offset in the backing file.

As described above, per-cookie netfs model can not be used here
directly.  Instead, we'd like to propose/decouple a simple set of raw
fscache APIs, to access cache for all fses to use.  We believe it's
useful since it's like the relationship between raw bio and iomap, both
of which are useful for local fses.  fscache_read() seems a reasonable
candidate and is enough for such use case.

In addition, the on-demand read feature relies on .prepare_read() to
reuse the hole detecting logic as much as possible. However, after
fscache/netfs rework, libnetfs is preferred to access fscache, making
.prepare_read() closely coupled with libnetfs, or more precisely,
netfs_io_subrequest.


[What We Do]
============
As we discussed previously, we propose a new interface, i,e,
.prepare_ondemand_read() dedicated for the on-demand read scenarios,
which is independent on netfs_io_subrequest. The netfs will still use
the original .prepare_read() as usual.

And as we discussed, in the near future, prepare_read() will get enhanced
and more information will be needed and then returned to callers.  Thus
netfs_io_subrequest is retained as the aggregation for all parameters
needed as the internal implementation inside Cachefiles.


Jingbo Xu (2):
  fscache,cachefiles: add prepare_ondemand_read() callback
  erofs: switch to prepare_ondemand_read() in fscache mode

 fs/cachefiles/io.c                |  42 ++++-
 fs/erofs/fscache.c                | 257 +++++++++++-------------------
 include/linux/netfs.h             |   7 +
 include/trace/events/cachefiles.h |   4 +-
 4 files changed, 135 insertions(+), 175 deletions(-)

-- 
2.19.1.6.gb485710b

