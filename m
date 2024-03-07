Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51C8745DA
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 03:02:38 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nLLDx+6M;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqsy40Lh4z3cDw
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 13:02:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nLLDx+6M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tqsxy45h1z3btQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 13:02:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709776943; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JBfqtPn8k1lCO84oA6JKbGN+1vMEH2khXMOKAyW0fAs=;
	b=nLLDx+6M2VzVoqzRPAQ3aN+HbVujgzUzgnU843YO2R62iOkcJ73voxCViZmFVjz3Z5XOeXW6nXdV9hxhPi6JhoSV/fXdMkWYv/eBxX4+DdckEBdfhFmN8aEh6+x5QLySw2uHkqcCIrfP8Ek7caRAPexAUCo5XsYF4YC8nrFdkW0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1z3fTt_1709776940;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1z3fTt_1709776940)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 10:02:21 +0800
Message-ID: <1096418c-7657-4d38-8344-bf6cf3c1b8bb@linux.alibaba.com>
Date: Thu, 7 Mar 2024 10:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
 <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
 <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/7 09:07, Chao Yu wrote:
> On 2024/3/6 14:51, Gao Xiang wrote:
>>
>>
>> On 2024/3/6 13:31, Gao Xiang wrote:
>>> There are mainly two reasons that thp_get_unmapped_area() should be
>>> used for EROFS as other filesystems:
>>>
>>>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>>>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>>>     mappings");
>>>
>>>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>>>     THPs for read-only mmapped files (e.g. shared libraries) even without
>>>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>>>     for non-DAX").
>>
>> Refine this part as
>>
>>   - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
>>     which enable THPs for mmapped files (e.g. shared libraries) even without
>>     ...
>>
>>>
>>> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
>>
>> Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
>> Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks, added!

Thanks,
Gao Xiang

> 
> Thanks,
