Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB85997BA5
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 06:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728533327;
	bh=CEkGMWeXeG5EIKzooRFp1bexvUcTd1W76MvtznBRNC4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TaVc+oNk9winZQii+xZcdIZetSRSu5u4BKJuKgzN9U3iIo53tCeJ1NVq6BmcDxlil
	 S+8icRqAeHq7fx9TA6YUFetEMFvJwXc9McsgMLg3EXYBNGsKwR8ji9LasIneyKgEBy
	 sCTTcQzF34YDGnuqC2mdnIRNmAZ7sxph+EFmGssK+ns18DMsRu6YH5U4AbdGaobcQZ
	 jyP0Ve7MB/el/EnfF5wkrRqy4+lBq9JHYTypB+g44+FiLfD41CJ1N5nmU5e9y1Zar3
	 hg2obqy/JCQjxlAyznOcS7JUMNQnu2eQZ+gR9nmK7If9nZx77dWGISrOK1qFlXy3Gh
	 TZIDkJmMS4mMA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPGTW23pHz3blB
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 15:08:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728533325;
	cv=none; b=b2gwHieK6yVXOMXbRq4QOmN1ae+irTfwdoGfZGiB1HoPChuXKhOhp62XgMQ62SMgyCqosyrSrGFruyHtSpuZcfrZyoXgpmKHXgKXv4Nypk34N/FLCvE8R4arC8CqQt6kxfRBFotmEBYU9l+2Zp49PEyNctkEPZMe9+r5flUEPlaOdA8TYYua0aKqhNsD+t4+zJYDnj+/Z1VduOTdhVby370aRJu6OKOesE/oOd8HNMzNFg+afT0VFkdOUIYEaDggZODk3lj9so1keNCRtk2sV7sC4WLFxkF3CkRizo1zjBRyhAR5gNULJKaRYFZWYLSSD3IFe9AS6eVIUGbW3tr5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728533325; c=relaxed/relaxed;
	bh=CEkGMWeXeG5EIKzooRFp1bexvUcTd1W76MvtznBRNC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HvSiqSen29jircyWh+MrF1o3ipr5p74W8oT+IMROMmiG+hHMD2jpVyOjDHcDYNfosr76eyh0RoSSA+O7+oebck6xhsUfzA2rXvSLtewiD+5M8MlnrgXBWOve4G8Xk2RBoP8c4PCw1x6mZuRFMzOtnI22HW5DXYU2jVjGF5m2S234jcVBYg/tWqyotsNZe6SvRb0mQgqSLgrMpsOiL32ZLZYoUJ63V3g9lKh+h21bnl2KM8YfXLg31vcjMER2/p8O7IY7Sovy6dQreutLDtY+abHwewChpPZF9zZTYquj4mdm7E6+AuBHUKM1STPUQNsmq6GClLoj2/1XBcc/tIujcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPGTS0pRxz3bjb
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 15:08:41 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPGRD6w7VzyT2T;
	Thu, 10 Oct 2024 12:06:48 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FEBC18009B;
	Thu, 10 Oct 2024 12:08:06 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 12:08:04 +0800
Message-ID: <90e546b6-ee8a-436f-890b-0e73cb0b1530@huawei.com>
Date: Thu, 10 Oct 2024 12:08:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <netfs@lists.linux.dev>,
	<dhowells@redhat.com>, <jlayton@kernel.org>, <brauner@kernel.org>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
 <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
 <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
In-Reply-To: <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/10/10 11:31, Gao Xiang 写道:
> Hi Zizhi,
> 
> On 2024/10/10 11:08, Zizhi Wo wrote:
>> Hi!
>>
>> This patchset involves some general cachefiles workflows and the on-
>> demand loading process. For example, the eighth patch fixes a memory
>> ordering issue in cachefiles, and the fifth patch includes some cleanup.
>> These all related to changes in the general cachefiles workflow, and I
>> think these deserve some attention.
>>
>> Additionally, although the current EROFS on-demand loading mode based on
>> cachefiles interaction might be considered for switching to the fanotify
>> mode in the future, I believe the code based on the current cachefiles
>> on-demand loading mode still requires maintenance. The first few patches
>> here are bugfixes specifically for that.
> 
> Yes, I also agree with you.  I pinged David weeks ago, because many
> bugfixes are not only impacted to cachefiles on-demand feature but
> also generic cachefiles, hopefully they could be addressed upstream.
> 

Thank you very much for your support and reply!

Thanks,
Zizhi Wo

> Thanks,
> Gao Xiang
>
>>
>> Therefore, I would greatly appreciate it if anyone could take some time
>> to review these patches. So friendly ping.
>>
>> Thanks,
>> Zizhi Wo
>>
>>
>> 在 2024/8/21 10:42, Zizhi Wo 写道:
>>> Hi!
>>>
>>> We recently discovered some bugs through self-discovery and testing in
>>> erofs ondemand loading mode, and this patchset is mainly used to fix
>>> them. These patches are relatively simple changes, and I would be 
>>> excited
>>> to discuss them together with everyone. Below is a brief introduction to
>>> each patch:
>>>
>>> Patch 1: Fix for wrong block_number calculated in ondemand write.
>>>
>>> Patch 2: Fix for wrong length return value in ondemand write.
>>>
>>> Patch 3: Fix missing position update in ondemand write, for scenarios
>>> involving read-ahead, invoking the write syscall.
>>>
>>> Patch 4: Previously, the last redundant data was cleared during the 
>>> umount
>>> phase. This patch remove unnecessary data in advance.
>>>
>>> Patch 5: Code clean up for cachefiles_commit_tmpfile().
>>>
>>> Patch 6: Modify error return value in cachefiles_daemon_secctx().
>>>
>>> Patch 7: Fix object->file Null-pointer-dereference problem.
>>>
>>> Patch 8: Fix for memory out of order in fscache_create_volume().
>>>
>>>
>>> Zizhi Wo (8):
>>>    cachefiles: Fix incorrect block calculations in
>>>      __cachefiles_prepare_write()
>>>    cachefiles: Fix incorrect length return value in
>>>      cachefiles_ondemand_fd_write_iter()
>>>    cachefiles: Fix missing pos updates in
>>>      cachefiles_ondemand_fd_write_iter()
>>>    cachefiles: Clear invalid cache data in advance
>>>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>>>    cachefiles: Modify inappropriate error return value in
>>>      cachefiles_daemon_secctx()
>>>    cachefiles: Fix NULL pointer dereference in object->file
>>>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
>>>
>>>   fs/cachefiles/daemon.c    |  2 +-
>>>   fs/cachefiles/interface.c |  3 +++
>>>   fs/cachefiles/io.c        | 10 +++++-----
>>>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>>>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>>>   fs/netfs/fscache_volume.c |  3 +--
>>>   6 files changed, 52 insertions(+), 27 deletions(-)
>>>
> 
