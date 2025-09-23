Return-Path: <linux-erofs+bounces-1067-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C71B94033
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:34:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3wB73z5z3cYN;
	Tue, 23 Sep 2025 12:34:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758594874;
	cv=none; b=K47Tol1oCBJ8LzGYqugNHYw52VROrGNIlkioMok2RIBpFNG2v0o2bz3TLL8ctjSPpsWgP/pMd+aWWWsPLCvO8f1yEQ5np3OWz+M/z0TGOMhvZexubFADkNZx7WdAhAQATHrHd6nIiE470jUDzlCW05JI0EvXDdFFPpsllt8UJPYdyUB2G+D/vTjY+88zBWrzEj2G6+42jE5msarJpiQUaEHQ5tPaIpbcLO5k/KJas2yDgr4+GUljmPI9OOqgWIB0LHsQOQdOobYRRzfaoXhAxnu46wVUcCvz6hsrCQVMHaSVNtUoqU5sArtW65xPHJ5e4SS/XS9yijbek0KHVRsa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758594874; c=relaxed/relaxed;
	bh=DvgLv2W5sn5O7MiD/dFRPsjAH496hntEQ0i1HALiM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1jhFXWNBqPfoaaiQW+9+2mCuvqn84zbZZN0rEvn7FV6POo7lEC7xMBkP9BcX/0oy8RmJW4265U0mS51LyCawi8U8iNYxE1M8kvh8UTdMpADjW1DVzl3dWUoxBbgYHjzeUTsUZqTdnR0VScpDiC3pI9afLBDpiM7bJw62C8/KWOQ6zO/cyeQQmWiZkskhfLMeHahNoSPsAK4SBHl971/rSO1zWcruOKmCm798WJgoULkyNSr6UV2QK0QdH4dZOHAEH9gchEoCbhweqZjpyQ43oa0clvpg8eojV0SHRtaHi0/eq2iXuQ4vQ8ieMR0h5eKBkDuT4zZuiJNB4n5U4jxMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IMQHdetu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IMQHdetu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3w90s9Tz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:34:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758594867; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DvgLv2W5sn5O7MiD/dFRPsjAH496hntEQ0i1HALiM5Q=;
	b=IMQHdetus7VOrH96nMazzkgen0vuIOf35jVgmO+w9c2HKLWGamMx8WQUJPpW8TqxyY0ajqUbw9lD4vgySJ9Hji7rlgz9LDVznfWI78vGGUUT/rgPc2U5syCuoUYaZ1pCcH9JewPuc7hNGyTKG0v3zEANHNHwqae9ZLsEDMeIdr8=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wod5Xby_1758594865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 10:34:26 +0800
Message-ID: <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Date: Tue, 23 Sep 2025 10:34:23 +0800
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
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/9/23 10:23, Chao Yu wrote:
> On 9/22/25 17:29, Bo Liu wrote:
>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>
>> Add support for reading to the erofs volume label from the
>> FS_IOC_GETFSLABEL ioctls.
>>
>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>> ---

...

>>   
>> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> 
> #ifdef CONFIG_COMPAT
> 
>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>> +			unsigned long arg);

Since it's a function declaration, when CONFIG_COMPAT is not defined,
there is no user to use erofs_compat_ioctl(), so I think it is fine
to just leave the declaration here?

Thanks,
Gao Xiang

> 
> #endif
> 
> Thanks,
> 
>> +
> 


