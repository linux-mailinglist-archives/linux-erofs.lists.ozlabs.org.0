Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C07337179C5
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 10:17:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWMYp0nWyz3f5X
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 18:17:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWMYg50X9z3cCh
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 18:16:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjwqwcr_1685521005;
Received: from 30.221.149.27(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vjwqwcr_1685521005)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 16:16:46 +0800
Message-ID: <d86cdf32-bc4d-bbab-d756-baef2b12cace@linux.alibaba.com>
Date: Wed, 31 May 2023 16:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/5] erofs: unify inline/share xattr iterators for
 listxattr/getxattr
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-5-jefflexu@linux.alibaba.com>
 <349a1523-6d1c-9e96-d948-78dd4f2a209d@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <349a1523-6d1c-9e96-d948-78dd4f2a209d@linux.alibaba.com>
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



On 5/31/23 2:57 PM, Gao Xiang wrote:
> 
> 
> On 2023/5/31 11:13, Jingbo Xu wrote:
>>   -static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>> -                   struct inode *inode)
>> -{
>> -    struct erofs_inode *const vi = EROFS_I(inode);
>> -    unsigned int xattr_header_sz, inline_xattr_ofs;
>> -
>> -    xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
>> -              sizeof(u32) * vi->xattr_shared_count;
>> -    if (xattr_header_sz >= vi->xattr_isize) {
>> -        DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>> -        return -ENOATTR;
>> -    }

In the original implementation, here when xattr_header_sz >=
vi->xattr_isize, inline_xattr_iter_begin() will return -ENOATTR rather
than a negative integer (i.e. vi->xattr_isize - xattr_header_sz).


>>   static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>>                      struct dentry *unused, struct inode *inode,
>>                      const char *name, void *buffer, size_t size)
>> @@ -542,45 +432,98 @@ static const struct xattr_iter_handlers
>> list_xattr_handlers = {
>>       .value = NULL
>>   };
>>   -static int inline_listxattr(struct erofs_xattr_iter *it)
>> +static int erofs_iter_inline_xattr(struct erofs_xattr_iter *it,
>> +                   struct inode *inode, bool getxattr)
>>   {
>> +    struct erofs_inode *const vi = EROFS_I(inode);
>> +    const struct xattr_iter_handlers *op;
>> +    unsigned int xattr_header_sz, remaining;
>> +    erofs_off_t pos;
>>       int ret;
>> -    unsigned int remaining;
>>   -    ret = inline_xattr_iter_begin(it, d_inode(it->dentry));
> 
> In the past, "ret" here is "an int", and
>     vi->xattr_isize - xattr_header_sz < 0 will return
> negative value (although I think that value is problematic).
> 
> see below.

See comment above.

> 
> 
>> -    if (ret < 0)
>> -        return ret;
>> +    xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
>> +              sizeof(u32) * vi->xattr_shared_count;
>> +    if (xattr_header_sz >= vi->xattr_isize) {
>> +        DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>> +        return -ENOATTR;
>> +    }

This checking for "xattr_header_sz >= vi->xattr_isize" is also included
in this patch.


-- 
Thanks,
Jingbo
