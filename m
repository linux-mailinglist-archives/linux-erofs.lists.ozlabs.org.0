Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84689719D18
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 15:15:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QX67Q1XRKz3dsl
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 23:15:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QX67H6wymz3bZS
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jun 2023 23:15:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vk6DSi9_1685625297;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk6DSi9_1685625297)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 21:14:58 +0800
Message-ID: <036ee477-af3c-14dd-8311-b9117f056542@linux.alibaba.com>
Date: Thu, 1 Jun 2023 21:14:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: support detecting maximum block size
To: Kelvin Zhang <zhangkelvin@google.com>
References: <20230601064647.109292-1-hsiangkao@linux.alibaba.com>
 <CAOSmRziQiG9woUqOffh9NzUM=TRn1jK9vL8OBedQ3pndbB7wHQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOSmRziQiG9woUqOffh9NzUM=TRn1jK9vL8OBedQ3pndbB7wHQ@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/1 20:48, Kelvin Zhang wrote:
> 
> 
> On Thu, Jun 1, 2023 at 2:46 AM Gao Xiang <hsiangkao@linux.alibaba.com <mailto:hsiangkao@linux.alibaba.com>> wrote:
> 
>     Previously PAGE_SIZE was actually unset for most cases so that it was
>     always hard-coded 4096.
> 
>     In order to set EROFS_MAX_BLOCK_SIZE correctly, let's detect the real
>     page size when configuring.
> 
>     Cc: Kelvin Zhang <zhangkelvin@google.com <mailto:zhangkelvin@google.com>>
>     Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com <mailto:hsiangkao@linux.alibaba.com>>

...

> 
>     -#ifndef PAGE_SHIFT
>     -#define PAGE_SHIFT             (12)
>     -#endif
>     -
>       #ifndef PAGE_SIZE
>     -#define PAGE_SIZE              (1U << PAGE_SHIFT)
>     +#define PAGE_SIZE              4096
>       #endif
> 
>     +#ifndef EROFS_MAX_BLOCK_SIZE
>       #define EROFS_MAX_BLOCK_SIZE   PAGE_SIZE
>     +#endif
> 
>       #define EROFS_ISLOTBITS                5
>       #define EROFS_SLOTSIZE         (1U << EROFS_ISLOTBITS)
>     diff --git a/lib/namei.c b/lib/namei.c
>     index 3d0cf93..3751741 100644
>     --- a/lib/namei.c
>     +++ b/lib/namei.c
>     @@ -137,7 +137,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>                      vi->u.chunkbits = sbi.blkszbits +
>                              (vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>              } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
>     -               if (erofs_blksiz() != PAGE_SIZE)
>     +               if (erofs_blksiz() != EROFS_MAX_BLOCK_SIZE)
>                              return -EOPNOTSUPP;
>                      return z_erofs_fill_inode(vi);
>              }
>     diff --git a/mkfs/main.c b/mkfs/main.c
>     index 3ec4903..a6a2d0e 100644
>     --- a/mkfs/main.c
>     +++ b/mkfs/main.c
>     @@ -532,7 +532,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>                      cfg.c_dbg_lvl = EROFS_ERR;
>                      cfg.c_showprogress = false;
>              }
>     -       if (cfg.c_compr_alg[0] && erofs_blksiz() != PAGE_SIZE) {
>     +       if (cfg.c_compr_alg[0] && erofs_blksiz() != EROFS_MAX_BLOCK_SIZE) {
>                      erofs_err("compression is unsupported for now with block size %u",
>                                erofs_blksiz());
>                      return -EINVAL;
>     @@ -670,7 +670,7 @@ static void erofs_mkfs_default_options(void)
>       {
>              cfg.c_showprogress = true;
>              cfg.c_legacy_compress = false;
>     -       sbi.blkszbits = ilog2(PAGE_SIZE);
>     +       sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
>              sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
>              sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
>                                   EROFS_FEATURE_COMPAT_MTIME;
>     -- 
>     2.24.4
> 
> 
> Overall it looks good to me. Do we still need the PAGE_SIZE macro then?

Ok, let's get rid of PAGE_SIZE. Will send the next version.

Thanks,
Gao Xiang

> 
> -- 
> Sincerely,
> 
> Kelvin Zhang
