Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4B6B1D68
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 09:10:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXML32YRTz3cK6
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 19:10:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXMKz1PJkz2yP8
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 19:09:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdSZMAo_1678349394;
Received: from 30.97.48.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdSZMAo_1678349394)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 16:09:55 +0800
Message-ID: <bcecc8fe-8e98-fe2f-2a7c-2eac51cdbc9c@linux.alibaba.com>
Date: Thu, 9 Mar 2023 16:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
To: Yangtao Li <frank.li@vivo.com>, zbestahu@gmail.com
References: <bee8eb33-ec23-de1c-0340-b2cc290f4d1c@linux.alibaba.com>
 <20230309074225.29404-1-frank.li@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230309074225.29404-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/9 15:42, Yangtao Li wrote:
>> FYI it seems that GENMASK macro is widely used in driver and arch code base, while it's rarely used in fs, except for f2fs.
> 
> I think the following usage can be changed to bitmap api, just like in f2fs?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c4ca1f7164734a1baf40d4ff1552172a07d4fc4d
> 
> fs/erofs/fscache.c:135:         unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
> fs/erofs/internal.h:250:#define SECTORS_PER_BLOCK       (1 << SECTORS_PER_BLOCK)
> fs/erofs/internal.h:252:#define EROFS_BLKSIZ            (1 << LOG_BLOCK_SIZE)
> fs/erofs/internal.h:354:        return (value >> bit) & ((1 << bits) - 1);
> fs/erofs/zmap.c:66:             ((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
> fs/erofs/zmap.c:69:             m->clusterofs = 1 << vi->z_logical_clusterbits;
> fs/erofs/zmap.c:114:    const unsigned int lomask = (1 << lclusterbits) - 1;
> fs/erofs/zmap.c:141:    const unsigned int lomask = (1 << lclusterbits) - 1;
> fs/erofs/zmap.c:147:    if (1 << amortizedshift == 4)
> fs/erofs/zmap.c:149:    else if (1 << amortizedshift == 2 && lclusterbits == 12)
> fs/erofs/zmap.c:169:            m->clusterofs = 1 << lclusterbits;
> fs/erofs/zmap.c:291:    pos += lcn * (1 << amortizedshift);
> fs/erofs/zmap.c:409:            m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
> fs/erofs/zmap.c:457:                              m->clusterofs != 1 << lclusterbits);
> fs/erofs/zmap.c:497:    endoff = ofs & ((1 << lclusterbits) - 1);
> fs/erofs/erofs_fs.h:120:        ((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
> fs/erofs/erofs_fs.h:279:#define Z_EROFS_ALL_COMPR_ALGS          ((1 << Z_EROFS_COMPRESSION_MAX) - 1)
> fs/erofs/erofs_fs.h:377:#define Z_EROFS_VLE_DI_PARTIAL_REF              (1 << 15)
> fs/erofs/erofs_fs.h:384:#define Z_EROFS_VLE_DI_D0_CBLKCNT               (1 << 11)
> fs/erofs/erofs_fs.h:427:                .h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
> fs/erofs/data.c:379:                    blksize_mask = (1 << inode->i_blkbits) - 1;
> fs/erofs/zdata.c:133:#define Z_EROFS_PAGE_EIO                   (1 << 30)
> 

Is there some benefit to use these? BIT(1) vs 1 << 1? also almost all
filesystems rarely use such APIs honestly.

Thanks,
Gao Xiang

> Thx,
> Yangtao
