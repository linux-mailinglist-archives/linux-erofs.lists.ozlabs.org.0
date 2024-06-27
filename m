Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18512919D21
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 04:09:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gDjaYnzm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8hnj29Hyz3fs8
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 12:08:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gDjaYnzm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8hnb0xJfz3fpc
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 12:08:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719454124; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CMxvaX6g7HGFwrCzrjHt2gTPICeAo4dsZn/PpwJIyuc=;
	b=gDjaYnzmfIVTYVIe3AAJMwk4G+BAYacl9NArenQBBQJQAiagM6CRSq+8Qmjde85OTiVICB16OizM36Y3nw689dlOHlMn89F8Ic/1Du2ZGzLyf5eTBnIdE7TK6Npti8b8rFUwnvEpRe8IKNLQt0CXHqKe2TYyV8CM+oxhElxACfg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9L3mkX_1719454121;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9L3mkX_1719454121)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:08:42 +0800
Message-ID: <d97a1e87-9571-453e-909c-4de17d1d67db@linux.alibaba.com>
Date: Thu, 27 Jun 2024 10:08:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Baokun Li <libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
 <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
 <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/27 09:49, Baokun Li wrote:
> On 2024/6/26 11:28, Gao Xiang wrote:
>>
>>
>> On 2024/6/26 11:04, Baokun Li wrote:
>>> A gentle ping.
>>
>> Since it's been long time, I guess you could just resend
>> a new patchset with collected new tags instead of just
>> ping for the next round review?
>>
>> Thanks,
>> Gao Xiang
> 
> Okay, if there's still no feedback this week, I'll resend this patch series.
> 
> Since both patch sets under review are now 5 patches and have similar
> titles, it would be more confusing if they both had RESEND. So when I
> resend it I will merge the two patch sets into one patch series.

Sounds fine, I think you could rearrange the RESEND patchset with
the following order
cachefiles: some bugfixes for withdraw and xattr
cachefiles: some bugfixes for clean object/send req/poll

Jingbo currently is working on the internal stuff, I will try to
review myself for this work too.

Thanks,
Gao Xiaang

> 
