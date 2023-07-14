Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 513FF7530B3
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 06:50:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2JvG1k9yz3c2K
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 14:50:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2Jv93Fwjz30PH
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 14:50:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnKIG.z_1689310219;
Received: from 30.221.157.198(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnKIG.z_1689310219)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 12:50:20 +0800
Message-ID: <82251dbb-6fb2-63a5-d15b-ba68ec75b4b2@linux.alibaba.com>
Date: Fri, 14 Jul 2023 12:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: deprecate superblock checksum feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
 <8a896983-ec76-d705-b4af-b34ffe529a81@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <8a896983-ec76-d705-b4af-b34ffe529a81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/14/23 12:29 PM, Gao Xiang wrote:
> 
> 
> On 2023/7/14 11:38, Jingbo Xu wrote:
>> Later we're going to introduce fs-verity based verification for the
>> whole image.  Make the superblock checksum feature deprecated.
> 
> I'd suggest that
> 
> 
> "Later we're going to try the self-contained image verification.
>  The current superblock checksum feature has quite limited
>  functionality, instead, merkle trees can provide better protection
>  for image integrity.
> 
>  Since the superblock checksum is a compatible feature, just
>  deprecate now. "
>  

Yeah, another concern is that xxhash is used in the following xattr name
filter feature [1] which is on the way.  It may be redundant to use two
hashing algorithms for one filesystem.


[1]
https://lore.kernel.org/all/20230714031034.53210-1-jefflexu@linux.alibaba.com/

-- 
Thanks,
Jingbo
