Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372E998758
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 15:16:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728566170;
	bh=ZDpCxe9XXn9Wu9c7f0uGeFkXZP/11wieQJe4k7EB36Y=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hkLCWr4M9s9tbKcyGtZdaF8X1g0A2UCw5tq8lwloH+nQZPbIWld2iTaBdG6hJcJSj
	 0BiGPu70I6zxcKrhxevHw5/PNymsCjLo8gp4gGu5p8buwjUHawX0O16Axgb/pjk5Zq
	 SgY9XSBrgcrQU3Ul4IfGU7orj0NexrcvxGwIdYXf51RIUoc2Y6ows17tIL4tRD9MIA
	 gYlHNvi0M6AMDGUfza94AShh6PIxhjhawexIEx+bfAAIp5ObZuistGS1e75KDVA+bO
	 8hpyJuCuIGsFnZPzfxQuV8h/2TDF3DAbufiew0oQbmPxhKVsUaG3ePNGiVU7UW1ErB
	 Zqqeqv9+xLbPg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPVd6040Gz3bkL
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 00:16:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728566166;
	cv=none; b=QTt2LLlEYKvSGju7/friFgelKmvGmWqY6/K1N4eteq2Koxfq470eEcGa9NWi+Z3Ax1UZgIASgH0v0JOUUb4/+bbiLyzbCT5Kj5wpP19c1HpCB4anQY6WtWBA4Q8Os+F2ad46socvUvDtViIn78wPUVnKGDDGsljj/VLyBJEpfFS7BICQZzUJkh0xKxColavGzvXdO74wVg8n/7ZaZIkvO1+PazQqG/TOt2eNpgOTnEbqUMsR37NWR/nhy3yRp9AXe2tfh0Lw5827dmhn6BoNfrNNVysd2XHg/rfe7om7P7ovpyunqWfTnCwF1EjrW0YTUO97VCmYVJWIYcYb2jDuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728566166; c=relaxed/relaxed;
	bh=ZDpCxe9XXn9Wu9c7f0uGeFkXZP/11wieQJe4k7EB36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jzbys+e19CSiuYkSwuJQrnAakN/jz4Nzya41B/jPuK0dLbl+AZ8y+orFm/8d6N9rOQhwqUZT55FmGhosC/s5BKTdy8MPc7jSmZdGdAJvJzzv2vId7MN2399jRWo/dzB95AkmjWCh1fEqPoVfW/0e8V+2amHu5f3JNxD2kaCnM1uKjocbq3Lz+tJztwPwhJV9+/iHV1HxqB5+iagRt1G2vC+ks1IQQWpA+rhihHf6ir0ACeNw8lPtAngXuvgx9Ah+AYDEasu6l3AJwObuIeExDZo+OVPVnx2fKOwx3zlWIEyKmb12Jxb78vQcVHeDV+SDX37grIB2i0tVK+wVwqqRYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPVcx4qJ1z2yNc
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 00:15:58 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPVcr1KgGz2KXwr;
	Thu, 10 Oct 2024 21:15:56 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA30180041;
	Thu, 10 Oct 2024 21:15:51 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 21:15:50 +0800
Message-ID: <14905d87-9fc4-45c8-b845-d3f4badecf46@huawei.com>
Date: Thu, 10 Oct 2024 21:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in
 __cachefiles_prepare_write()
To: David Howells <dhowells@redhat.com>
References: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
 <20240821024301.1058918-2-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <302546.1728556499@warthog.procyon.org.uk>
 <304311.1728560215@warthog.procyon.org.uk>
In-Reply-To: <304311.1728560215@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



在 2024/10/10 19:36, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> For scenarios such as nfs/cifs, the corresponding bsize is PAGE_SIZE aligned
> 
> cache->bsize is a property of the cache device, not the network filesystems
> that might be making use of it (and it might be shared between multiple
> volumes from multiple network filesystems, all of which could, in theory, have
> different 'block sizes', inasmuch as network filesystems have block sizes).
> 
> David
> 

Sorry, I might have a slightly different idea now. The EROFS process
based on fscache is similar to NFS and others, supporting only
PAGE_SIZE-granularity reads/writes, which is fine. The issue now lies in
the __cachefiles_prepare_write() function, specifically in the block
count calculation when calling cachefiles_has_space(). By default, the
block size used there is PAGE_SIZE.

If the block size of the underlying cache filesystem is not PAGE_SIZE
(for example, smaller than PAGE_SIZE), it leads to an incorrect
calculation of the required block count, which makes the system think
there is enough space when there might not be. This should be the same
problem for all network file systems that specify the back-end cache
file system mode.

For example, assume len=12k, pagesize=4k, and the underlying cache
filesystem block size is 1k. The currently available blocks are 4, with
4k of space remaining. However, cachefiles_has_space() calculates the
block count as 12k/4k=3, and since 4 > 3, it incorrectly returns that
there is enough space.

Therefore, I believe this could be a general issue. If
cachefiles_add_cache() is part of a common workflow, then using
cache->bsize here might be more appropriate? Looking forward to your
reply.

Thanks,
Zizhi Wo

> 
