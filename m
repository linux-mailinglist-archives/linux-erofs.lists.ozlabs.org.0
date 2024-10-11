Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1B999964
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 03:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728610329;
	bh=ltQBBpUF7WhuJ3LNkex78Qv44GaGdzkiQ0kp77neJTA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SNij4uFPHEkkYVlGfIhrCnIZwdLLSvhpkKmKnpe/W9FWfFAYghdhrEOBOvA5gSsip
	 hLlhoCatwvwznvWXUQPgUEQEN8k9YUox6HcJLEdiMgHicQ9hznXh4sCmX+2N3Xqjhw
	 N9lkr6SW2LypUUCuu9HV3pbp5WPrxX4xu7d2YLWzHtLSn6DlNHZo8RdsGfyxvzhyD6
	 tUkReleN9t2a1Rl1kZFZW+zigNWOnOCjD1broO1oLMCzEU4LzJ/dSF6aa0NyY6lAXW
	 +v98risAxIBubKhywl7x1lOe7Iqkplej5EMmhQM2J5h1Dkm6WBNdr4w40FRDKMAEzP
	 zEV/5rKhZ2uIQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPpyK5JcZz3bvf
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 12:32:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728610327;
	cv=none; b=RHLcd/CkvavxcAAdxQmzAj+nlHeYkdc+CPs34MYGDGGhg5tkl0W8uEOJqnXB9FKEj/fcYxrx5encRy4aMsd/qwvtUWgL6XBOnF2zlF3UTBNDZH9w0N44/8UJaVn9vUCcbceNGR6I6DzPJMSe4xF8Tqx0URda21DstSCrjmHz/AVwh/BeHEPwyf/GmX2q1ZD9fxJJ2zH9Ks4tCEAZh5irhU6bRC9hBzHDnKcwKG+NhVeVlZzH0bgOQ0JXZors7PZZocyDOJlIcwatT9XR7ySYKAQabuiblAYBYT+1FYdP3s1Gn3fRQsO4tRakbWxtI7vFRFkO22mLei8PpS5TP9v4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728610327; c=relaxed/relaxed;
	bh=ltQBBpUF7WhuJ3LNkex78Qv44GaGdzkiQ0kp77neJTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OVRV4SupRyL3iHx5Lf1qBU37hhi8KdQ1DTWPYYSRK1PQvcYcfjPQbQs8tunw8x4wnIk72UTnPiQ4S/xI0yzdPtoetvgY0cBpWKjWdNF5/B1NnwKLSkgGczHelWmteoWwVdAVGFCNKn3ubZVZbyHP3NvGml65zSbkyyC+Lh3f8+InHvihWQHcFNDUJPUSRLFREZ7tKuusWF5Rbmzp1IG96SjaqN/JFkfVJnnUpw53xLbs95RJNDdFwU6QFeh78NysBpub/Z6JtJH+EQtx0yfTghfvyy84Lo38Sy+l7yOCSB5CS1PF92w5P+TFiU3wRwx2pWHDtnrcnE0EE1PZsjooEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPpyF4QFcz3028
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 12:32:02 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPpy82zS0z2VRTp;
	Fri, 11 Oct 2024 09:32:00 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C2C8140202;
	Fri, 11 Oct 2024 09:31:55 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Oct 2024 09:31:54 +0800
Message-ID: <94004b36-01ae-4c62-ad74-0bad5992eb7c@huawei.com>
Date: Fri, 11 Oct 2024 09:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in
 object->file
To: David Howells <dhowells@redhat.com>
References: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
 <20240821024301.1058918-8-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <303977.1728559565@warthog.procyon.org.uk>
 <443969.1728571940@warthog.procyon.org.uk>
In-Reply-To: <443969.1728571940@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/10/10 22:52, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> 在 2024/10/10 19:26, David Howells 写道:
>>> Zizhi Wo <wozizhi@huawei.com> wrote:
>>>
>>>> +	spin_lock(&object->lock);
>>>>    	if (object->file) {
>>>>    		fput(object->file);
>>>>    		object->file = NULL;
>>>>    	}
>>>> +	spin_unlock(&object->lock);
>>> I would suggest stashing the file pointer in a local var and then doing the
>>> fput() outside of the locks.
>>> David
>>>
>>
>> If fput() is executed outside the lock, I am currently unsure how to
>> guarantee that file in __cachefiles_write() does not trigger null
>> pointer dereference...
> 
> I'm not sure why there's a problem here.  I was thinking along the lines of:
> 
> 	struct file *tmp;
> 	spin_lock(&object->lock);
>   	tmp = object->file)
> 	object->file = NULL;
> 	spin_unlock(&object->lock);
> 	if (tmp)
> 		fput(tmp);
> 
> Note that fput() may defer the actual work if the counter hits zero, so the
> cleanup may not happen inside the lock; further, the cleanup done by __fput()
> may sleep.
> 
> David
> 
> 
Oh, I see what you mean. I will sort it out and issue the second patch
as soon as possible.

Thanks,
Zizhi Wo
