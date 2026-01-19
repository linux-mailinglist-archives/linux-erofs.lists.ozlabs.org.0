Return-Path: <linux-erofs+bounces-1973-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C1D39BE8
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 02:23:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvXm60dG9z2xS5;
	Mon, 19 Jan 2026 12:23:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768785830;
	cv=none; b=iNHoVCqBSHoo6Euh3vxrsrCcT4g/YPVJOtR0u0xDnRTX93nipwUBk1QrC/6WcFvYbetDRK7I4XsLY0YZQ1K1t8pcMsRscjeQXzdn/DV4dpzI0t6xIZn7RU540QSIeNah+ZH3TA+ctz7f7RXqHgHu1x2KG0CBC+q+nhCVQGbPZ69kHyiVcY/nniE2/EVlVLNaAzlRFPiIkxA5959N9Bu6qjh2JOLE2rZy3YChyokTTSACR+l+VMIb8j/FIiA43JMj/5DrWXAMnnZpJUJLxi8lmG7y4lgvXOmvuJvajcjVjmsRrpfbzxj/3uRm+xMRAdgpciMEzS14+QAC29OFpgoMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768785830; c=relaxed/relaxed;
	bh=gba2ktAjy+g71eevs0XUENyEHWbD0Qkbdb1/QKJXxK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O3svNanj+XQkaHMZypMEJ/5JwM5i0nriGGBBkMOIStWZBNBqJArg3n3FCBAbClM64dS1nkc29TbLFfZuVtOw4ksUFHHuhDt1WskIKE90VRr4o0jcr1nmyqlBh0ooorbaUhjpOGv+GIk5ynUWIq4wy0DrUHW6LIe9u4fzkwE0cPPP7bi9SbvBEAZ/28V825OyGhhX2JRVhkiLytaiXFF2izycQmlb48lvEghomGS+4clmNyWxA5Ui1/M9GPvcw4PgZsGw5k20mOm5KtOY2kVNslLkySSjofRF/0AxWneHgNufWxoPjCKHQTk3DlZpiiW8YYMmd48Pz9T/VnWaevKrEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5sx6wMC/; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5sx6wMC/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvXm32KNmz2xRm
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 12:23:44 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gba2ktAjy+g71eevs0XUENyEHWbD0Qkbdb1/QKJXxK0=;
	b=5sx6wMC/nc8WBo/cRYm/rpR6NqMoGK1/b5Dh82yOsbRZBDc5767PZtHZfUv8w2lvELDWgZARO
	lcxMYVF89CRW8F+V6ErvUK40hkRwkROchxRRpvwq/QShXniCu6BE9vEDijul5IDmackJNTY23I3
	aZGv4isjWr+h+/A1qplP81Y=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dvXgz0W98z1K9D6;
	Mon, 19 Jan 2026 09:20:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6735340565;
	Mon, 19 Jan 2026 09:23:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:23:34 +0800
Message-ID: <dd20d5d5-3623-40ff-8462-3a36f3b116ed@huawei.com>
Date: Mon, 19 Jan 2026 09:23:34 +0800
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
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
 <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Thanks for comments and attention.

So in short: Two files with identical content fingerprints 
(user-defined, such as sha256) will share the same page cache which 
associated with an anonymous inode. Data operations are redirected to 
the anonymous inode while metadata operations (include locating the data 
position on disk) are still performed on the original inode(realinode).

Sorry for the ambiguous annotation, and I will refine the cover-letter 
in next iteration to make it clear as possible.

Thanks,
Hongbo

On 2026/1/17 0:43, Gao Xiang wrote:
> 
> 
> On 2026/1/16 23:36, Christoph Hellwig wrote:
> 
>>
>> Also do you have a git tree for the whole feature?
> 
> I prepared a test tree for Hongbo but it's v14:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/pagecache-share
> 
> I think v15 is almost close to the final status,
> I hope Hongbo addresses your comment and I will
> review the remaining parts too and apply to
> linux-next at the beginning of next week.
> 
> Thanks,
> Gao Xiang

