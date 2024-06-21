Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023289120C7
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 11:37:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1718962661;
	bh=DpHvclvow/6OV4nEWWcOIEDTbTchBV4vyZD9AwzSLao=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aAZQ6spmJJEeUyTp3uk+XJxEtm6hC0uSuTgxj7BNFo6KVuXyNXUhOhSBoCfbqCfDC
	 LWg1b9uCCSfBSu8OVX/tC05LL55oyLQvrTmmp+hBjLaBuRuKoc5aq1IYIF9c/251OZ
	 V8XQjO81KE1/70kIigKgPMzk/map/1dLUHahe1g26FaZ+QFuBtS9ZrpZc7VI500XqV
	 l0p4kz+CUKUpGM2rBdfsYohUxVuLVzlkFdgxAwJuHl5lDmwHsdRbyKg3wTkRiAa4LU
	 VdOu9OBPcVgxl740nTjU0PqRIveNfu1w7b2qb+9XBAJrGJwLqsytH2lmxcE2R8LulE
	 qgMQMRKmeO60A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5C2F4RNlz3d8M
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 19:37:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5C276DdKz3cSH
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 19:37:34 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W5BxW1TYkz1j5WY;
	Fri, 21 Jun 2024 17:33:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 87599140109;
	Fri, 21 Jun 2024 17:37:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 17:37:30 +0800
Message-ID: <1fe0f4e5-37b0-4bbd-bcd3-9764f65660e8@huawei.com>
Date: Fri, 21 Jun 2024 17:37:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <dhowells@redhat.com>
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
 <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/21 17:14, Gao Xiang wrote:
> 
> 
> On 2024/6/21 14:18, Hongbo Li wrote:
>> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
>> module. We cannot know whether it is supported from userspace, so
>> we export this feature to user by sysfs interface.
>>
>> [Before]
>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or 
>> directory
>>
>> [After]
>> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
>> supported
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> I don't think such sysfs is needed, you could just use
> `bind ondemand` to check if it is supported:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780
> 
Thanks for reply!
`bind ondemand` can check if it is supported, but it requires a more 
complicated procedure for user to implement. For example, a serial of 
system call (open, ioctl, close) are need.The containerd snapshotter 
daemon relies on these feature, only use a simple check method is usable 
in product environment. The snapshotter developers may know how 
cachefiles works, but for snapshotter users, a simple way to check 
whether snapshotter can be launched is useful. Even though they do not 
know how cachefiles works.

Thanks,
Hongbo
> 
> Thanks,
> Gao Xiang
