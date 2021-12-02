Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9646621C
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 12:12:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4YG04Zttz2yYJ
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 22:12:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4YFt07XTz2yYJ
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 22:12:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UzAdNtw_1638443540; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UzAdNtw_1638443540) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 02 Dec 2021 19:12:21 +0800
Date: Thu, 2 Dec 2021 19:12:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs-utils: add Apache 2.0 license
Message-ID: <YaiqE08wyC3oBsr0@B-P7TQMD6M-0146>
References: <Yaeq51nipFpzhD7r@B-P7TQMD6M-0146.local>
 <20211202022521.4291-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202022521.4291-1-huangjianan@oppo.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 02, 2021 at 10:25:21AM +0800, Huang Jianan wrote:
> Let's release liberofs under GPL-2.0+ OR Apache-2.0 license for
> better integration.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  include/erofs/blobchunk.h      | 2 +-
>  include/erofs/block_list.h     | 2 +-
>  include/erofs/cache.h          | 2 +-
>  include/erofs/compress.h       | 2 +-
>  include/erofs/compress_hints.h | 2 +-
>  include/erofs/config.h         | 2 +-
>  include/erofs/decompress.h     | 2 +-
>  include/erofs/defs.h           | 2 +-
>  include/erofs/err.h            | 2 +-
>  include/erofs/exclude.h        | 2 +-
>  include/erofs/inode.h          | 2 +-
>  include/erofs/internal.h       | 2 +-
>  include/erofs/io.h             | 2 +-
>  include/erofs/list.h           | 2 +-
>  include/erofs/print.h          | 2 +-
>  include/erofs/trace.h          | 2 +-
>  include/erofs/xattr.h          | 2 +-
>  lib/Makefile.am                | 2 +-
>  lib/blobchunk.c                | 2 +-
>  lib/block_list.c               | 2 +-
>  lib/cache.c                    | 2 +-
>  lib/compress.c                 | 2 +-
>  lib/compress_hints.c           | 2 +-
>  lib/compressor.c               | 2 +-
>  lib/compressor.h               | 2 +-
>  lib/compressor_liblzma.c       | 2 +-
>  lib/compressor_lz4.c           | 2 +-
>  lib/compressor_lz4hc.c         | 2 +-
>  lib/config.c                   | 2 +-
>  lib/data.c                     | 2 +-
>  lib/decompress.c               | 2 +-
>  lib/exclude.c                  | 2 +-
>  lib/inode.c                    | 2 +-
>  lib/io.c                       | 2 +-
>  lib/namei.c                    | 2 +-
>  lib/super.c                    | 2 +-
>  lib/xattr.c                    | 2 +-
>  lib/zmap.c                     | 2 +-
