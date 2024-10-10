Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FA9985BA
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 14:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728562663;
	bh=Vxj3T4hPWP1O+wPekd5tp82OSeQWv1HhzJnrCuT9zlw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Kc3w/NyN2gvdA9lxnN9nH3ekwlUCVlXULM6K/9fJLKoYtwYI0SgwijrFaUUiA4koi
	 Dk1E/yyqob9Kq0pJaV7dFV+8zoHROJDvknBYP0/rQRPbtZwr2BD4fSq+P/daM/ee01
	 UHQwbt9B5qR2c0uYd59/EzYRTSUGadXlByv7wVTS+ciC2heoX33D978buDV4fT+hiI
	 d66DrUINu04itE5PZF28yKaNPNi6oStfO+OTe/4PKwhtSFG0HfCH929q4C7Rj93dOm
	 PuI4qI6dmEI9RpEYr2+KyY8D394Sj77x7tLg/Unyqm2G6BWGA1FnIwT/Pe8KkLfvnZ
	 BiKdzcc31uYZg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPTKg0zyyz3bjq
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 23:17:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728562661;
	cv=none; b=UyF5pid9GisEG/u+BVUz6gZK1y+/GoRPQ8PED2aOpMYqeCmJ9QAn6OCHTVAKHlQa0xKc/w5XQKrM9Y5sIfZu0sE678L8HRdH2Gr3SbRnxkpcByDai5cUMIq8VphoscqU9oM4uH2EJSC52tzqljFrznwC9++17UHX6KLTzwh0bO/RizFDQBJxoOWLoz6jx4UETCPAdw8JJCDnoA4VD0p5hWY407OwByzAYGCqQ32hq98i/7My/zPvRw25aDTbnEGNmkV0HfV4E382vEg8fNOT1FCGj7KR00VTf5Ze6sHljaHWtl3mcIg/F6LqYzyhsv0jzXKR5rjHKeU9Ft2JVQzozg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728562661; c=relaxed/relaxed;
	bh=Vxj3T4hPWP1O+wPekd5tp82OSeQWv1HhzJnrCuT9zlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M0LC5BMqRvehZ/g7xhp82PVodYJQ7Et77X4jQZ8nCAGGj2hFhrGTfwUeSz64aOyd3Xv/+PS44kUaER6Hi0zm9SzzqQ9D/+46ds2WXMijHy9Yv30aDD66iTNBRxUfod5blv7vlJlWx0spyo3IyJffNdZ2BT4Xrn+0n9C5FVoqXsyojQfuhYXOd/RZnbSzq3Z5SMCZfkvagVMQ2Qx0vfsZDeR9Ee/R7vTUnfJDdP5USkbIhortpFLGy87kGRmhdmW2eMVz6n/HQP7ZngNqJrdHHrL+vBD6lOY8Hf9F6jL8+Ogi0EUVmCUiWDYeFttxyCHj5S/maLd6ZhoM4kvrE3FcWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPTKb4V2vz2yx7
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 23:17:37 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPTH452PPzpWjL;
	Thu, 10 Oct 2024 20:15:28 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4619C18007C;
	Thu, 10 Oct 2024 20:17:28 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 20:17:27 +0800
Message-ID: <32717f03-634a-4f39-9f46-e73cca8da46d@huawei.com>
Date: Thu, 10 Oct 2024 20:17:26 +0800
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
> 

Then I was wrong. Thank you for pointing it out. I'll be thinking about
new solutions for non-PAGE_SIZE scenarios.

Thanks,
Zizhi Wo
