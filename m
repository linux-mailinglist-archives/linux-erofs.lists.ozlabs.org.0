Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E496180665A
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 05:42:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlPrR30B8z3cWG
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 15:41:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlPrK1kLWz3cC7
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 15:41:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VxwlBxZ_1701837705;
Received: from 30.97.48.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxwlBxZ_1701837705)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 12:41:46 +0800
Message-ID: <a32eec89-c8e6-a6da-7191-4cb123f0b184@linux.alibaba.com>
Date: Wed, 6 Dec 2023 12:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] erofs: fix lz4 inplace decompression
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Juhyung Park <qkrwngud825@gmail.com>
References: <20231206030758.3760521-1-hsiangkao@linux.alibaba.com>
 <CAD14+f0aQGPXn_gv9b6O84Jx=H-f3df_266ubZVS2TFONp1hag@mail.gmail.com>
 <43849cb6-a3c2-5ec6-4c71-417b8b766c73@linux.alibaba.com>
In-Reply-To: <43849cb6-a3c2-5ec6-4c71-417b8b766c73@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/6 12:39, Gao Xiang wrote:
> 
> 
> On 2023/12/6 12:28, Juhyung Park wrote:
>> Hi Gao,
>>
>> Thanks for the timely fix.
>> This also fixes the issue.
>>
>> Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
>>
>> Might wanna add
>> Cc: stable@vger.kernel.org # 5.4+
>> but it seems like this doesn't apply cleanly for 5.4, 5.10 and 5.15
>> also requires some manual conflict resolution. :))
> 
> I will handle these LTSes manually, so don't worry about that :)
> 
>>
>> Wrote some nits below:
>>
>> On Wed, Dec 6, 2023 at 12:08 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>> Currently EROFS can map another compressed buffer for inplace
>>> decompression, which was used to handle the cases that some pages of
>>> compressed data are actually not in-place I/O.
>>>
>>> However, like most simple LZ77 algorithms, LZ4 expects the compressed
>>> data is arranged at the end of the decompressed buffer and it
>>> explicitly uses memmove() to handle overlapping:
>>>    __________________________________________________________
>>>   |_ direction of decompression --> ____ |_ compressed data _|
>>>
>>> Although EROFS arranges compressed data like this, it typically map two
>>> individual virtual buffers so the relative order is uncertain.
>>> Previously, it was hardly observed since LZ4 only uses memmove() for
>>> short overlapped literals and x86/arm64 memmove implementations seem to
>>> completely cover it up so they don't have this issue.  Juhyung reported
>>> that EROFS data corruption can be found on a new Intel x86 processor.
>>> After some analysis, it seems that recent x86 processors with the new
>>> FSRM feature expose this issue with "rep movsb".
>>>
>>> Let's strictly use the decompressed buffer for lz4 inplace
>>> decompression for now.  Later, as an useful improvement, we could try
>>> to tie up these two buffers together in the correct order.
>>>
>>> Reported-by: Juhyung Park <qkrwngud825@gmail.com>
>>> Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
>>> Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
>>> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> Hi Juhyung,
>>> Please help check if this patch resolves your issue.
>>> Also, I will test it in various hardware configurations first as well.
>>>
>>>   fs/erofs/decompressor.c | 31 +++++++++++++++----------------
>>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>>> index 5ec11f5024b7..5905d7c4d1db 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -121,11 +121,11 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>>>   }
>>>
>>>   static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
>>> -                       void *inpage, unsigned int *inputmargin, int *maptype,
>>> -                       bool may_inplace)
>>> +                       void *inpage, void *out, unsigned int *inputmargin,
>>> +                       int *maptype, bool may_inplace)
>>>   {
>>>          struct z_erofs_decompress_req *rq = ctx->rq;
>>> -       unsigned int omargin, total, i, j;
>>> +       unsigned int omargin, total, i;
>>>          struct page **in;
>>>          void *src, *tmp;
>>>
>>> @@ -135,20 +135,19 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
>>>                      omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
>>>                          goto docopy;
>>>
>>> -               for (i = 0; i < ctx->inpages; ++i) {
>>> -                       DBG_BUGON(rq->in[i] == NULL);
>>> -                       for (j = 0; j < ctx->outpages - ctx->inpages + i; ++j)
>>> -                               if (rq->out[j] == rq->in[i])
>>> -                                       goto docopy;
>>> -               }
>>> +               for (i = 0; i < ctx->inpages; ++i)
>>> +                       if (rq->out[ctx->outpages - ctx->inpages + i] !=
>>> +                           rq->in[i])
>>> +                               goto docopy;
>>
>> Linux kernel coding guideline recommends placing braces on multi-line
>> nested condition statements.
>> See https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/process/coding-style.rst?h=v6.6#n225
>>
>>> +               kunmap_local(inpage);
>>> +               *maptype = 3;
>>> +               return out + ((ctx->outpages - ctx->inpages) << PAGE_SHIFT);
>>>          }
>>> -
>>
>> Unnecessary diff?
> 
> Yeah, I could keep this line when applying.  Thanks for pointing out.
> 
>>
>>>          if (ctx->inpages <= 1) {
>>>                  *maptype = 0;
>>>                  return inpage;
>>>          }
>>>          kunmap_local(inpage);
>>> -       might_sleep();
>>>          src = erofs_vm_map_ram(rq->in, ctx->inpages);
>>>          if (!src)
>>>                  return ERR_PTR(-ENOMEM);
>>> @@ -204,12 +203,12 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>>>   }
>>>
>>>   static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>>> -                                     u8 *out)
>>> +                                     u8 *dst)
>>>   {
>>>          struct z_erofs_decompress_req *rq = ctx->rq;
>>>          bool support_0padding = false, may_inplace = false;
>>>          unsigned int inputmargin;
>>> -       u8 *headpage, *src;
>>> +       u8 *out = dst + rq->pageofs_out, *headpage, *src;
>>
>> Move this initialization below "/* legacy format could compress extra
>> data in a pcluster. */" looks better imho.
> 
> Thanks, but the kernel coding style doesn't allow that.

Oh, I could move this initialization below, I will send out
a quick v2 for this.

Thanks,
Gao Xiang
