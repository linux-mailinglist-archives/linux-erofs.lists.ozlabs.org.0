Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4AA508418
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Apr 2022 10:52:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KjvZF1Ldrz2ync
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Apr 2022 18:52:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=mbGxrA17;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=zhujia.zj@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=mbGxrA17; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KjvZ56Y3Qz2xnM
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Apr 2022 18:52:27 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id g3so401571pgg.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Apr 2022 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=2LGRC6pWV6Ywn7mMz+zxUWN4pMWlUSKe4QJbsCplYOw=;
 b=mbGxrA176xHUVjxIkKmvtkl8gf2PHj5pMPqXX1I+EkwBha5KQZ7sMPWkxxdk+0S3DK
 /K2019Ckz2UMkMNp4yFC3rM+xP3sUHPxWwoJAf4AWZCX0AConofervJhP+nGybKQRs/S
 G82ScgW45heS79VLocu+aF4wTd6IDMWn+KftIPpsRhJTvTW8O5UqKoRuwHKsQQrh/HG9
 iDPDUMpOxFw05Bido6kkk0gxHzKX6mu2ut06j5dPBZp/041X8joe8UKf+JEwgXSpqg6w
 giQ7MQ9W4L3ABRFjZ5CjxyQM6y0KeEftDvqPXWS3Vwvkakm8A+iDrqwDCpG72TMZawhQ
 i/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2LGRC6pWV6Ywn7mMz+zxUWN4pMWlUSKe4QJbsCplYOw=;
 b=Yz3gXXhM7SOMwFOvTBhCaL1uRDCXCSwZXY9rV2/5qDP9hdxIjG6X+qC3rwcYopb9CD
 icUYhu1QgcglA5DhRu3mGufFCixYBAt0vFlQvszCP5SkJOUmlQy5dXB4/iwuYm97H3W/
 ONcY1XwJ/3zo8btpQYM/hDD/zYwBqLLw7RGx1O5HGL3mEwN2oNiqXOw6SkO0m3mKzfuL
 gP39BTxkWnnfbUotNFLW6NjfG/pafDYxePMFalvWuX6XMvwkoYS8A1U2H3V8ra52Ras2
 BSzwi7LbR5dE65LKf4Yarz1ml44ZlTLtYQoHPoJD3qnQhdhIgJB/itrPr6qzCZdH5j0W
 MvhQ==
X-Gm-Message-State: AOAM531A/GgcUf8wQ9MU55w/QHHMdzmQJOXI2wLIdkqK5Lmkm8k4gUyv
 VW7qQbd8yzK0smn+MBwQEVsT+g==
X-Google-Smtp-Source: ABdhPJxDum90+rP9lDhOHilJaUU2EM8vLj6g8aSQheb52Th5oWgmS+xVi7Wr68uLh+gVI1rcN058YQ==
X-Received: by 2002:a63:3fcb:0:b0:3aa:36aa:33e8 with SMTP id
 m194-20020a633fcb000000b003aa36aa33e8mr6631178pga.492.1650444745388; 
 Wed, 20 Apr 2022 01:52:25 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm20589421pfl.15.2022.04.20.01.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 01:52:25 -0700 (PDT)
Message-ID: <0cf8740a-cb1d-756d-01f2-b4e53fe2a63e@bytedance.com>
Date: Wed, 20 Apr 2022 16:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v9 00/21] fscache, erofs: fscache-based on-demand read
 semantics
To: Jeffle Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
From: JiaZhu <zhujia.zj@bytedance.com>
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: dhowells@redhat.com, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org, fannaihao@baidu.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, tianzichen@kuaishou.com, joseph.qi@linux.alibaba.com,
 zhangjiachen.jaycee@bytedance.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 4/15/22 8:35 PM, Jeffle Xu 写道:
