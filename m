Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C013A4D7E63
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Mar 2022 10:24:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHB274v57z2ymt
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Mar 2022 20:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=yWfq1hgF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=luodaowen.backend@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=yWfq1hgF; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHB1z651gz2xTd
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Mar 2022 20:24:16 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id 9so12996997pll.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Mar 2022 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZHSHqdSI/jBDMOjHUDo3932A1aQUbEpHtDBEyuk690=;
 b=yWfq1hgFZccKLGWuefVV1mJc4fkOQ/n4zZZqIsZ8pODphn6dXBhPpYMZ3IU+za0xe/
 VtatmqmI3DJJ0X/RGCVAfVKq7CGT1Q/DlLxmqg5bg/AMtX2uoe1OrV5A4QVXrY3z9ITP
 OWgA+kweNNFIan1yFzFk3+vneAZLAOiy25mIqw0eNqFmDST9oZPbxnHOFaa3h0zmIFIY
 6QgJbWx6VClE8tM4W6nT/qff5T2epMd/XdHZg933KIjw1dUSynxJ02gfWIaSdJfLM1R7
 CxOK5W7DggUdJwKIJi4AWxQY2TGsgOitGWTFAfVu80sLwSamFPffPtyyNvyPm0VCD6R4
 ncHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZHSHqdSI/jBDMOjHUDo3932A1aQUbEpHtDBEyuk690=;
 b=k06QRtrlGNv2MMLf1Gz7GmSrjdMPT6K6U7FRTXOdmS6qXlG8Kx7+0lXtRPDI25O8wT
 Ik9o37iYPkJ3XSL6GcRiCnWZ9YFKIr8m3NoytcGWBU5moVe+hkvgjJoApL59Wwcp4V50
 LwEWBC5MDMQUqAnxjrO+9o+Ro30yf4lq1Tnc3LYTSBQiR8bf/OKY2Nfkgc357Ws98QOZ
 QsU0iS7/hlYeNrSNMzn5eIs51sdg2d6akelSTlUnw+LolXW1e3UxJWeYmMgsjgnJqc1G
 UZJljYgzo27nvCorMQ5GL6fYfo1xm4Ujhp+T+JAGJCxpWbht/M6cTTXNuP9a4yqv+NnD
 tJgQ==
X-Gm-Message-State: AOAM531OGJN5/M5mq6fLITgoPGQ4lQ9Yc7pHlPAqKt0//45hyJkZ56Oc
 x+71k2WwYBiF8qCEUdh1yjkgbA==
X-Google-Smtp-Source: ABdhPJyA0G98h1VBptmjEZZwwLqHGgKMVxnl+eFxUnrBeDx78Q8mXd6fuEyQkeky7YM6g6XZqAwhSg==
X-Received: by 2002:a17:903:41c9:b0:153:8a89:de18 with SMTP id
 u9-20020a17090341c900b001538a89de18mr212038ple.32.1647249852246; 
 Mon, 14 Mar 2022 02:24:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a056a00124e00b004f76d35c1dbsm15890636pfi.75.2022.03.14.02.24.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Mar 2022 02:24:11 -0700 (PDT)
From: "luodaowen.backend" <luodaowen.backend@bytedance.com>
To: jefflexu@linux.alibaba.com
Subject: Re: [PATCH v4 00/21] fscache,
 erofs: fscache-based on-demand read semantics
Date: Mon, 14 Mar 2022 17:24:02 +0800
Message-Id: <20220314092402.43044-1-luodaowen.backend@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, torvalds@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

We're also interested in this way, hoping for the formal solution upstream so we can make use of it as well.

Thanks,
daowen

