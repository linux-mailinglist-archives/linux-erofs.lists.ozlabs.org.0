Return-Path: <linux-erofs+bounces-1521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9BCCF3A1
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 10:54:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXjYn6l96z2yFW;
	Fri, 19 Dec 2025 20:54:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766138077;
	cv=none; b=XP0Tj+92oX1fs0Gqrnd/4cEOJ8DDUzrpQMZ0IFRzHqmZwJXOlrRUTCr9iTvNgUjiIfT6O6SPg49iReLnpvAMCerrIkQmyvSrRaxc3EvLnpUCYM0QagbaAzG5AbU5KbYpCpvo2hihi7+cl2M9+sINrtqtRxfO5jbGnSj+edQmyPO8DYthGmq+76S1v3b7xTy1Gfdp+wtOEMSYB4jmwcf2+iEpXyN7kBanKGoywltOkBYbCYkPStzHWGeqFvONkAVxLRtMizAzkppUheXkWhOhZtiaBMju7yQCm7UlUyB8+CZ5Lj6fOxtKsvCZlkTpB35+LCxSGx/JGmIZlcgwXVBhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766138077; c=relaxed/relaxed;
	bh=XgQizcauHnh/ysYzDZP7I8/fUHcU7RgcJ9ws2O2qYhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krgfAytKdhkSkWMfEne5pCTs+7x63jpx1ELSDGfKwdFiSnci01mBUyumYEF6w/qlcI4N3JbzZAGjrYsb1xQoCc/5bbRn1nEZ2cPW/y7h653ITVE1iZNcbsZ1G3B9NkwoO/YKjDlF58K1iWP+HTWLsba8tlqZfoZGszUsB84i96w4RzcOxY383xlQX/NmJJblf1R6wWG/mHITv4Wv0r3uSsRzP1z9Z+GsPtPJVtcfee5WrbXyoRPZtUnTa8584vPS0hAk2A8g8fQEZWP/TbriUfakybKtUeEAYOmEC2rS9CXEq4+PJBFMXS8sGSEOnIod6UbdKmy27YfGsY7ecdV87A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qIj52rtb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qIj52rtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXjYk62yqz2xqm
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 20:54:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766138066; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XgQizcauHnh/ysYzDZP7I8/fUHcU7RgcJ9ws2O2qYhk=;
	b=qIj52rtbI32ejRQZngcGHaj8jF8Rke2lv9schj0ItTKzDKu8TlIZBkq4EKe1+WwQtPCjnBS/MC5TgHFP/jKRfnvEP33K6QReOCTFrRaQXg/e2LljNN02zRYaphTbwdsVcfTZCyj1Tw1ivM4HJcNDlaEChCpMPJlCQ0jiB6WfD98=
