Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAA605B0F
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 11:24:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtMcz3cNVz3cfB
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 20:24:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.17; helo=out199-17.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtMcs647tz3bkx
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 20:24:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VSebxmE_1666257876;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSebxmE_1666257876)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 17:24:37 +0800
Date: Thu, 20 Oct 2022 17:24:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: chenlinxuan <chenlinxuan@uniontech.com>
Subject: Re: A little patch fix dev_read to make it works with large file
Message-ID: <Y1ET0jXRfA7PNEVT@B-P7TQMD6M-0146.local>
References: <70667519DD94DA0B+b911194e-0b38-9674-eb9f-5ed8d93a3044@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70667519DD94DA0B+b911194e-0b38-9674-eb9f-5ed8d93a3044@uniontech.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi LinXuan,

On Thu, Oct 20, 2022 at 04:12:57PM +0800, chenlinxuan wrote:
> When using `fsck.erofs` to extract some image have a very large file (3G)
> inside, my fsck.erofs report some thing like:
> 
> <E> erofs_io: Failed to read data from device - erofs.image:[4096,
> 2147483648].
> <E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
> <E> erofs: Failed to extract filesystem
> 
> You can use this script to reproduce this issue.
> 
> #!/bin/env sh
> 
> mkdir tmp extract
> dd if=/dev/urandom of=tmp/big_file bs=1M count=2048
> 
> mkfs.erofs erofs.image tmp
> fsck.erofs erofs.image --extract=extract
> 
> I found that dev_open will failed if we can not get all data we want with
> one pread call.
> 
> I write this little patch try to fix this issue.
> 
> This is my first patch send via email, sorry if anything goes wrong.
> 

Thanks for your report, and the issue looks true.

In order to merge this patch, could you apply the message above into
the commit message?

BTW, the commit message can be updated with "git commit --amend".

> From 156af5b173c1f9e2a91e4d2126214b96966babd1 Mon Sep 17 00:00:00 2001
> From: chenlinxuan <chenlinxuan@uniontech.com>

It would be better to update your real name into
"Linxuan Chen" Or "Chen Linxuan" (whichever you prefer).

> Date: Thu, 20 Oct 2022 14:39:17 +0800
> Subject: [PATCH] erofs-utils: lib: fix dev_read

Subject title:
"erofs-utils: lib: fix dev_read to make it works with large file"

> 
> We need to keep calling pread until we get all data we want
> ---
>  lib/io.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/io.c b/lib/io.c
> index 524cfb4..bd3d790 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)
> 
>  int dev_read(int device_id, void *buf, u64 offset, size_t len)
>  {
> -   int ret, fd;
> +   int read_count, fd;
> 
>     if (cfg.c_dry_run)
>         return 0;
> @@ -278,15 +278,29 @@ int dev_read(int device_id, void *buf, u64 offset,
> size_t len)
>         fd = erofs_blobfd[device_id - 1];
>     }
> 
> +   while (len > 0) {
>  #ifdef HAVE_PREAD64
> -   ret = pread64(fd, buf, len, (off64_t)offset);
> +       read_count = pread64(fd, buf, len, (off64_t)offset);
>  #else
> -   ret = pread(fd, buf, len, (off_t)offset);
> +       read_count = pread(fd, buf, len, (off_t)offset);
>  #endif
> -   if (ret != (int)len) {
> -       erofs_err("Failed to read data from device - %s:[%" PRIu64 ",
> %zd].",
> -             erofs_devname, offset, len);
> -       return -errno;
> +       if (read_count == -1 || read_count ==  0) {

                                                ^ extra space here.

Thanks,
Gao Xiang
