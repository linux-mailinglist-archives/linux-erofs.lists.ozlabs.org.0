Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8588A923B
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:04:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKm071zGSz3cQx
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:04:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKlzz3xycz3btQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:03:57 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 42B271008C2C6;
	Thu, 18 Apr 2024 13:03:53 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 19E6A37C91F;
	Thu, 18 Apr 2024 13:03:50 +0800 (CST)
Message-ID: <03fa087d-2a24-43d7-a4db-6d16092a7948@sjtu.edu.cn>
Date: Thu, 18 Apr 2024 13:03:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: mkfs: skip the redundant write for
 ztailpacking block
To: Noboru Asai <asai@sijam.com>
References: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
 <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com>
Content-Language: en-US
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 4/18/24 9:09 AM, Noboru Asai wrote:
> In this patch, the value of blkaddr in z_erofs_lcluster_index
> corresponding to the ztailpacking block in the extent list
> is invalid value. It looks that the linux kernel doesn't refer to this
> value, but what value is correct?
> 0 or -1 (EROFS_NULL_ADDR) or don't care?

For the read side, AFAIK the kernel (and also the user lib of 
erofs-utils) will turn to the meta for inlined data

for read offset beyond the last data block if ztailpacking is enabled, 
see `erofs_map_blocks_flatmode`.

So I believe the blkaddr recorded in z_erofs_lcluster_index is 
irrelevant and we don't need to care about it.


For the mkfs side I think things could be polished according to Gao's 
review opinion.


Thanks,

Yifan Zhao

>
> 2024年4月17日(水) 23:43 Yifan Zhao <zhaoyifan@sjtu.edu.cn>:
>> z_erofs_merge_segment() doesn't consider the ztailpacking block in the
>> extent list and unnecessarily writes it back to the disk. This patch
>> fixes this issue by introducing a new `inlined` field in the struct
>> `z_erofs_inmem_extent`.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
>> ---
>>   include/erofs/dedupe.h | 2 +-
>>   lib/compress.c         | 8 ++++++++
>>   lib/dedupe.c           | 1 +
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
>> index 153bd4c..4cbfb2c 100644
>> --- a/include/erofs/dedupe.h
>> +++ b/include/erofs/dedupe.h
>> @@ -16,7 +16,7 @@ struct z_erofs_inmem_extent {
>>          erofs_blk_t blkaddr;
>>          unsigned int compressedblks;
>>          unsigned int length;
>> -       bool raw, partial;
>> +       bool raw, partial, inlined;
>>   };
>>
>>   struct z_erofs_dedupe_ctx {
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 74c5707..41628e7 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -572,6 +572,7 @@ nocompression:
>>                   */
>>                  e->compressedblks = 1;
>>                  e->raw = true;
>> +               e->inlined = false;
>>          } else if (may_packing && len == e->length &&
>>                     compressedsize < ctx->pclustersize &&
>>                     (!inode->fragment_size || ictx->fix_dedupedfrag)) {
>> @@ -582,6 +583,7 @@ frag_packing:
>>                          return ret;
>>                  e->compressedblks = 0; /* indicate a fragment */
>>                  e->raw = false;
>> +               e->inlined = false;
>>                  ictx->fragemitted = true;
>>          /* tailpcluster should be less than 1 block */
>>          } else if (may_inline && len == e->length && compressedsize < blksz) {
>> @@ -600,6 +602,7 @@ frag_packing:
>>                          return ret;
>>                  e->compressedblks = 1;
>>                  e->raw = false;
>> +               e->inlined = true;
>>          } else {
>>                  unsigned int tailused, padding;
>>
>> @@ -652,6 +655,7 @@ frag_packing:
>>                                  return ret;
>>                  }
>>                  e->raw = false;
>> +               e->inlined = false;
>>                  may_inline = false;
>>                  may_packing = false;
>>          }
>> @@ -1151,6 +1155,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
>>                  ei->e.blkaddr = sctx->blkaddr;
>>                  sctx->blkaddr += ei->e.compressedblks;
>>
>> +               if (ei->e.inlined)
>> +                       continue;
>> +
>>                  ret2 = blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
>>                                   ei->e.blkaddr, ei->e.compressedblks);
>>                  blkoff += ei->e.compressedblks;
>> @@ -1374,6 +1381,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
>>                          .compressedblks = 0,
>>                          .raw = false,
>>                          .partial = false,
>> +                       .inlined = false,
>>                          .blkaddr = sctx.blkaddr,
>>                  };
>>                  init_list_head(&ei->list);
>> diff --git a/lib/dedupe.c b/lib/dedupe.c
>> index 19a1c8d..aaaccb5 100644
>> --- a/lib/dedupe.c
>> +++ b/lib/dedupe.c
>> @@ -138,6 +138,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
>>                  ctx->e.partial = e->partial ||
>>                          (window_size + extra < e->original_length);
>>                  ctx->e.raw = e->raw;
>> +               ctx->e.inlined = false;
>>                  ctx->e.blkaddr = e->compressed_blkaddr;
>>                  ctx->e.compressedblks = e->compressed_blks;
>>                  return 0;
>> --
>> 2.44.0
>>
