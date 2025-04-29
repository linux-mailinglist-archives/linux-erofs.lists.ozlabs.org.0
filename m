Return-Path: <linux-erofs+bounces-258-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD9AA00FF
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 06:00:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmmmw6Yhnz3050;
	Tue, 29 Apr 2025 14:00:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745899216;
	cv=none; b=IZVxZQW5avrSfFstEVNH4v5BuPQKajP2DwFLeylNCwO/z8997E6EDtDucmbfj6gUUL1cPMPJcExOlGUXsU/hEgTw1c1/39lqjTU2OxK6MLEOUUDLBrINumVvGuDGft9dXQ+h3g71np+mJxuA4ulogPmJeSqSGgtXaRVnZ3rdEbFokcA+iBmHwVEr+ZGDKD6XSyIXGxIfHgfPyEh2RfaKi11dVvoMJgtZCyvUpQsUYmf8sRiOzmsSgpu1lWeI7VahDcJRCESA55+9mQ1LOGoJtUBqkky/d3b4Bco0E1NcjYP7uSVZwsszQfOhazGekndOpeLW4dJCyvqSCb4YSXNwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745899216; c=relaxed/relaxed;
	bh=sR+v3+9uoAyaWL7QHTixjdaDNQFFdcIvHSBPkEZuxpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGjbxxMYA7B2Th+Gvi2iWfwT+OzGlURu/0xEwsx2UzIenGfLQ1t6I/xub0SyoQRY7S2V/FTzuFyT5QL7N2G1Y5hFP0JxRkUj1bKXiaScfja2SO1qFPfuJzpI1pkVQKuoJnlleRPem4k+TxIPoZ3yrqKU2Bo/IL243hlBENhlV+MWatp9RZAZpGsMs1EcoiNjY4MJQpxu+4zQYUnbTypjuRa8UJgoZi+uMDFWbZSdvs+ss7AhyKMzBRyR5hTiiTHnETBLIQgGqbYMP1uVe4/Q3QD/QwaRfvl+d98FPOm+7MqFy52888PwLsJm91nUI8d62Qe6GC8R0BmWcGykb6I9iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmmmv6yCWz2yfv
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 14:00:14 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZmmmJ27H3z2TSDC
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:59:44 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 34B921A016C
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 12:00:08 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 12:00:07 +0800
Message-ID: <7fbeb0c8-6608-4104-8c2e-fe1902ed6af5@huawei.com>
Date: Tue, 29 Apr 2025 12:00:07 +0800
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
Subject: Re: [PATCH] erofs: reject unknown option if it is not supported
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250428142545.484818-1-lihongbo22@huawei.com>
 <aA+bsw09PHTQWUXK@debian> <22e9fd7b-5e45-4f7c-b9fd-36e76118653f@huawei.com>
 <aBBNf1u+8yyAXrV3@debian>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aBBNf1u+8yyAXrV3@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/29 11:54, Gao Xiang wrote:
> On Tue, Apr 29, 2025 at 11:46:39AM +0800, Hongbo Li wrote:
> 
> ...
> 
>>>
>>> Another thing is that I'm not sure if "user_xattr" option is really
>>> needed, we might just kill this option since all recent fses don't
>>> have such configuration and user_xattrs should be supported by default.
>>>
>> Yeah, perhaps this option should be removed along with
>> CONFIG_EROFS_FS_XATTR, as xattr can be also consider as a type of data that
>> we cannot modify.
> 
> You meant remove "CONFIG_EROFS_FS_XATTR"? but some embedded
> use cases don't need xattrs anyway.
> 
> I mean just kill "user_xattr" option and leave user xattrs on
> all the time.
ok, it seems reasonable.

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang
> 

