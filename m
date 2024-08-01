Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CB944C7D
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 15:07:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hzo7sshw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZTlv3PGHz3dRK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 23:07:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hzo7sshw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZTlp4H69z304l
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 23:07:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722517664; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UDdqzqcOpnyvDBGC4wa7H8c+PBL3yZcFFABZ2FxV0is=;
	b=hzo7sshwBZHdBgZHCkGBRe9aD6NbVXa8/tHjnM6M2yw8DC+AvYnkTf+VSw+gGU9fuDzhKdDoHIIAxxVnDqjrAC2yLTTH6ERZhReE3Br//WrN7qHufnx5T46MA82QyD10H9jAfBhUvevqhGP76FwXUW6HFt4GgwfvYDEyXXj3L40=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBtoPmc_1722517662;
Received: from 30.97.48.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBtoPmc_1722517662)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:07:43 +0800
Message-ID: <e1653f52-1a3d-4730-9f4b-e00cecc69188@linux.alibaba.com>
Date: Thu, 1 Aug 2024 21:07:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
 <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
 <0f83044e-5024-4c99-a7f8-323cc2b2abe0@linux.alibaba.com>
 <216d4c7f-66c0-49e7-89ef-969576b21c13@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <216d4c7f-66c0-49e7-89ef-969576b21c13@huawei.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/1 20:59, Hongbo Li via Linux-erofs wrote:
> 
> 
> On 2024/8/1 19:35, Hongzhen Luo wrote:
>>
>> On 2024/8/1 19:31, Gao Xiang wrote:
>>>
>>>
>>> On 2024/8/1 19:26, Hongzhen Luo wrote:
>>>>   - Use i_size instead of i_size_read() due to immutable fses;
>>>>
>>>>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
>>>>
>>>>   - Remove unnecessary lines.
>>>>
>>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>> ---
>>>
>>> What's the difference from the previous version? why not marking
>>> it as v2?
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>> The previous version was corrupted and couldn't apply the patch using `git am`. Sorry, I didn't write a changelog. I will provide a version with the changelog added...
> May be he also means the subject should be marked [PATCH v..]
> 

Yes, I've told him offline.  It seems like spam flooding anyway :(

Thanks,
Gao Xiang

> Thanks,
> Hongbo
> 
>>
>> Thanks,
>> Hongzhen Luo
