Return-Path: <linux-erofs+bounces-1481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C09C9B32C
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 11:41:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLHQ20HqTz3bqV;
	Tue, 02 Dec 2025 21:41:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764672105;
	cv=none; b=ZMdNkNI3kSq5x15O7l2ZG/dyOsm1Kh611AMQKjfxd8ORsn1RIziYh9Q3gcxwiQVbnUC+8EFarjZjnlrEMRyn7rp1YWrHdb38u9ZaX1d8S1y8vccjrgARK/7ul+kamT8aA6mTurS52+wKcaJihsKKI0iV5d0xqAgVsNQuPC8qJII6kGsmoHMLnb04iy+03Ml+A+2VUfa2j+6Bsagw8jcPKDBAraaKWseCyVbNddRDqJsQW+iKgNN9k6DVQiQy2LpiBJJEr1vtT2FTKRRwRfsDx4x4A4t7MsuhfTBTrD8159OgyfBu7kP2D8boCfcEieAo/9OCjHndY11Jg3/FZxyiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764672105; c=relaxed/relaxed;
	bh=AfWaGC9hvkKweRfQvUzcg8W2yiPjS/1fsTmCqBqQ/bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+Uay7pOPWVaNaeZOkir0a9lLSmBnXns5P0z+ihXdo99ONJTcVm7bUbIS7xa4oG/aApzqj/B1rseBwIYFiT/hdQ3vssdjt9m1+bSb6PpEStzvIoBwdpn3O66C7q/h1wzNRHe7sTJ52c7x1AsVxnzxsKDwmgNAKxwpLvF6vjWSmoUUywTws19LJ/UPoZVH9KiDGdODm8VZjjn5hf94IOLd5jQsNxvc3ISGtM8QO8YwVZ67t+VF0Cxn6PfMfex44CSq+jFr4/tuqCownihs3Tj2Cl0LMfBbQoKKafw98A4GtgtQqcJVc65JnvTL2CFhlrOP7tfdoZCi/dCY4cwTw/43Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=giiIyISL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=giiIyISL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLHPz6xr9z3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 21:41:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764672098; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AfWaGC9hvkKweRfQvUzcg8W2yiPjS/1fsTmCqBqQ/bs=;
	b=giiIyISLX9S+keaIJHJxnbrahC1FuTKoKcvViOe+Pgj9syJH9MQq+9/DgPF7j3DhQ1auIoO88AwaatkHrwS1f+aJ+82YzNypSmi8pgQqKL4qPZK73JwOvbyl/gumwYTfbkuo4FMcMSbSYS+Is87iS82xFQkZDsGpDpQmhwkah8c=
Received: from 30.221.131.182(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtwAsn3_1764672095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 18:41:36 +0800
Message-ID: <333670e0-cebb-435b-afa2-ce0e3191a173@linux.alibaba.com>
Date: Tue, 2 Dec 2025 18:41:35 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to
 registry
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, hudsonZhu <hudson@cyzhu.com>
Cc: linux-erofs@lists.ozlabs.org, hudsonzhu@tencent.com, wayne.ma@huawei.com,
 jingrui@huawei.com
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
 <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
 <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
 <b1a8afa4-c297-46ca-8b0a-b96e60bf09f7@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b1a8afa4-c297-46ca-8b0a-b96e60bf09f7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/2 18:28, zhaoyifan (H) wrote:
> On 2025/12/2 15:40, Gao Xiang wrote:
> 
>> Hi Yifan,
>>
>> Would you mind updating mkfs.erofs manpage too?
>>
>> Thanks,
>> Gao Xiang
>>
> Hi Xiang,
> 
> Do you mean document `--oci` option in man/mkfs.erofs.1?
> 
> Seems there's no manual about `--oci` and `--s3` there? How about adding them in a new patch later?

Yes, a seperate patch is absolutely fine.

Since it's about time to release erofs-utils 1.9, so it'd be
helpful to update outdated manpage.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Yifan
> 


