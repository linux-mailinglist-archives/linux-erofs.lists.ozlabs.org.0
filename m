Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F24BB1DF
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 07:20:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K0M5N5rqtz3cPD
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 17:20:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K0M5D1DGxz3Wtr
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Feb 2022 17:20:45 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V4npfTt_1645165232; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V4npfTt_1645165232) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Feb 2022 14:20:33 +0800
Date: Fri, 18 Feb 2022 14:20:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: fix some style problems
Message-ID: <Yg86r7PmIk0ppU5X@B-P7TQMD6M-0146.local>
References: <20220218031137.18716-1-huangjianan@oppo.com>
 <20220218031137.18716-3-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218031137.18716-3-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Fri, Feb 18, 2022 at 11:11:37AM +0800, Huang Jianan via Linux-erofs wrote:
> Fix some minor issues, including:
>   - Align with the left parenthesis;
>   - Spelling mistakes;
>   - Remove redundant spaces and parenthesis;
>   - clean up file headers;
>   - Match parameters with format parameters.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  dump/main.c                | 53 +++++++++++++++++++-------------------
>  fsck/main.c                |  4 +--
>  fuse/main.c                |  1 -
>  include/erofs/block_list.h |  4 +--
>  include/erofs/defs.h       |  1 -
>  include/erofs/dir.h        |  2 +-
>  include/erofs/internal.h   |  2 +-
>  include/erofs/list.h       |  1 -
>  lib/blobchunk.c            |  2 +-
>  lib/cache.c                |  1 -
>  lib/compress.c             |  2 +-
>  lib/compress_hints.c       |  2 +-
>  lib/compressor_liblzma.c   |  5 ++--
>  lib/data.c                 |  2 +-
>  lib/dir.c                  |  2 +-
>  lib/exclude.c              |  2 +-
>  lib/inode.c                |  2 +-
>  lib/io.c                   |  2 +-
>  lib/liberofs_private.h     |  2 +-
>  lib/namei.c                |  1 -
>  lib/super.c                |  4 +--
>  lib/xattr.c                |  4 +--
>  mkfs/main.c                |  2 +-
>  23 files changed, 48 insertions(+), 55 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index e6198a0..3f8c2f2 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -179,7 +179,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  }
>  
>  static int erofsdump_get_occupied_size(struct erofs_inode *inode,
> -		erofs_off_t *size)
> +				       erofs_off_t *size)

There are two acceptable style (which follows kernel code style),
1) the one is aligned with the parentheses in the previous line;
2) the other is just using two indentations.

So here we actually don't need to update... btw, was it reported
by checkpatch.pl?

Thanks,
Gao Xiang
