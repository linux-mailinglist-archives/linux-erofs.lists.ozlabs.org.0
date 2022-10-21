Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD0606DA1
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpD16ZRbz3dql
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpCb2Dnrz2yxd
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:22:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VShP65l_1666318964;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VShP65l_1666318964)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 10:22:46 +0800
Date: Fri, 21 Oct 2022 10:22:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: chenlinxuan <chenlinxuan@uniontech.com>
Subject: Re: A little patch fix dev_read to make it works with large file
Message-ID: <Y1ICczImbJb/lg7N@B-P7TQMD6M-0146.local>
References: <70667519DD94DA0B+b911194e-0b38-9674-eb9f-5ed8d93a3044@uniontech.com>
 <Y1ET0jXRfA7PNEVT@B-P7TQMD6M-0146.local>
 <35DADC97C92E6537+142bad0a-97d1-5327-7188-d26c330ef061@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35DADC97C92E6537+142bad0a-97d1-5327-7188-d26c330ef061@uniontech.com>
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

Hi Linxuan,

I still cannot apply this patch since the patch itself is corrupted.

Could you check out the submitting process
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

And as a reference, could you also check out another
https://lore.kernel.org/linux-erofs/20221013040011.31944-1-zbestahu@gmail.com/
erofs-utils patch compared to your patch here?
https://lore.kernel.org/linux-erofs/35DADC97C92E6537+142bad0a-97d1-5327-7188-d26c330ef061@uniontech.com/

And some minor comments as below:

On Fri, Oct 21, 2022 at 09:37:57AM +0800, chenlinxuan wrote:
> From 83e965dc6ec45e5c9811a27023c9cc213d50816b Mon Sep 17 00:00:00 2001
> From: Chen Linxuan <chenlinxuan@uniontech.com>
> Date: Thu, 20 Oct 2022 17:53:03 +0800
> Subject: [PATCH] erofs-utils: erofs-utils: lib: fix dev_read
> 
> When using `fsck.erofs` to extract some image have a very large file
> inside, for example 2G, my fsck.erofs report some thing like this:
> 
> <E> erofs_io: Failed to read data from device - erofs.image:[4096,
> 2147483648].
> <E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
> <E> erofs: Failed to extract filesystem
> 
> You can use this script to reproduce this issue.
> 
> mkdir tmp extract
> dd if=/dev/urandom of=tmp/big_file bs=1M count=2048
> 
> mkfs.erofs erofs.image tmp
> fsck.erofs erofs.image --extract=extract
> 
> I found that dev_open will failed if we can not get all data we want
> with one pread call.
> 
> I write this little patch try to fix this issue.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  lib/io.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/io.c b/lib/io.c
> index 524cfb4..5cb2b3a 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)
> 
>  int dev_read(int device_id, void *buf, u64 offset, size_t len)
>  {
> -    int ret, fd;
> +    int read_count, fd;
> 
>      if (cfg.c_dry_run)
>          return 0;
> @@ -278,15 +278,29 @@ int dev_read(int device_id, void *buf, u64 offset,
> size_t len)

Here indicates that the patch itself is corrupted.

>          fd = erofs_blobfd[device_id - 1];
>      }
> 
> +    while (len > 0) {
>  #ifdef HAVE_PREAD64
> -    ret = pread64(fd, buf, len, (off64_t)offset);
> +        read_count = pread64(fd, buf, len, (off64_t)offset);
>  #else
> -    ret = pread(fd, buf, len, (off_t)offset);
> +        read_count = pread(fd, buf, len, (off_t)offset);
>  #endif
> -    if (ret != (int)len) {
> -        erofs_err("Failed to read data from device - %s:[%" PRIu64 ",
> %zd].",
> -              erofs_devname, offset, len);
> -        return -errno;
> +        if (read_count == -1 || read_count == 0) {
> +            if (errno) {
> +                erofs_err("Failed to read data from device - "
> +                      "%s:[%" PRIu64 ", %zd].",

It'd be better not to separate the print line for easy grep.

> +                      erofs_devname, offset, len);
> +                return -errno;
> +            } else {
> +                erofs_err("Reach EOF of device - "
> +                      "%s:[%" PRIu64 ", %zd].",

same here.


Thanks,
Gao Xiang
