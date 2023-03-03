Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F56A8E36
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 01:38:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSTbv2Zfmz3cNb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 11:38:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSTbq5XJkz3bWC
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 11:38:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcyoRls_1677803903;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcyoRls_1677803903)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 08:38:24 +0800
Message-ID: <8b5071b3-ff00-b987-9519-f6cbf3232d22@linux.alibaba.com>
Date: Fri, 3 Mar 2023 08:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/2] erofs: set block size to the on-disk block size
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
 <20230302143915.111739-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230302143915.111739-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/2 22:39, Jingbo Xu wrote:
> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Besides, later we are going to make erofs refer to tar data blobs (which
> is 512-byte aligned) for OCI containers, where the block size is 512
> bytes.  In this case, the 512-byte block size may not be adequate for a
> directory to contain enough dirents.  To fix this, we are also going to
> introduce directory block size independent on the block size.
> 
> Due to we have already supported block size smaller than PAGE_SIZE now,
> disable all these images with such separated directory block size until
> we supported this feature later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
