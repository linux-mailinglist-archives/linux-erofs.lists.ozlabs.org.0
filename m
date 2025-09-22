Return-Path: <linux-erofs+bounces-1055-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E4CB8EDC0
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 05:25:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVT5Q44zkz301K;
	Mon, 22 Sep 2025 13:25:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758511530;
	cv=none; b=Gnq2s711VdMB9+Z8lpmR2JRnysnbrPTQd9lHJgW14muv26kcIE1y59fxnJ79enrzGt/vPUkdGppQXFIXW9WTV6XY6BM7GE7tVrseerHVZHsOroTm5GCaDTDrQQ0heuF5Kp6Lwz9JG7ZgAsJ987OcElbDwbVJ+JCzFdUtvClamqs4TfiTYsJJ7Lv/gXD3goQ3Jo3vzc/1jzfV/nQSWLow0HMr1ygV4S7hEhtBEiQ6FlGQSyxYn9ioSboo3v2Qt8uCSZHpIcR8jsXjz525NbjeSpxNVFL3I9Nq8RiuJzWL9q9vGVKx27nI439WFX08ewlU3i/5wXL3T8dIOSXkBOU8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758511530; c=relaxed/relaxed;
	bh=qdvDv2aL3KHonnGwcng54YWUu4Z8jlN+iakmLw2FWr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHKwfT9sikc25hxHDk6Q3db4dqvcZQZO3Fgnb6rM0p+xWLWCdh+2ma1zosvGUBE7osvpxHdAlgGK1Pxo5jrtdhSi6AEf3zgyuMKLv9GHmqCqGFwXHSn3ljH4O1gwgCWziV332+iKVbLFTqxjK51rY03hKKl5PJDiIhoNDEy3xd0Q8xe1Qmy7YAGUZZ9Q6hUivkV5Rh08jm9kl6chVW0kZTzSRbonxAT4fl4l3jgPd3z8gk6ViRMbKevYl29sKSAib5yqhSHIFkImCSCR1edYEMCyqtYIrMTcy33icsa2oqwQhhems+bsHLCFlGMQYZ62boECJ4zocoBX+2Nmpb8lFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVT5P3H9Zz2xdg
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Sep 2025 13:25:27 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cVT4w0yKPz14M3l;
	Mon, 22 Sep 2025 11:25:04 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id A9DCA140123;
	Mon, 22 Sep 2025 11:25:22 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 11:25:22 +0800
Message-ID: <db880a09-414c-4679-8922-3c1d8a884ea6@huawei.com>
Date: Mon, 22 Sep 2025 11:25:21 +0800
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
Subject: Re: [PATCH 2/3] erofs-utils: lib: avoid using lseek in diskbuf
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <lihongbo22@huawei.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20250918151245.58786-1-zhaoyifan28@huawei.com>
 <20250918151245.58786-3-zhaoyifan28@huawei.com>
 <53801295-8085-4237-85f7-c97181ed1954@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <53801295-8085-4237-85f7-c97181ed1954@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

thanks, will take a look


Yifan Zhao

On 2025/9/22 10:37, Gao Xiang wrote:
>
>
> On 2025/9/18 23:12, Yifan Zhao wrote:
>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>
>> The current `diskbuf` implementation uses `lseek` to operate file 
>> offset,
>> preventing multiple streams from writing to the same file. Let's replace
>> `write` + `lseek` with `pwrite` to enable this use pattern.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>
> It seems this patch breaks CI,
> https://github.com/erofs/erofsnightly/actions/runs/17902749255/job/50898433325 
>
>
> 2025-09-22T02:28:33.7178065Z Processing 
> linux-5.4.256/virt/kvm/arm/vgic/vgic-v3.c ...
> 2025-09-22T02:28:33.7178615Z Processing 
> linux-5.4.256/virt/kvm/arm/vgic/vgic-v4.c ...
> 2025-09-22T02:28:33.7179125Z Processing 
> linux-5.4.256/virt/kvm/arm/vgic/vgic.c ...
> 2025-09-22T02:28:33.7179623Z Processing 
> linux-5.4.256/virt/kvm/arm/vgic/vgic.h ...
> 2025-09-22T02:28:33.7180092Z Processing linux-5.4.256/virt/lib/Kconfig 
> ...
> 2025-09-22T02:28:33.7180516Z Processing 
> linux-5.4.256/virt/lib/Makefile ...
> 2025-09-22T02:28:33.7180965Z Processing 
> linux-5.4.256/virt/lib/irqbypass.c ...
> 2025-09-22T02:28:33.7181377Z Build completed.
> 2025-09-22T02:28:33.7181556Z
> 2025-09-22T02:28:33.7181658Z ------
> 2025-09-22T02:28:33.7181969Z Filesystem UUID: 
> 83e743e1-72ca-40cb-bc27-7621af1f88fc
> 2025-09-22T02:28:33.7182448Z Filesystem total blocks: 239166 (of 
> 4096-byte blocks)
> 2025-09-22T02:28:33.7182882Z Filesystem total inodes: 70074
> 2025-09-22T02:28:33.7183231Z Filesystem total metadata blocks: 2060
> 2025-09-22T02:28:33.7183705Z Filesystem total deduplicated bytes (of 
> source files): 1021788
> 2025-09-22T02:28:33.8980774Z erofsfuse 1.8.10-g475e9afd
> 2025-09-22T02:28:33.8981380Z <W> erofs: main() Line[755] 
> lowerdir.erofs.img mounted on lowerdir with offset 0
> 2025-09-22T02:28:34.0928040Z Makefile:1: *** missing separator. Stop.
>
> ...
>
> Thanks,
> Gao Xiang

