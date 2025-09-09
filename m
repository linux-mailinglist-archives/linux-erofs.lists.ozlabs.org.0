Return-Path: <linux-erofs+bounces-995-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968FBB4A9F4
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 12:14:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLfnn1hyjz3cYg;
	Tue,  9 Sep 2025 20:14:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757412893;
	cv=none; b=gXeislj6YbzZCQjnoX3+lxwZbTZu6wKcWLEgJ0htJsBcoeEjc7pklGsn8Dp2BTk5/ZHIeOZiNspaQkuPIQ99kOMZdwA9NoC9wDJp+l9FcYTMfYnigPO6WmUP2M+WAw+wkVg3/9Qj8Zd1XkfSYRydrObdK2TxUfn/OEfcuYtPiM3dVKGD7nQFI8aE8tDXCApukOy6IBDjOzS3w6P5xnIsM52lUGKdWDV8sCq8DhDL5fYrUsZz/cT+vqvotrV608VWWUxJ8mtxZ1qFr7Bl7DLmd8BeU2h0RXp+xJJahWvasyEsDir9IhuOIRLzzSGYgTdClNLRtz9uo6qScO9tcOoAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757412893; c=relaxed/relaxed;
	bh=ISZnF6CE1CQnUI8RD9yn7SvKLUEWh5h6VEuQp2ZmujQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnja/W6Jr+anqSTthnnviASPqZw8TagQBu+WKWay08YFrL5Mw5wrQbvDJ2eu0FIOWLnp/YTPGCqL69LqhFKZoqC0amIaU75p8RmrDoB/niuoXIHEivP5f3eLsGnoVZ8qNpj28JHA+zwDly/2QRPi2lUBgMQhFocQ3nP2w0isiHQNjfmV96gaJHFWiJbN6acGm8NbKNrQOBqAzOSlNdxIIIcbchJe7nOjJSjQIvnJ4AH24qZFYwxumrqcVK91n0rFovWK+T5PEP2UsPFIYwsYTGrgfaFEulEcuWClA94eqLU7YZbcgaaxpbdEHmWZpPpcuP2OQB3dEidMMjhYUKJVzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e4A2NIfE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e4A2NIfE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLfnl2gMhz30PF
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 20:14:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757412886; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ISZnF6CE1CQnUI8RD9yn7SvKLUEWh5h6VEuQp2ZmujQ=;
	b=e4A2NIfEty9NIzkP86RJL0h+Gq+UqkplpfK5Hwqagwvpo+oJiTn2sQUuzvq7zQuRtsTUX1ifzMQtFiMFTp2ihAXpNvAEXj1g1XPEt/r24qV8xwBZFwni3Rj7eZcE4a/N3MCNdm0r2fy5nqTyK8Sy/zJ7CgEertsaDw6kYP3MPk0=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WndQPmv_1757412884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 18:14:44 +0800
Message-ID: <51a52ed7-ed26-46ba-88e1-a45049d613a7@linux.alibaba.com>
Date: Tue, 9 Sep 2025 18:14:43 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
 <0f01805f-434c-4b7a-b6da-52efbbff2b87@linux.alibaba.com>
 <PUZPR04MB6316D33745FEA0695A05078C810FA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <PUZPR04MB6316D33745FEA0695A05078C810FA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/9 18:01, Yuezhang.Mo@sony.com wrote:
> On 2025/9/9 15:26, Gao Xiang wrote:
>> Hi Yuezhang,
>>
>> On 2025/9/9 10:52, Yuezhang Mo wrote:
>>> This patch addresses 4 memory leaks and 1 allocation issue to
>>> ensure proper cleanup and allocation:
>>>
>>> 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().
>>> 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().
>>> 3. Fixed incorrect allocation of chunk index array in
>>>      erofs_rebuild_write_blob_index() to ensure correct array allocation
>>>      and avoid out-of-bounds access.
>>> 4. Fixed memory leak of struct erofs_blobchunk not being freed by
>>>      calling erofs_blob_exit() in rebuild mode.
>>> 5. Fix memory leak by calling erofs_put_super().
>>>      In main(), erofs_read_superblock() is called only to get the block
>>>      size. In erofs_mkfs_rebuild_load_trees(), erofs_read_superblock()
>>>      is called again, causing sbi->devs to be overwritten without being
>>>      released.
>>>
>>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>>> Reviewed-by: Friendy Su <friendy.su@sony.com>
>>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
>>
>> Thanks for your patch and sorry for a bit delay...
>>
>>> ---
>>>    lib/compress.c | 2 ++
>>>    lib/inode.c    | 3 +++
>>>    lib/rebuild.c  | 2 +-
>>>    mkfs/main.c    | 3 ++-
>>>    4 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/compress.c b/lib/compress.c
>>> index 622a205..dd537ec 100644
>>> --- a/lib/compress.c
>>> +++ b/lib/compress.c
>>> @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
>>>                }
>>>    #endif
>>>        }
>>> +
>>> +     free(sbi->zmgr);
>>>        return 0;
>>>    }
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 7ee6b3d..0882875 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>>>        } else {
>>>                free(inode->i_link);
>>>        }
>>> +
>>> +     if (inode->chunkindexes)
>>> +             free(inode->chunkindexes);
>>
>> For now, this needs a check
>>
>>          if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
>>                  free(inode->chunkindexes);
>>
>> I admit it's not very clean, but otherwise it doesn't work
>> since `chunkindexes` is in a union.
>>
> 
> Okay, I will change to this check.
> 
>>>        free(inode);
>>>        return 0;
>>>    }
>>> diff --git a/lib/rebuild.c b/lib/rebuild.c
>>> index 0358567..18e5204 100644
>>> --- a/lib/rebuild.c
>>> +++ b/lib/rebuild.c
>>> @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
>>>
>>>        unit = sizeof(struct erofs_inode_chunk_index);
>>>        inode->extent_isize = count * unit;
>>> -     idx = malloc(max(sizeof(*idx), sizeof(void *)));
>>> +     idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
>>>        if (!idx)
>>>                return -ENOMEM;
>>>        inode->chunkindexes = idx;
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index 28588db..bcde787 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -1702,6 +1702,7 @@ int main(int argc, char **argv)
>>>                        goto exit;
>>>                }
>>>                mkfs_blkszbits = src->blkszbits;
>>> +             erofs_put_super(src);
>>
>> Do you really need to fix this now (considering `mkfs.erofs`
>> will exit finally)?
> 
> As you said, mkfs.erofs will exit finally, it won't affect users
> without this fix.
> 
> The main purpose of this patch is to fix the memory allocation
> issue in erofs_rebuild_write_blob_index(). It will cause a
> segmentation fault if there are deduplications(If there are few
> files, no segmentation fault occurs, but the files will be
> inaccessible.).

Yes, so I tend to not fix `erofs_put_super()` in this patch.

> 
>>
>> In priciple, I think it should be fixed with a reference and
>> something similiar to the kernel fill_super.
>>
>> I'm not sure if you have more time to improve this anyway,
>> but the current usage is not perfect on my side...
> 
> The memory leak is caused by the erofs_sb_info of the first blob
> device being initialized twice, how to fix with reference? I do not
> get your point.

I think we should skip erofs_read_superblock() if sbi is
initialized at least.

As for reference I meant vfs_get_super() likewise, it calls
fill_super() if .s_root is NULL.

Thanks,
Gao Xiang


