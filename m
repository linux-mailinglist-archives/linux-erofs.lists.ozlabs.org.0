Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB056B1D51
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 09:07:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXMGr1vKdz3cLF
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 19:07:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXMGk4JqWz3000
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 19:07:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdSijHi_1678349224;
Received: from 30.97.48.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdSijHi_1678349224)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 16:07:05 +0800
Message-ID: <0261de31-e98b-85cd-80de-96af5a76e15c@linux.alibaba.com>
Date: Thu, 9 Mar 2023 16:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
To: Yue Hu <zbestahu@gmail.com>, Yangtao Li <frank.li@vivo.com>
References: <20230306075527.1338-1-zbestahu@gmail.com>
 <20230309071515.25675-1-frank.li@vivo.com>
 <20230309153709.00003876.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230309153709.00003876.zbestahu@gmail.com>
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



On 2023/3/9 15:37, Yue Hu wrote:
> On Thu,  9 Mar 2023 15:15:15 +0800
> Yangtao Li <frank.li@vivo.com> wrote:
> 
>>> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>> 		if (bdev)
>>> 			blksize_mask = bdev_logical_block_size(bdev) - 1;
>>> 		else
>>> -			blksize_mask = (1 << inode->i_blkbits) - 1;
>>> +			blksize_mask = i_blocksize(inode) - 1;
>>
>> Since the mask is to be obtained here, is it more appropriate to use GENMASK(inode->i_blkbits - 1, 0)?
> 
> It should be another change independently to this patch. rt?

I'd suggest that keep to use (i_blocksize(inode) - 1) here, for example:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/tree/fs/gfs2/bmap.c#n963

Thanks,
Gao Xiang

> 
>>
>> Thx,
>> Yangtao