On Mon, 7 Mar 2022 20:32:44 +0800 Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> changes since v3:
> - cachefiles: The current implementation relies on the anonymous fd
> mechanism to avoid
>   the dependence on the format of cache file. When cache file is opened
>   for the first time, an anon_fd associated with the cache file is sent to
>   user daemon. User daemon could fetch and write data to cache file with
>   the given anon_fd. The following write to the anon_fd will finally
>   call to cachefiles kernel module, which will write data to cache file in
>   the latest format of cache file. Thus the on-demand read mode can
>   keep working no matter how cache file format could change in the
>   future. (patch 4)
> - cachefiles: the on-demand read mode reuses the existing
>   "/dev/cachefiles" devnode (patch 3)
> - erofs: squash several commits implementing readahead into single
>   commit (patch 20)
> - erofs: refactor the readahead routine, so that it can read multiple
>   pages each round (patch 20)
> - patch 1 and 7 have already been cherry-picked by the maintainers, but
>   have not been merged to the master. Keep them here for completeness.
>
>
> RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
> v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/
> v2: https://lore.kernel.org/all/2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com/t/
> v3: https://lore.kernel.org/lkml/20220209060108.43051-1-jefflexu@linux.alibaba.com/T/
>
> [Background]
> ============
> Nydus [1] is a container image distribution service specially optimised
> for distribution over network. Nydus is an excellent container image
> acceleration solution, since it only pulls data from remote when it's
> really needed, a.k.a. on-demand reading.
>
> erofs (Enhanced Read-Only File System) is a filesystem specially
> optimised for read-only scenarios. (Documentation/filesystem/erofs.rst)
>
> Recently we are focusing on erofs in container images distribution
> scenario [2], trying to combine it with nydus. In this case, erofs can
> be mounted from one bootstrap file (metadata) with (optional) multiple
> data blob files (data) stored on another local filesystem. (All these
> files are actually image files in erofs disk format.)
>
> To accelerate the container startup (fetching container image from remote
> and then start the container), we do hope that the bootstrap blob file
> could support demand read. That is, erofs can be mounted and accessed
> even when the bootstrap/data blob files have not been fully downloaded.
>
> That means we have to manage the cache state of the bootstrap/data blob
> files (if cache hit, read directly from the local cache; if cache miss,
> fetch the data somehow). It would be painful and may be dumb for erofs to
> implement the cache management itself. Thus we prefer fscache/cachefiles
> to do the cache management. Besides, the demand-read feature shall be
> general and it can benefit other using scenarios if it can be implemented
> in fscache level.
>
> [1] https://nydus.dev
> [2] https://sched.co/pcdL
>
>
> [Overall Design]
> ================
>
> Please refer to patch 6 ("cachefiles: document on-demand read mode") for
> more details.
>
> When working in original mode, cachefiles mainly serves as a local cache for
> remote networking fs, while in on-demand read mode, cachefiles can boost the
> scenario where on-demand read semantics is needed, e.g. container image
> distribution.
>
> The essential difference between these two modes is that, in original mode,
> when cache miss, netfs itself will fetch data from remote, and then write the
> fetched data into cache file. While in on-demand read mode, a user daemon is
> responsible for fetching data and then writing to the cache file.
>
> The on-demand read mode relies on a simple protocol used for communication
> between kernel and user daemon.
>
> The current implementation relies on the anonymous fd mechanism to avoid
> the dependence on the format of cache file. When cache file is opened
> for the first time, an anon_fd associated with the cache file is sent to
> user daemon. With the given anon_fd, user daemon could fetch and write data
> into the cache file in the background, even when kernel has not triggered
> the cache miss. Besides, the write() syscall to the anon_fd will finally
> call cachefiles kernel module, which will write data to cache file in
> the latest format of cache file.
>
> 1. cache miss
> When cache miss, cachefiles kernel module will notify user daemon the
> anon_fd, along with the requested file range. When notified, user dameon
> needs to fetch data of the requested file range, and then write the fetched
> data into cache file with the given anonymous fd. When finished
> processing the request, user daemon needs to notify the kernel.
>
> After notifying the user daemon, the kernel read routine will hang there,
> until the request is handled by user daemon. When it's awaken by the
> notification from user daemon, i.e. the corresponding hole has been filled
> by the user daemon, it will retry to read from the same file range.
>
> 2. cache hit
> Once data is already ready in cache file, netfs will read from cache
> file directly.
>
>
> [Advantage of fscache-based demand-read]
> ========================================
> 1. Asynchronous Prefetch
> In current mechanism, fscache is responsible for cache state management,
> while the data plane (fetch data from local/remote on cache miss) is
> done on the user daemon side.
>
> If data has already been ready in the backing file, the upper fs (e.g.
> erofs) will read from the backing file directly and won't be trapped to
> user space anymore. Thus the user daemon could fetch data (from remote)
> asynchronously on the background, and thus accelerate the backing file
> accessing in some degree.
>
> 2. Support massive blob files
> Besides this mechanism supports a large amount of backing files, and
> thus can benefit the densely employed scenario.
>
> In our using scenario, one container image can correspond to one
> bootstrap file (required) and multiple data blob files (optional). For
> example, one container image for node.js will corresponds to ~20 files
> in total. In densely employed environment, there could be as many as
> hundreds of containers and thus thousands of backing files on one
> machine.
>
>
> [Test]
> ==========
> You could start a quick test by
> https://github.com/lostjeffle/demand-read-cachefilesd
>
>
>
> Jeffle Xu (21):
>   fscache: export fscache_end_operation()
>   cachefiles: export write routine
>   cachefiles: introduce on-demand read mode
>   cachefiles: notify user daemon with anon_fd when opening cache file
>   cachefiles: implement on-demand read
>   cachefiles: document on-demand read mode
>   erofs: use meta buffers for erofs_read_superblock()
>   erofs: export erofs_map_blocks()
>   erofs: add mode checking helper
>   erofs: register global fscache volume
>   erofs: add cookie context helper functions
>   erofs: add anonymous inode managing page cache of blob file
>   erofs: add erofs_fscache_read_pages() helper
>   erofs: register cookie context for bootstrap blob
>   erofs: implement fscache-based metadata read
>   erofs: implement fscache-based data read for non-inline layout
>   erofs: implement fscache-based data read for inline layout
>   erofs: register cookie context for data blobs
>   erofs: implement fscache-based data read for data blobs
>   erofs: implement fscache-based data readahead
>   erofs: add 'uuid' mount option
>
>  .../filesystems/caching/cachefiles.rst        | 159 +++++
>  fs/cachefiles/Kconfig                         |  11 +
>  fs/cachefiles/daemon.c                        | 576 +++++++++++++++++-
>  fs/cachefiles/internal.h                      |  48 ++
>  fs/cachefiles/io.c                            |  72 ++-
>  fs/cachefiles/namei.c                         |  16 +-
>  fs/erofs/Makefile                             |   3 +-
>  fs/erofs/data.c                               |  18 +-
>  fs/erofs/fscache.c                            | 496 +++++++++++++++
>  fs/erofs/inode.c                              |   6 +-
>  fs/erofs/internal.h                           |  30 +
>  fs/erofs/super.c                              | 106 +++-
>  fs/fscache/internal.h                         |  11 -
>  fs/nfs/fscache.c                              |   8 -
>  include/linux/fscache.h                       |  15 +
>  include/linux/netfs.h                         |   1 +
>  include/trace/events/cachefiles.h             |   2 +
>  include/uapi/linux/cachefiles.h               |  48 ++
>  18 files changed, 1526 insertions(+), 100 deletions(-)
>  create mode 100644 fs/erofs/fscache.c
>  create mode 100644 include/uapi/linux/cachefiles.h
>
> --
> 2.27.0