Received: from 30.221.131.220(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvCXM1G_1766138062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Dec 2025 17:54:23 +0800
Message-ID: <9cc27554-740b-461d-a550-3d8af63a2b94@linux.alibaba.com>
Date: Fri, 19 Dec 2025 17:54:22 +0800
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
Subject: Re: [PATCH] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 'Jaewook Kim' <jw5454.kim@samsung.com>,
 'Sungjong Seo' <sj1557.seo@samsung.com>
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
 <20251219071034.2399153-1-junbeom.yeom@samsung.com>
 <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
 <000001dc70cc$6cc150c0$4643f240$@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000001dc70cc$6cc150c0$4643f240$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/19 17:47, Junbeom Yeom wrote:
> Hi Xiang,
> 
>>
>> Hi Junbeom,
>>
>> On 2025/12/19 15:10, Junbeom Yeom wrote:
>>> erofs readahead could fail with ENOMEM under the memory pressure
>>> because it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while
>>> GFP_KERNEL for a regular read. And if readahead fails (with
>>> non-uptodate folios), the original request will then fall back to
>>> synchronous read, and `.read_folio()` should return appropriate errnos.
>>>
>>> However, in scenarios where readahead and read operations compete,
>>> read operation could return an unintended EIO because of an incorrect
>>> error propagation.
>>>
>>> To resolve this, this patch modifies the behavior so that, when the
>>> PCL is for read(which means pcl.besteffort is true), it attempts
>>> actual decompression instead of propagating the privios error except initial EIO.
>>>
>>> - Page size: 4K
>>> - The original size of FileA: 16K
>>> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
>>> [page0, page1] [page2, page3] [PCL0]---------[PCL1]
>>>
>>> - functions declaration:
>>>     . pread(fd, buf, count, offset)
>>>     . readahead(fd, offset, count)
>>> - Thread A tries to read the last 4K
>>> - Thread B tries to do readahead 8K from 4K
>>> - RA, besteffort == false
>>> - R, besteffort == true
>>>
>>>           <process A>                   <process B>
>>>
>>> pread(FileA, buf, 4K, 12K)
>>>     do readahead(page3) // failed with ENOMEM
>>>     wait_lock(page3)
>>>       if (!uptodate(page3))
>>>         goto do_read
>>>                                  readahead(FileA, 4K, 8K)
>>>                                  // Here create PCL-chain like below:
>>>                                  // [null, page1] [page2, null]
>>>                                  //   [PCL0:RA]-----[PCL1:RA]
>>> ...
>>>     do read(page3)        // found [PCL1:RA] and add page3 into it,
>>>                           // and then, change PCL1 from RA to R ...
>>>                                  // Now, PCL-chain is as below:
>>>                                  // [null, page1] [page2, page3]
>>>                                  //   [PCL0:RA]-----[PCL1:R]
>>>
>>>                                    // try to decompress PCL-chain...
>>>                                    z_erofs_decompress_queue
>>>                                      err = 0;
>>>
>>>                                      // failed with ENOMEM, so page 1
>>>                                      // only for RA will not be uptodated.
>>>                                      // it's okay.
>>>                                      err = decompress([PCL0:RA], err)
>>>
>>>                                      // However, ENOMEM propagated to next
>>>                                      // PCL, even though PCL is not only
>>>                                      // for RA but also for R. As a result,
>>>                                      // it just failed with ENOMEM without
>>>                                      // trying any decompression, so page2
>>>                                      // and page3 will not be uptodated.
>>>                   ** BUG HERE ** --> err = decompress([PCL1:R], err)
>>>
>>>                                      return err as ENOMEM ...
>>>       wait_lock(page3)
>>>         if (!uptodate(page3))
>>>           return EIO      <-- Return an unexpected EIO!
>>> ...
>>
>> Many thanks for the report!
>> It's indeed a new issue to me.
>>
>>>
>>> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
>>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>>> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
>>> ---
>>>    fs/erofs/zdata.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c index
>>> 27b1f44d10ce..86bf6e087d34 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct
>> z_erofs_decompressqueue *io,
>>>    	};
>>>    	struct z_erofs_pcluster *next;
>>>    	int err = io->eio ? -EIO : 0;
>>> +	int io_err = err;
>>>
>>>    	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
>>> +		int propagate_err;
>>> +
>>>    		DBG_BUGON(!be.pcl);
>>>    		next = READ_ONCE(be.pcl->next);
>>> -		err = z_erofs_decompress_pcluster(&be, err) ?: err;
>>> +		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
>>> +		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
>>
>> I wonder if it's just possible to decompress each pcluster according to io
>> status only (but don't bother with previous pcluster status), like:
>>
>> 		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;
>>
>> and change the second argument of
>> z_erofs_decompress_pcluster() to bool.
>>
>> So that we could leverage the successful i/o as much as possible.
> 
> Oh, I thought you were intending to address error propagation.

We could still propagate errors (-ENOMEM) to the callers, but for
the case you mentioned, I still think it's useful to handle the
following pclusters if the disk I/Os are successful.

and it still addresses the issue you mentioned, I think it's also
cleaner.

> If that's not the case, I also believe the approach you're suggesting is better.
> I'll send the next version.

Thank you for the effort!

Thanks,
Gao Xiang

> 
> Thanks,
> Junbeom Yeom
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>    	}
>>>    	return err;
>>>    }
>>
> 


