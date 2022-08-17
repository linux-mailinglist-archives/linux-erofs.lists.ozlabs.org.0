Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3EF596785
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 04:49:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6stN0DVRz3bk8
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 12:49:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660704572;
	bh=yITaNThql62roBDZgcgbCrNqYiV4UEGUfAOYcYwM/IY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bMb/CdGlmByGxhu02l6pMyh7aVzUWuSiKGi2pQGdtAXIAIuGadsXkys4SuhmIwnHd
	 SjXGMX4S5E7bHlmmuIUPc2GPZC+y9MXyCbfvyg70PnAhtByi7UvBaPsAQ2VctUYZo/
	 NTvDee54hncQW1mBihQdkDsIz8ziTguTR2CXsR4AJZbI+4vElVRtuWasPiGS2Y3+Rv
	 TG8RNenpZDXm+ToI+gtkg/G9zdpAOkfGuUsyRJR4hnk1h3JFHJA8p0SP6ven9UhdZq
	 5l9PY8rQfvAA9aUYAXQnRkCqd8kZdZS4Sg9ekbR6Vhf5jN7sQqrTQxqJ8aSzMZeZL/
	 Y2nNAGfnWt3rQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=sunke32@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6stD6Wf6z2xH2
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 12:49:24 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6snh2s7qzkWQG;
	Wed, 17 Aug 2022 10:45:28 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:48:49 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:48:48 +0800
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220815034829.3940803-1-sunke32@huawei.com>
 <YvsoIFzRlGpqNZKg@B-P7TQMD6M-0146.local>
 <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
 <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
Message-ID: <e1369566-6459-2eae-35f4-818865a7df20@huawei.com>
Date: Wed, 17 Aug 2022 10:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
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
From: Sun Ke via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sun Ke <sunke32@huawei.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/8/17 10:41, Gao Xiang 写道:
> Hi Ke,
> 
> On Wed, Aug 17, 2022 at 09:44:46AM +0800, Sun Ke wrote:
>>
>>
>> 在 2022/8/16 13:16, Gao Xiang 写道:
>>> On Mon, Aug 15, 2022 at 11:48:29AM +0800, Sun Ke wrote:
>>>> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
>>>> it should return a negative error code instead of 0.
>>>>
>>>> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
>>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>>
>>> Minor, I tried to apply this patch by updating the patch title into
>>> "erofs: fix error return code in erofs_fscache_{meta_,}read_folio"
>>>
>>> since the original patch title is too long.
>>
>> Should I send a v2 patch to update the title?
> 
> I've already updated this by hand if you have no concern ;)
> will push out to -next today...
;)

Thanks,
Sun Ke
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Sun Ke
>>>
>>> Thanks,
>>> Gao Xiang
>>> .
>>>
> .
> 
