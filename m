Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE37F0B0E
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 04:33:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYY4l6kq8z3cPS
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 14:33:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18; helo=out199-18.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYY4c30R3z30fM
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 14:33:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwfuOLj_1700451172;
Received: from 30.97.48.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwfuOLj_1700451172)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 11:32:52 +0800
Message-ID: <06eb8c00-3ee8-7004-ce2c-cb84cf03e970@linux.alibaba.com>
Date: Mon, 20 Nov 2023 11:32:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: erofs: add EROFS webpage
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
 <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
 <056d09c0-eb0d-2092-0766-bf253a9d8751@linux.alibaba.com>
 <43466ecc-7218-e813-7a4f-bcce30f9b3fb@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <43466ecc-7218-e813-7a4f-bcce30f9b3fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/20 11:31, Chao Yu wrote:
> On 2023/11/20 11:23, Gao Xiang wrote:
>>
>>
>> On 2023/11/20 11:18, Chao Yu wrote:
>>> On 2023/11/17 16:53, Gao Xiang wrote:
>>>> Add a new `W:` field of the EROFS entry points to the documentation
>>>> site at <https://erofs.docs.kernel.org>.
>>>>
>>>> In addition, update the in-tree documentation and Kconfig too.
>>>>
>>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> Nice work!
>>>
>>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> Hi Chao,
>>
>> Thanks for the time and review! but I've already do a tag this morning
>> for Linus later so it may not contain this tag, sorry about that.
> 
> Xiang,
> 
> No problem, it seems I replied a little bit late. :-P

Yeah, since all commits in principle need to be in -next.  Thanks again!

Thanks,
Gao Xiang
