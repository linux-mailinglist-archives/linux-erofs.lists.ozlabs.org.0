Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A335171543B
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 05:43:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QVdXK0lX8z3f5K
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 13:43:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QVdXB05JRz2xjw
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 May 2023 13:43:04 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjrrxCr_1685418178;
Received: from 30.221.145.232(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjrrxCr_1685418178)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 11:42:59 +0800
Message-ID: <6e7b2c58-0bb4-e008-a157-3d83ac33bf81@linux.alibaba.com>
Date: Tue, 30 May 2023 11:42:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/5] erofs: introduce erofs_xattr_iter_fixup_aligned()
 helper
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
 <20230518024551.123990-2-jefflexu@linux.alibaba.com>
 <9d928aa7-31cf-e4c1-8694-0aa63e55b382@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <9d928aa7-31cf-e4c1-8694-0aa63e55b382@linux.alibaba.com>
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



On 5/29/23 3:41 PM, Gao Xiang wrote:
> Hi,
> 
> On 2023/5/18 10:45, Jingbo Xu wrote:
>> Introduce erofs_xattr_iter_fixup_aligned() helper where
>> it.ofs <= EROFS_BLKSIZ is mandatory.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/erofs/xattr.c | 79 +++++++++++++++++++++---------------------------
>>   1 file changed, 35 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index bbfe7ce170d2..b79be2a556ba 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -29,6 +29,28 @@ struct xattr_iter {
>>       unsigned int ofs;
>>   };
>>   +static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
>> +{
>> +    if (it->ofs < it->sb->s_blocksize)
>> +        return 0;
>> +
>> +    it->blkaddr += erofs_blknr(it->sb, it->ofs);
>> +    it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
>> EROFS_KMAP);
> 
> could we use a new buf interface to init_metabuf at once?

As discussed offline, I think the following unified API is preferred:

```
int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)

{
    if (it->ofs < it->sb->s_blocksize)
        return 0;

    if (nospan && it->ofs != it->sb->s_blocksize) {
	DBG_BUGON(1);
	return -EFSCORRUPTED;
    }

    ...
}
```

-- 
Thanks,
Jingbo
