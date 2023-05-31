Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B54717A1B
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 10:32:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWMv33SH3z3f5X
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 18:31:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWMtw6Ybhz3c8x
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 18:31:52 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjwun5s_1685521906;
Received: from 30.221.133.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjwun5s_1685521906)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 16:31:47 +0800
Message-ID: <997002c8-2008-3209-3542-2ac0bbda99c3@linux.alibaba.com>
Date: Wed, 31 May 2023 16:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/5] erofs: unify inline/share xattr iterators for
 listxattr/getxattr
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-5-jefflexu@linux.alibaba.com>
 <349a1523-6d1c-9e96-d948-78dd4f2a209d@linux.alibaba.com>
 <d86cdf32-bc4d-bbab-d756-baef2b12cace@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d86cdf32-bc4d-bbab-d756-baef2b12cace@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/31 16:16, Jingbo Xu wrote:
> 
> 
> On 5/31/23 2:57 PM, Gao Xiang wrote:
>>
>>
>> On 2023/5/31 11:13, Jingbo Xu wrote:
>>>    -static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>>> -                   struct inode *inode)
>>> -{
>>> -    struct erofs_inode *const vi = EROFS_I(inode);
>>> -    unsigned int xattr_header_sz, inline_xattr_ofs;
>>> -
>>> -    xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
>>> -              sizeof(u32) * vi->xattr_shared_count;
>>> -    if (xattr_header_sz >= vi->xattr_isize) {
>>> -        DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>>> -        return -ENOATTR;
>>> -    }
> 
> In the original implementation, here when xattr_header_sz >=
> vi->xattr_isize, inline_xattr_iter_begin() will return -ENOATTR rather
> than a negative integer (i.e. vi->xattr_isize - xattr_header_sz).

Ah, sorry I misreaded that.

Thanks,
Gao Xiang