> changes since v8:
> - rebase to 5.18-rc2
> - cachefiles: use object_id rather than anon_fd to uniquely identify a
>    cachefile object to avoid potential issues when the user moves the
>    anonymous fd around, e.g. through dup() (refer to commit message and
>    cachefiles_ondemand_get_fd() of patch 2 for more details)
>    (David Howells)
> - cachefiles: add @unbind_pincount refcount to avoid the potential deadlock
>    (refer to commit message of patch3 for more details)
> - cachefiles: move the calling site of cachefiles_ondemand_read() from
>    cachefiles_read() to cacehfiles_prep_read() (refer to commit message
>    of patch 5 for more details)
> - cachefiles: add tracepoints (patch 7) (David Howells)
> - cachefiles: update documentation (patch 8) (David Howells)
> - erofs: update Reviewed-by tag from Gao Xiang
> - erofs: move the logic of initializing bdev/dax_dev in fscache mode out
>    from patch 15/20. Instead move it into patch 9, so that patch 20 can
>    focus on the mount option handling
> - erofs: update the subject line and commit message of patch 12 (Gao
>    Xiang)
> - erofs: remove and fold erofs_fscache_get_folio() helper (patch 16)
>    (Gao Xiang)
> - erofs: change kmap() to kamp_loacl_folio(), and comment cleanup (patch
>    18) (Gao Xiang)
> - update "advantage of fscache-based on-demand read" section of the
>    cover letter
> - we've finished a preliminary end-to-end on-demand download daemon in
>    order to test the fscache on-demand kernel code as a real end-to-end
>    workload for container use cases. The test user guide is added in the
>    cover letter.
> - Thanks Zichen Tian for testing
>    Tested-by: Zichen Tian <tianzichen@kuaishou.com>
> 
> 
> Kernel Patchset
> ---------------
> Git tree:
> 
>      https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v9
> 
> Gitweb:
> 
>      https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v9
> 
> 
> User Guide for E2E Container Use Case
> -------------------------------------
> User guide:
> 
>      https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
> 
> Video:
> 
>      https://youtu.be/F4IF2_DENXo
> 
> 
> User Daemon for Quick Test
> --------------------------
> Git tree:
> 
>      https://github.com/lostjeffle/demand-read-cachefilesd.git main
> 
> Gitweb:
> 
>      https://github.com/lostjeffle/demand-read-cachefilesd
> 
> 
> RFC: https://lore.kernel.org/all/YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local/t/
> v1: https://lore.kernel.org/lkml/47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com/T/
> v2: https://lore.kernel.org/all/2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com/t/
> v3: https://lore.kernel.org/lkml/20220209060108.43051-1-jefflexu@linux.alibaba.com/T/
> v4: https://lore.kernel.org/lkml/20220307123305.79520-1-jefflexu@linux.alibaba.com/T/#t
> v5: https://lore.kernel.org/lkml/202203170912.gk2sqkaK-lkp@intel.com/T/
> v6: https://lore.kernel.org/lkml/202203260720.uA5o7k5w-lkp@intel.com/T/
> v7: https://lore.kernel.org/lkml/557bcf75-2334-5fbb-d2e0-c65e96da566d@linux.alibaba.com/T/
> v8: https://lore.kernel.org/all/ac8571b8-0935-1f4f-e9f1-e424f059b5ed@linux.alibaba.com/T/
> 
> 
> [Background]
> ============
> Nydus [1] is an image distribution service especially optimized for
> distribution over network. Nydus is an excellent container image
> acceleration solution, since it only pulls data from remote when needed,
> a.k.a. on-demand reading and it also supports chunk-based deduplication,
> compression, etc.
> 
> erofs (Enhanced Read-Only File System) is a filesystem designed for
> read-only scenarios. (Documentation/filesystem/erofs.rst)
> 
> Over the past months we've been focusing on supporting Nydus image service
> with in-kernel erofs format[2]. In that case, each container image will be
> organized in one bootstrap (metadata) and (optional) multiple data blobs in
> erofs format. Massive container images will be stored on one machine.
> 
> To accelerate the container startup (fetching container images from remote
> and then start the container), we do hope that the bootstrap & blob files
> could support on-demand read. That is, erofs can be mounted and accessed
> even when the bootstrap/data blob files have not been fully downloaded.
> Then it'll have native performance after data is available locally.
> 
> That means we have to manage the cache state of the bootstrap/data blob
> files (if cache hit, read directly from the local cache; if cache miss,
> fetch the data somehow). It would be painful and may be dumb for erofs to
> implement the cache management itself. Thus we prefer fscache/cachefiles
> to do the cache management instead.
> 
> The fscache on-demand read feature aims to be implemented in a generic way
> so that it can benefit other use cases and/or filesystems if it's
> implemented in the fscache subsystem.
> 
> [1] https://nydus.dev
> [2] https://sched.co/pcdL
> 
> 
> [Overall Design]
> ================
> Please refer to patch 7 ("cachefiles: document on-demand read mode") for
> more details.
> 
> When working in the original mode, cachefiles mainly serves as a local cache
> for remote networking fs, while in on-demand read mode, cachefiles can work
> in the scenario where on-demand read semantics is needed, e.g. container image
> distribution.
> 
> The essential difference between these two modes is that, in original mode,
> when cache miss, netfs itself will fetch data from remote, and then write the
> fetched data into cache file. While in on-demand read mode, a user daemon is
> responsible for fetching data and then feeds to the kernel fscache side.
> 
> The on-demand read mode relies on a simple protocol used for communication
> between kernel and user daemon.
> 
> The proposed implementation relies on the anonymous fd mechanism to avoid
> the dependence on the format of cache file. When a fscache cachefile is opened
> for the first time, an anon_fd associated with the cache file is sent to the
> user daemon. With the given anon_fd, user daemon could fetch and write data
> into the cache file in the background, even when kernel has not triggered the
> cache miss. Besides, the write() syscall to the anon_fd will finally call
> cachefiles kernel module, which will write data to cache file in the latest
> format of cache file.
> 
> 1. cache miss
> When cache miss, cachefiles kernel module will notify user daemon with the
> anon_fd, along with the requested file range. When notified, user daemon
> needs to fetch data of the requested file range, and then write the fetched
> data into cache file with the given anonymous fd. When finished processing
> the request, user daemon needs to notify the kernel.
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
> [Advantage of fscache-based on-demand read]
> ========================================
> 1. Asynchronous prefetch
> In current mechanism, fscache is responsible for cache state management,
> while the data plane (fetching data from local/remote on cache miss) is
> done on the user daemon side even without any file system request driven.
> In addition, if cached data has already been available locally, fscache
> will use it instead of trapping to user space anymore.
> 
> Therefore, different from event-driven approaches, the fscache on-demand
> user daemon could also fetch data (from remote) asynchronously in the
> background just like most multi-threaded HTTP downloaders.
> 
> 2. Flexible request amplification
> Since the data plane can be independently controlled by the user daemon,
> the user daemon can also fetch more data from remote than that the file
> system actually requests for small I/O sizes. Then, fetched data in bulk
> will be available at once and fscache won't be trapped into the user
> daemon again.
> 
> 3. Support massive blobs
> This mechanism can naturally support a large amount of backing files,
> and thus can benefit the densely employed scenarios. In our use cases,
> one container image can be formed of one bootstrap (required) and
> multiple chunk-deduplicated data blobs (optional).
> 
> For example, one container image for node.js will correspond to ~20
> files in total. In densely employed environment, there could be hundreds
> of containers and thus thousands of backing files on one machine.
> 
> 
> 
> 
> Jeffle Xu (21):
>    cachefiles: extract write routine
>    cachefiles: notify user daemon when looking up cookie
>    cachefiles: unbind cachefiles gracefully in on-demand mode
>    cachefiles: notify user daemon when withdrawing cookie
>    cachefiles: implement on-demand read
>    cachefiles: enable on-demand read mode
>    cachefiles: add tracepoints for on-demand read mode
>    cachefiles: document on-demand read mode
>    erofs: make erofs_map_blocks() generally available
>    erofs: add fscache mode check helper
>    erofs: register fscache volume
>    erofs: add fscache context helper functions
>    erofs: add anonymous inode caching metadata for data blobs
>    erofs: add erofs_fscache_read_folios() helper
>    erofs: register fscache context for primary data blob
>    erofs: register fscache context for extra data blobs
>    erofs: implement fscache-based metadata read
>    erofs: implement fscache-based data read for non-inline layout
>    erofs: implement fscache-based data read for inline layout
>    erofs: implement fscache-based data readahead
>    erofs: add 'fsid' mount option
> 
>   .../filesystems/caching/cachefiles.rst        | 170 ++++++
>   fs/cachefiles/Kconfig                         |  11 +
>   fs/cachefiles/Makefile                        |   1 +
>   fs/cachefiles/daemon.c                        | 116 +++-
>   fs/cachefiles/interface.c                     |   2 +
>   fs/cachefiles/internal.h                      |  74 +++
>   fs/cachefiles/io.c                            |  76 ++-
>   fs/cachefiles/namei.c                         |  16 +-
>   fs/cachefiles/ondemand.c                      | 496 ++++++++++++++++++
>   fs/erofs/Kconfig                              |  10 +
>   fs/erofs/Makefile                             |   1 +
>   fs/erofs/data.c                               |  26 +-
>   fs/erofs/fscache.c                            | 365 +++++++++++++
>   fs/erofs/inode.c                              |   4 +
>   fs/erofs/internal.h                           |  49 ++
>   fs/erofs/super.c                              | 105 +++-
>   fs/erofs/sysfs.c                              |   4 +-
>   include/linux/fscache.h                       |   1 +
>   include/linux/netfs.h                         |   2 +
>   include/trace/events/cachefiles.h             | 176 +++++++
>   include/uapi/linux/cachefiles.h               |  68 +++
>   21 files changed, 1694 insertions(+), 79 deletions(-)
>   create mode 100644 fs/cachefiles/ondemand.c
>   create mode 100644 fs/erofs/fscache.c
>   create mode 100644 include/uapi/linux/cachefiles.h
> 
Hi Jeffle & Xiang,

Thanks for coming up with such an innovative solution. We interested in
this and want to deploy it in our system. So we have performed the tests
by user guide and did some error injection tests using User Daemon Demo
offered by Jeffle. Hope it can be an upstream feature.

Thanks,
Jia

Tested-by: Jia Zhu <zhujia.zj@bytedance.com>
