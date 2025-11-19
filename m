Return-Path: <linux-erofs+bounces-1412-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A87C6DB77
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Nov 2025 10:28:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBGPg11DSz3bps;
	Wed, 19 Nov 2025 20:28:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763544519;
	cv=none; b=fW4EkIcMPM3FrQ92QGNXhOUbIQqYx8ssMIPM7SywQ6kBAspQKTO8UXnRTSbUUdzTox/TRWAbs4PrI0O7F0ZSgD4uiGN5AP6FP7XhNllyn2V/06gNlYJQm4gtOF95y3LaQ1RNmC1tf9n3hNTNh10KXoQlCLWXL/ySrNLKbdGB/9SZCbUUOzRBInBO+Nan3iOsH+f/S0T5ecGPVytkUUBXbMx1lxbIFKErS6S9udFUrW4vrFu+oaU7YCbpMyocQi1IIsFTIVrc98DIEXemJPFwN/wtSDhXzudWCB7BI3OuIflr5Z+ZrDLRzuiZO+LRjqm8pzYOnbImOtcLbfOK8/LS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763544519; c=relaxed/relaxed;
	bh=i6/vAufc4D2l5WEhS+pcUMoKXwjumMPqeZkC60gdnbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USg2tKv0/uGv2XiGw2fNcmWlF6FfxC0scia1UWrQg9SD3ceml+F2dMfXKsYConVOpfleep02lGuogOSDxRT/wdJMaCZY5cCOiDzL/zIYMLwgMCw1O9uFTxVE4zFi8oBiVSeiY/1kem4pHgrX2QTON3v8pnE4AytfVxylcrfGQ2bcFyzQWAH97Nt/LUK4VUwJNMApPjveGyxGY0BpDyp3sjpW9jpQHkw2eWaiQenYRhuDH2yDr6Sd6z1A7xZsfuR64BwXy9+IgrntI673M8z9icAx3Ql/HsvD+uCM0EeeWq6rnH1V7yz72rOA24/KplzCzng5ZJk7f/2XfG1evvbwqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KtqwIYLo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KtqwIYLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBGPc2Zwbz3bkd
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Nov 2025 20:28:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763544509; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i6/vAufc4D2l5WEhS+pcUMoKXwjumMPqeZkC60gdnbs=;
	b=KtqwIYLooczrHDkC0u8kU0sBtIR6THjn9/nQBFEwLgllMlE0ORj9VfMxOgWZ7dOGEwetIQe5M2P3T8x859FwfDXjOa9v2/hHIzOcM87JGCaah+e22zxG2f8r6/6iX5H/+E4Y0b8CJ/7GsuM/kUfcwa601mygJWlkytQTk2ld4zI=
Received: from 30.221.131.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsoC-64_1763544507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 17:28:28 +0800
Message-ID: <2ec53eec-12c5-45f9-bd7d-03f98d03a384@linux.alibaba.com>
Date: Wed, 19 Nov 2025 17:28:27 +0800
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
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
 <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
 <20251119054946.GA20142@lst.de>
 <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
 <20251119091254.GA24902@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251119091254.GA24902@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/19 17:12, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 02:17:07PM +0800, Gao Xiang wrote:
>> Hongbo didn't Cc you on this thread (I think he just added
>> recipients according to MAINTAINERS), but I know you played
>> a key role in iomap development, so I think you should be
>> in the loop about the iomap change too.
>>
>> Could you give some comments (maybe review) on this patch
>> if possible?  My own opinion is that if the first two
>> patches can be applied in the next cycle (6.19) (I understand
>> it will be too late for the whole feature into 6.19) , it
>> would be very helpful to us so at least the vfs iomap branch
>> won't be coupled anymore if the first two patch can be landed
>> in advance.
> 
> The patch itself looks fine.  But as Darrick said we really need
> to get our house in order for the iomap branch so that it actually
> works this close to the merge window.

Sigh.. I'm sorry to hear about that.

Anyway, personally I think patch 1 makes no change to iomap logic
(so I think it definitely does no harm to iomap stability), but
opens a chance for iomap users to control iter->private and pass
fs-specific contexts from iomap_begin to end (and patch 2 uses
this to get rid of kmap_to_page()). So honestly I'm eager to get
patches 1 and 2 merged.

However, it's really up to the iomap maintainers. Yet, if delayed
to the next development cycle, it might still need to resolve
cross-branch conflicts, and it could still causes some churn,
anyway...

Thanks,
Gao Xiang


