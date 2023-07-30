Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646B7685D3
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:49:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDN5v39N9z2yFD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:49:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDN5r2zm5z2y1b
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:49:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VoVv5KT_1690724968;
Received: from 192.168.75.41(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoVv5KT_1690724968)
          by smtp.aliyun-inc.com;
          Sun, 30 Jul 2023 21:49:29 +0800
Message-ID: <07c85385-be34-8fdc-876c-dc97639c5643@linux.alibaba.com>
Date: Sun, 30 Jul 2023 21:49:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4] erofs: DEFLATE compression support
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20230713001441.30462-1-hsiangkao@linux.alibaba.com>
 <20230716091940.40899-1-hsiangkao@linux.alibaba.com>
 <9570176a-02c2-c500-14c6-b8ca220cfb96@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9570176a-02c2-c500-14c6-b8ca220cfb96@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/30 20:53, Chao Yu wrote:
> On 2023/7/16 17:19, Gao Xiang wrote:
>> Add DEFLATE compression as the 3rd supported algorithm.
>>
>> DEFLATE is a popular generic-purpose compression algorithm for quite
>> long time (many advanced formats like gzip, zlib, zip, png are all
>> based on that) as Apple documentation written "If you require
>> interoperability with non-Apple devices, use COMPRESSION_ZLIB. [1]".
>>
>> Due to its popularity, there are several hardware on-market DEFLATE
>> accelerators, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
>> accelerator, etc.  In addition, there are also several high-performence
>> IP cores and even open-source FPGA approches available for DEFLATE.
>> Therefore, it's useful to support DEFLATE compression in order to find
>> a way to utilize these accelerators for asynchronous I/Os and get
>> benefits from these later.
>>
>> Besides, it's a good choice to trade off between compression ratios
>> and performance compared to LZ4 and LZMA.  The DEFLATE core format is
>> simple as well as easy to understand, therefore the code size of its
>> decompressor is small even for the bootloader use cases.  The runtime
>> memory consumption is quite limited too (e.g. 32K + ~7K for each zlib
>> stream).  As usual, EROFS ourperforms similar approaches too.
>>
>> Alternatively, DEFLATE could still be used for some specific files
>> since EROFS supports multiple compression algorithms in one image.
>>
>> [1] https://developer.apple.com/documentation/compression/compression_algorithm
>> ---
>> changes since v3:
>>   - fix 'insz' mis-calculation, which leads to failure on 4k pclusters.
>>
>>   fs/erofs/Kconfig                |  15 ++
>>   fs/erofs/Makefile               |   1 +
>>   fs/erofs/compress.h             |   2 +
>>   fs/erofs/decompressor.c         |   6 +
>>   fs/erofs/decompressor_deflate.c | 250 ++++++++++++++++++++++++++++++++
>>   fs/erofs/erofs_fs.h             |   7 +
>>   fs/erofs/internal.h             |  20 +++
>>   fs/erofs/super.c                |  10 ++
>>   fs/erofs/zmap.c                 |   5 +-
>>   9 files changed, 314 insertions(+), 2 deletions(-)
>>   create mode 100644 fs/erofs/decompressor_deflate.c
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index f259d92c9720..56a99ba8ce22 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
>>         If unsure, say N.
>> +config EROFS_FS_ZIP_DEFLATE
>> +    bool "EROFS DEFLATE compressed data support"
>> +    depends on EROFS_FS_ZIP
>> +    select ZLIB_INFLATE
>> +    help
>> +      Saying Y here includes support for reading EROFS file systems
>> +      containing DEFLATE compressed data.  It gives better compression
>> +      ratios than the default LZ4 format, while it costs more CPU
>> +      overhead.
>> +
>> +      DEFLATE support is an experimental feature for now and so most
>> +      file systems will be readable without selecting this option.
>> +
>> +      If unsure, say N.
>> +
>>   config EROFS_FS_ONDEMAND
>>       bool "EROFS fscache-based on-demand read support"
>>       depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index a3a98fc3e481..994d0b9deddf 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -5,4 +5,5 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
>>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>> +erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
>> index b1b846504027..349c3316ae6b 100644
>> --- a/fs/erofs/compress.h
>> +++ b/fs/erofs/compress.h
>> @@ -94,4 +94,6 @@ extern const struct z_erofs_decompressor erofs_decompressors[];
>>   /* prototypes for specific algorithms */
>>   int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>>                   struct page **pagepool);
>> +int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>> +                   struct page **pagepool);
>>   #endif
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index cfad1eac7fd9..332ec5f74002 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -379,4 +379,10 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
>>           .name = "lzma"
>>       },
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
>> +    [Z_EROFS_COMPRESSION_DEFLATE] = {
>> +        .decompress = z_erofs_deflate_decompress,
>> +        .name = "deflate"
>> +    },
>> +#endif
>>   };
>> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
>> new file mode 100644
>> index 000000000000..c34e29b15465
>> --- /dev/null
>> +++ b/fs/erofs/decompressor_deflate.c
>> @@ -0,0 +1,250 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include <linux/module.h>
>> +#include <linux/zlib.h>
>> +#include "compress.h"
>> +
>> +struct z_erofs_deflate {
>> +    struct z_erofs_deflate *next;
>> +    struct z_stream_s z;
>> +    u8 bounce[PAGE_SIZE];
>> +};
>> +
>> +static DEFINE_SPINLOCK(z_erofs_deflate_lock);
>> +static unsigned int z_erofs_deflate_nstrms, z_erofs_deflate_avail_strms;
>> +static struct z_erofs_deflate *z_erofs_deflate_head;
>> +static DECLARE_WAIT_QUEUE_HEAD(z_erofs_deflate_wq);
>> +
>> +module_param_named(deflate_streams, z_erofs_deflate_nstrms, uint, 0444);
>> +
>> +void z_erofs_deflate_exit(void)
>> +{
>> +    /* there should be no running fs instance */
>> +    while (z_erofs_deflate_avail_strms) {
>> +        struct z_erofs_deflate *strm;
>> +
>> +        spin_lock(&z_erofs_deflate_lock);
>> +        strm = z_erofs_deflate_head;
>> +        if (!strm) {
>> +            spin_unlock(&z_erofs_deflate_lock);
>> +            DBG_BUGON(1);
>> +            return;
>> +        }
>> +        z_erofs_deflate_head = NULL;
>> +        spin_unlock(&z_erofs_deflate_lock);
>> +
>> +        while (strm) {
>> +            struct z_erofs_deflate *n = strm->next;
>> +
>> +            vfree(strm->z.workspace);
>> +            kfree(strm);
>> +            --z_erofs_deflate_avail_strms;
>> +            strm = n;
>> +        }
>> +    }
>> +}
>> +
>> +int __init z_erofs_deflate_init(void)
>> +{
>> +    /* by default, use # of possible CPUs instead */
>> +    if (!z_erofs_deflate_nstrms)
>> +        z_erofs_deflate_nstrms = num_possible_cpus();
>> +
>> +    for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
>> +         ++z_erofs_deflate_avail_strms) {
>> +        struct z_erofs_deflate *strm;
>> +
>> +        strm = kzalloc(sizeof(*strm), GFP_KERNEL);
>> +        if (!strm)
>> +            goto out_failed;
>> +
>> +        /* XXX: in-kernel zlib cannot shrink windowbits currently */
>> +        strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
>> +        if (!strm->z.workspace)
> 
> kfree(strm)?

z_erofs_deflate_exit() below will handle this.

Thanks,
Gao Xiang

> 
> Thanks,
> 
>> +            goto out_failed;
>> +
>> +        spin_lock(&z_erofs_deflate_lock);
>> +        strm->next = z_erofs_deflate_head;
>> +        z_erofs_deflate_head = strm;
>> +        spin_unlock(&z_erofs_deflate_lock);
>> +    }
>> +    return 0;
>> +
>> +out_failed:
>> +    pr_err("failed to allocate zlib workspace\n");
>> +    z_erofs_deflate_exit();
>> +    return -ENOMEM;
>> +}
>> +
