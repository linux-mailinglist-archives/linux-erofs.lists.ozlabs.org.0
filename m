Return-Path: <linux-erofs+bounces-751-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD5B19D90
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 10:26:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwV5C4RrLz3069;
	Mon,  4 Aug 2025 18:26:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754295983;
	cv=none; b=gHGW7NN3mSitQ450sYW3n7IhOi1wWcRC6RCf0KEewJ0UdpHEsoAJBbm9BY64AzZXrF5WQ97/xJiZL50DNCLKWxVScHJw39mgFuHVA9pXlapSnGR1glL2KhjjnnscjI2l2b3/i8pIH2Td+4eC2Z4aBWWC2MMd83m1a5JHVitZd0WoyjL0Fbbwam7Ivq3SV4l9R4G5+qp69kz0YuCB+WTRXL/V55wjNmhkfE+sMTTZ11hXFfAdymEgTXBynlDEowXT0WhZ7+LYNXlyX84dT/078zgmmxtIu0ScYjkq2Q5Nrd/hKJ9r5aPvGZmhEAxtkNTavP54xtoGfLUU1gBFTGqF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754295983; c=relaxed/relaxed;
	bh=j10W9Lpd8D92gPWm5A/bFagYrxGhiQhP+JM4BlPbc30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK1j/3plSbw2NtKqNQFwPNMFtZIG5Nx+FsH/SR0lKpKmdLp9EmiKtyWq8kHD3RR25sFLoJSrRKqSMoOK67oHciEbWthj8zsU54+m6ZeDGq2eG8U54yGxI5St0x/bzYjEQFbd/ZrS6eDF6TSFn7dcmd2IYUe1x1BGFlbhav7y5vtCPVr1GG+YIiylNOkmGRAO7Kw2cR0yAgcaJrMhBVxwilCodpV++vrAdr8gNm/s1HIxLQmLJj4KQgBx91C/GGa2MgotEYQ07zFu3l5dxJvax3H2AVlq/hoXzTsRLJaDLXHorGliB17DSMn3mCOT0xRsBzeFEWABpCd45XMYq7t98Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HQO3+zQC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HQO3+zQC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwV594jXXz2yPS
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 18:26:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754295977; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j10W9Lpd8D92gPWm5A/bFagYrxGhiQhP+JM4BlPbc30=;
	b=HQO3+zQCQ5x4eG4KH0dlcehksw4c5Hqq1ZuCsD3P0hx5QF/bI8OIJGQBs+F7cw6lrZl5RhCvRUMBDjnvwUbUbu9Pmoy+Qx4VS346IrN0AoLkdkBGJf5meruXX6veI8m+M1ZxvyOw9sRDkrJfie1Zg/pOgJHH568WsgBIpQ/cYF0=
Received: from 30.221.131.110(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkxggoW_1754295974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 16:26:15 +0800
Message-ID: <a65ecd99-7292-41a7-8fb2-41dfb29c1ff8@linux.alibaba.com>
Date: Mon, 4 Aug 2025 16:26:14 +0800
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
Subject: Re: [PATCH v3] erofs: Fallback to normal access if DAX is not
 supported on extra device
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, Friendy Su <friendy.su@sony.com>,
 Jacky Cao <jacky.cao@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250804082030.3667257-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250804082030.3667257-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/4 16:20, Yuezhang Mo wrote:
> If using multiple devices, we should check if the extra device support
> DAX instead of checking the primary device when deciding if to use DAX
> to access a file.
> 
> If an extra device does not support DAX we should fallback to normal
> access otherwise the data on that device will be inaccessible.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Jacky Cao <jacky.cao@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Still looks good to me, will apply after -rc1 is out:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

