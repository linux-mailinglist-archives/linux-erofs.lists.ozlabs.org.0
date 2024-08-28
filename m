Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95867962995
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 16:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724853707;
	bh=FkxFFVdwX1/bT3jf5ugN2YTPZ65TkfFpCS/ghepAw8o=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZVNiv3+94i494OX9xEEYF+WPKnMPQxg8Ww3phRipi9EBBFYBXcoDrntudl/GjZzGs
	 2oZ5T9MyGo5uoKCiXv1LsXK0qA5VuegzAZQC5/+J2hg19b5z82e9FXYlVXb0adRNDN
	 nvqLVyXURSqr8NBtWUvbDncT5haiy/pWcikfv6d+sNe4XDvqMBIPeH4v7V6t2jL8ig
	 ssX4G8Aj2l3O6xenpEqIS6paH+jT6iNBamm945eWPAS3UP5E+E9A58NIiIdz2T5YAq
	 yJnq1n1Xmg7agVjP+lDly3aNZaVZEojUtJb7MpsiC6mPHXzMTpCl977kx32L89cyZM
	 7iIdZVNXZguqg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv5gb2DHGz2ykT
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 00:01:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724853704;
	cv=none; b=cbofeE5PijUtOb9+m1j0y3TeB2JD1NvP1s3oouZqO/t+jV+d36l7dIb2PhLNFvkhc786ti98g39ZMI5nPqiYy6TGtxwdFHt9C+U2e5OojuO9A1kOOoQnQmQRp6cN+SzAXSjAXy/HYYGLDGrFjgsXGFWYrYgrO6DHRl+tDUw0enCQsqwtkSczYLp36TARi5TyJf6J7EcN5sP+/hRQhc4hrnKf0QcVX9Nn1POIX4dfZTc3QfHVb0DpYfgNUv1drzHznM1gbIFks41mLe2HcHcrLFbUs8eG42n60Lf92y6DOkx+HbWm0Fdlz8R4vvsf5lWwSYEw3GfYmNXwJCOY8Mi8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724853704; c=relaxed/relaxed;
	bh=FkxFFVdwX1/bT3jf5ugN2YTPZ65TkfFpCS/ghepAw8o=;
	h=X-Greylist:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=cNWReRSjJCZzz8kOAX1e34DG6LlIp8v/Pvf7U+sW89umK6nXG81QAVmFGw00OM1+IquofpvUtcNj+FilxesyXtKLG+7TSfDJGWVBd1aIusnqUJOHxyh1hZSTKgrb0GTa/YPg8c8mH1a0mfTgmISc5R3OOegWbfwVtmC9ppVwNfZOmHLDxRR4h1emHZA01BzM7f4HYl8RyqZdtCNbpopIAC/pKc5aVTMwFYvy5nXfHOpNkJgGQULJqMyW4qQ1Whbwo2ynDlFrhuOq7M2KzuFGr1U6xiWwjD5GGTFhGwsn/BzUdghJMPGPkOZCrs0di1cJvhSgxTVH71HjzNH+kkv2TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1110 seconds by postgrey-1.37 at boromir; Thu, 29 Aug 2024 00:01:29 AEST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv5gF6KM0z2xZj
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 00:01:26 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wv5Db5c8FzyRBl;
	Wed, 28 Aug 2024 21:41:51 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D35180105;
	Wed, 28 Aug 2024 21:42:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 21:42:21 +0800
Message-ID: <a64ff81d-3b3d-44e8-9a1d-0d226dca2c8a@huawei.com>
Date: Wed, 28 Aug 2024 21:42:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: Christian Brauner <brauner@kernel.org>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
 <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
 <20240828-federn-testreihe-97c4f6ec5772@brauner>
Content-Language: en-US
In-Reply-To: <20240828-federn-testreihe-97c4f6ec5772@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100021.china.huawei.com (7.185.36.148)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: Baokun Li <libaokun@huaweicloud.com>, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/28 21:37, Christian Brauner wrote:
>> Hi Christian,
>>
>>
>> Thank you for applying this patch!
>>
>> I just realized that the parentheses are in the wrong place here,
>> could you please help me correct them?
>>>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
>> ^^ remove_proc_subtree() instead
> Sure, done.
>
Thanks a lot!


Cheers,
Baokun


