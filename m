Return-Path: <linux-erofs+bounces-1816-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA7D0DFBE
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Jan 2026 01:01:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpbJL6f6Jz2yS0;
	Sun, 11 Jan 2026 11:01:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768089666;
	cv=none; b=IZwj76N2CT28MU1aO58ccuGFoschDb9GBD3bvL1nCZhSgsc50bPFnU9Zm+fWdrACSWiyPB0kpwUjLHw0gicjOOADbEol6RO1To8w8g3Zm8ZAKKk8XIbuxXBDqpKtU5uqYZusWRFld44sHPAnzM0KY1eRlzs8luse3NSamXfy2vcuZjxTR9izDeEk6+Kz/PVD21YQBA2MexViX8ulHlwFbDalwh5/dlEi1JNg1aly6lqkPaLT4//juMI2iRoEBIKobRI0yo4AkYuzZGBf7UwfZKlC6d+c3MXEiYa4teyg0eerRYWposAPUaOcQ5I5RPdMbov8e/n40T61ZsmtDzyyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768089666; c=relaxed/relaxed;
	bh=Oltf8k1fkrYtGSXqp7FnzUDOJNtaBX0DyT4NgUY6KJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSyfjZlwsF6HUxU8ZjpPMD1FZC01QxGLgWsCQrO/+hDMptUwZjTaSC/yU0AmZVw93PqogFpfgEIK180ndtRZJjCQxmNckhhPc75HKQzcpJ8NnHzpBLk+vfDITBXA/G/pG73CSsC6Buvq0hQxC/Blp+ZfWu9koQPIHZnfGGV8roC8MNLULTcCvnZIuOvPd2q+qs3Yg78YQdc+nZ3UONn5Tq/nNsY9YLFKECYZwvYaDCXA5czQ8a/DzmkniW8ggIZ4hktQJ0e7mlakTSAO9CXE4q/n0kHSndhwIMiBVaelaraHoYe4mkNUvVConBNxcXwfAIfw/Ce4tV7Go6bYZiRoeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jPXp6nNs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jPXp6nNs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpbJH1267z2xqr
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Jan 2026 11:01:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768089656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Oltf8k1fkrYtGSXqp7FnzUDOJNtaBX0DyT4NgUY6KJY=;
	b=jPXp6nNsVUOXAcX5/BvvfvFs87ps6jRFzMD8Uu4jBq4vtOmoa7CbWd/gyIKsU/pwY4FhSBrPCGrDK8Dz8DYJWgy5Fx6wj3ux6YVYNQo4bA7ZLHtYBdmhUOTmR2EOPQIrlDCTcJUeVQivmmq/CNV+yHlTSs4rernXQURT+Ambyg4=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwkx0lj_1768089653 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 11 Jan 2026 08:00:54 +0800
Message-ID: <d506b6d5-39f1-4cd6-b65f-5b1136f82822@linux.alibaba.com>
Date: Sun, 11 Jan 2026 08:00:53 +0800
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
Subject: Re: [PATCH] erofs: fix file-backed mounts no longer working on EROFS
 partitions
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>,
 Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
References: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
 <20260110114703.3461706-1-hsiangkao@linux.alibaba.com>
 <CAHk-=wj0cUvcmpdm=xHTMXuBRTciD=Ytckg5cO2gT1SkZfVWFQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=wj0cUvcmpdm=xHTMXuBRTciD=Ytckg5cO2gT1SkZfVWFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/11 00:42, Linus Torvalds wrote:
> On Sat, 10 Jan 2026 at 01:47, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> But sadly I screwed it up again by upstreaming the outdated [PATCH v3]
>> and I should be blamed.
> 
> No need to be quite that harsh on yourself. Mistakes happen, and this
> one was fixed very quickly.
> 
> Patch applied. Thanks,

Okay, thanks very much too.

Thanks,
Gao Xiang

> 
>              Linus


