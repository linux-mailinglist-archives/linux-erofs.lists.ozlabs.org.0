Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93078E6E9
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 08:59:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbsVG32H9z30fk
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 16:59:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbsV65RPNz2yVR
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 16:59:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqxItNL_1693465173;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqxItNL_1693465173)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 14:59:34 +0800
Message-ID: <3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com>
Date: Thu, 31 Aug 2023 14:59:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: EROFS sometimes not filling tail page with zeroes
To: keltargw <keltar.gw@gmail.com>
References: <CALFUNyn18RW6xx4KAuqexRYw=zezMQf=yy9-XN+_FOmaGjmgDA@mail.gmail.com>
 <8ff7509a-610a-bdcf-4163-31d2c0e24514@linux.alibaba.com>
 <CALFUNymd3kTVLKR8xBYa1BvDeEu=jmTagSzV7xe0x0gsFg_Uog@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CALFUNymd3kTVLKR8xBYa1BvDeEu=jmTagSzV7xe0x0gsFg_Uog@mail.gmail.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(+cc erofs mailing list)

On 2023/8/31 14:32, keltargw wrote:
> My test program is this:
> 
> #include <stdio.h>
> #include <fcntl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <sys/io.h>
> #include <sys/mman.h>
> 
> int main(int argc, char const *argv[])
> {
>      unsigned char *f;
>      int size;
>      struct stat s;
>      const char * file_name = argv[1];
>      int fd = open (argv[1], O_RDONLY);
>      if(!fd) {
>          return 0;
>      }
> 
>      int status = fstat (fd, & s);
>      size = s.st_size;
>      if(!(s.st_mode & S_IFREG)) {
>          return 0;
>      }
> 
>      f = (char *) mmap (0, size, PROT_READ, MAP_PRIVATE, fd, 0);
>      if(!f) {
>          return 0;
>      }
> #if 0
>      for(int i = 0; i < 128; ++i) {
>          fprintf(stderr, "%x(%c) ", f[size+i-64], f[size+i-64]);
>      }
>      fprintf(stderr, "\n");
> #endif
>      if(size % 4096 && f[size] != 0) {
>          fprintf(stderr, "%s failure\n", argv[1]);
>          return 1;
>      }
> 
>      return 0;
> }
> 
> 
> I run it on known "wrong" files, or via `finderofs_mount_point -type f -exec ./mmap_test {} \;` for the entire file system.
> 
> The patch you suggested seems to fix the issue, it is no longer reproducible or any file.

Actually I think this issue was fixed in commit e4c1cf523d82
("erofs: tidy up z_erofs_do_read_page()") by accident:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=e4c1cf523d820730a86cae2c6d55924833b6f7ac

So it seems that it will be fixed in v6.6-rc1.

Let me find a way to backport this partial part to old LTS
kernels.

Thanks,
Gao Xiang

> 
> Thanks!
> 
> 
> On Thu, 31 Aug 2023 at 05:06, Gao Xiang <hsiangkao@linux.alibaba.com <mailto:hsiangkao@linux.alibaba.com>> wrote:
> 
>     Hi,
> 
>     On 2023/8/30 18:24, keltargw wrote:
>      > Hello. I'm not sure if you're the right person to ask this about, I noticed most of erofs commits are done by you. I noticed problematic behaviour of EROFS driver with LZ4 compression enabled: on some files, if I do mmap(), the tail of the last page (after file ends) is not filled with zeroes but contains something gabage-like. This breaks e.g. clang-cpp as it uses mmap extensively, if headers are stored in lz4-compressed erofs. In my observations, it happens if file is lz4 compressed but last segment (not sure what terminology is used there) is not. It happens all the times on e.g. `/usr/include/stdlib.h` and `/usr/include/wchar.h`, as well as `/usr/include/linux/fs.h` (but on this file it is triggered a bit differently), and many other files. In my test I packed my entire system to lz4hc erofs (different lz4 options trigger problem on different files) and mounted it to subdirectory, but I could reproduce it on different distros and on latest 6.5 kernel. It is not
>      > reproducible on uncompressed erofs.
>      > I've deduced the problem to this small patch, but while it fixes the problem it doesn't look like it is the best place to do zeroing. Could you take a look at it please?
> 
>     I think it may have the issue but do you have some simple
>     mmap reproducer for me to try if any?  Otherwise, I have
>     to write a reproducer myself.
> 
>      >
>      > If this is not appropriate way to communicate or I should've asked a different person, could you please direct me the right way?
> 
>     Nope, I will check the issue.  Could you check if the
>     following diff fixes your problem:
> 
>     diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>     index de4f12152b62..9c9350eb1704 100644
>     --- a/fs/erofs/zdata.c
>     +++ b/fs/erofs/zdata.c
>     @@ -1038,6 +1038,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>              cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
>              if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>                      zero_user_segment(page, cur, end);
>     +               ++spiltted;
>     +               tight = false;
>                      goto next_part;
>              }
>              if (map->m_flags & EROFS_MAP_FRAGMENT) {
> 
>     Thanks,
>     Gao Xiang
> 
