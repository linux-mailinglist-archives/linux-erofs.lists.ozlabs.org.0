Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5769372E8
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 06:00:29 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ttDpAyVJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQGDC146Cz3dSR
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 14:00:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ttDpAyVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQGD301txz3cWF
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jul 2024 14:00:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721361613; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UqRrTEvHfpn+b95InrFhWI/3PC88wGrzwJLkDzZMIYY=;
	b=ttDpAyVJh02aVsl2jBGvzbs6enC55GmEp8RZOplsSwE+WWF821tz06rd5s8z6YNIXdipNb08on7/TfozweaFSUeR6K9o4sbBcnmFiX2ER8c1dFu42Jv3DHiYtVuUCsQTXMJFoC7bRoxlVucn/oll0sXMv4QDH5h1Hzibf8nS3/g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WAqVrfK_1721361611;
Received: from 30.97.48.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAqVrfK_1721361611)
          by smtp.aliyun-inc.com;
          Fri, 19 Jul 2024 12:00:12 +0800
Message-ID: <a494d512-e54c-4864-ba35-e1c2acb54a53@linux.alibaba.com>
Date: Fri, 19 Jul 2024 12:00:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs-utils: misc: Fix potential memory leak in
 realloc failure path
To: Sandeep Dhavale <dhavale@google.com>
References: <20240718202204.1224620-1-dhavale@google.com>
 <9ad02965-11e6-4285-a915-ce6aa779861b@linux.alibaba.com>
 <CAB=BE-QsRykaLxb_VCUVxQfGvKs_Rx9X0pV6TPKJXbpOKq+PTw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-QsRykaLxb_VCUVxQfGvKs_Rx9X0pV6TPKJXbpOKq+PTw@mail.gmail.com>
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/19 11:31, Sandeep Dhavale wrote:
> Hi Gao,
> 
>> Is it a lint issue?  Although I think currently userspace malloc
>> failures is rare, it'd be better to handle them.
> 
> Previously I have used scan-build as a static checker. However today,
> one of the realloc code blocks, I stumbled upon while going through
> code on another performance problem.
> Then I just grepped and found another one so I just fixed them in one go.

Okay, thanks for the info.

> 
>> I update this as since the variable definition would be better
>> at the beginning of a block...
> 
> The edit looks better to me, so feel free to update while applying.
> As always, thanks for the review.

Let me apply the patch soon..

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.
