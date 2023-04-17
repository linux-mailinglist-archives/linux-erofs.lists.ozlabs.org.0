Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24116E4069
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 09:12:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0JCw40F7z3cMT
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 17:12:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0JCp2FXgz3cDF
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 17:12:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgFMACV_1681715551;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgFMACV_1681715551)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 15:12:32 +0800
Message-ID: <a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
Date: Mon, 17 Apr 2023 15:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
To: Yue Hu <zbestahu@gmail.com>
References: <20230417064136.5890-1-zbestahu@gmail.com>
 <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
 <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
 <20230417151506.00006565.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230417151506.00006565.zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/17 15:15, Yue Hu wrote:
> On Mon, 17 Apr 2023 15:00:25 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 

..

>>
>> Although please help refine the comment below:
>>
>> 	/* scan & fill inplace I/O pages in the reverse order */
> 
> Ok, will refine it in v2.

I rethink this, I don't want to go far in this way, and this makes a
O(n) scan into O(n^2) when a single inplace I/O page is added.

So sorry, I don't think it's a good way, although I also don't think
`icur` is a good name and we might need to find a better name.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>> +    unsigned int icur = pcl->pclusterpages;
>>>> -    while (fe->icur > 0) {
>>>> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
>>>> +    while (icur > 0) {
>>>> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
>>>>                     NULL, bvec->page)) {
>>>> -            pcl->compressed_bvecs[fe->icur] = *bvec;
>>>> +            pcl->compressed_bvecs[icur] = *bvec;
>>>>                return true;
>>>>            }
>>>>        }
>>>> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>>>>        }
>>>>        z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>>>>                    Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>>>> -    /* since file-backed online pages are traversed in reverse order */
>>>> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
>>>>        return 0;
>>>>    }
