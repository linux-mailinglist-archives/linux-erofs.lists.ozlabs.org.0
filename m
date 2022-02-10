Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3B4B05F1
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 06:58:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JvQzC5nQNz3bV8
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 16:58:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JvQz53BKLz2yN3
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Feb 2022 16:58:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V42eJYQ_1644472693; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V42eJYQ_1644472693) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 13:58:15 +0800
Date: Thu, 10 Feb 2022 13:58:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [Linux-cachefs] [PATCH v3 00/22] fscache,	erofs: fscache-based
 demand-read semantics
Message-ID: <YgSpdW1LjK2901ix@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
 xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
 willy@infradead.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, torvalds@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Wed, Feb 09, 2022 at 02:00:46PM +0800, Jeffle Xu wrote:

...

> 
> 
> Jeffle Xu (22):
>   fscache: export fscache_end_operation()
>   fscache: add a method to support on-demand read semantics
>   cachefiles: extract generic function for daemon methods
>   cachefiles: detect backing file size in on-demand read mode
>   cachefiles: introduce new devnode for on-demand read mode

...

> 
>  Documentation/filesystems/netfs_library.rst |  18 +
>  fs/cachefiles/Kconfig                       |  13 +
>  fs/cachefiles/daemon.c                      | 243 +++++++++--
>  fs/cachefiles/internal.h                    |  12 +
>  fs/cachefiles/io.c                          |  60 +++
>  fs/cachefiles/main.c                        |  27 ++
>  fs/cachefiles/namei.c                       |  60 ++-

Would you mind taking a review at this version? We follow your previous
advices written in v2 and it reuses almost all cachefiles code except
that it has slightly different implication of cachefile file size and
a new daemon node.

I think it could be as the first step to implement fscache-based
on-demand read.

Thanks,
Gao Xiang

