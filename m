Return-Path: <linux-erofs+bounces-1975-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ACED39BFC
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 02:34:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvY0V3slWz2xS5;
	Mon, 19 Jan 2026 12:34:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768786474;
	cv=none; b=HHxfU8yHdQbPPZ9uOL0ZjaxsYqp5C0VID3xSggeYEOs1oSN9OB67vwgR7baHRTJQk+b8qs+UaAsuA0QVpayEwNSBUs6mjvIo1W0e1hC1vhZsa/kLPaehuGvR69WVtnN+ctUb5KLH734qzv9XoCRR26hngCRSwUaw6fZf+9o8Otnz7Wr2ojygYuhl/m7ambATgN6ujcSVAihYWDkhHDFNKw4dua7Ga9nB8PyF7XdqYvBkG5W8whDyDgH7LBW0/hO6ZbWZt+p2Q1yseA1paIqqFjkSUALEUDiK9OBqPqCrwlCePQpNADKNocZ9XTVvLFbMjfAzQoQIyULWe2dJwS4X5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768786474; c=relaxed/relaxed;
	bh=k6HtZU31DSV0s0hhsMmtxNdGbjkHvVDM2z5JmaC5ttw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JoaBUPSyWf4S4f6w85UJY+36cHsvZRgH9QRRoS7UhgQAFbK+K8Ey2+1RgwOUeYA83rzR6cOx7gdY5kdDY2GvupztVa9MVcGtrd1CUkoyyRjADjKZ9Zo8dJhhCFwf86y9YwlOHoAyd6Ybus+eiJ4FHZh63tQkqX2ON3dvlLuLLGDYQdTIaktCLu+gOz22/6mM8SLeTFPpaQ9kXXOUKbbYeHFBg85vu+H4wuF2Dfgy8r7YPU5zmRm40G6FCF0iC2T0qLyX2mMxBPLhkGwZd2bIne0cUUt4jgMMvb72yFj8TEby1inwZxK+BF3yG9UUWS0Q9AxTW9NpgBWEHXJY7j6XUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ji1Q1BTL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ji1Q1BTL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvY0S5SsQz2xRm
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 12:34:31 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k6HtZU31DSV0s0hhsMmtxNdGbjkHvVDM2z5JmaC5ttw=;
	b=Ji1Q1BTLigZODe9ga0Qwmt0qWNF0ppSgMCMS1P1DZWPbonxipxS2uE5YyQlLS6D+1dvrRuUof
	1GyxiJa+HBVelScb58AXuKnDBYlE1un4JDxJOkEdTwGUOwCM1X+QFbnoGKyRNbRzOJeeeTfLJU8
	a4B2zF7fZtyjMgbFfjtVWSw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dvXwQ22mTzRhQN;
	Mon, 19 Jan 2026 09:31:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E6B94404AD;
	Mon, 19 Jan 2026 09:34:24 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:34:24 +0800
Message-ID: <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com>
Date: Mon, 19 Jan 2026 09:34:23 +0800
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
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Content-Language: en-US
To: <hsiangkao@linux.alibaba.com>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-3-lihongbo22@huawei.com>
 <20260116153829.GB21174@lst.de>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260116153829.GB21174@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Xiang

On 2026/1/16 23:38, Christoph Hellwig wrote:
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> 
> Normally this would just use #ifdef.
> 
How about using #ifdef for all of them? I checked and there are only 
three places in total, and all of them are related to 
FS_PAGE_CACHE_SHARE or FS_ONDEMAND config macro.

Thanks,
Hongbo

