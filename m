Return-Path: <linux-erofs+bounces-1528-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE3CD4E2F
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:44:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVXV6dglz2xpt;
	Mon, 22 Dec 2025 18:44:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389482;
	cv=none; b=aEGWURmIlS9T8dXWS8gWMqXves/+7DMUbHDRWVpBle8gX/MCyL8l244gVoFb/njxTwmvDkTAT5WzYNm3ZnNLYDyi3+STqantVLvXQhFjB2BZtDX1j9EXxqTYJW3wBa1Se6xG35JvuxdKbqbdH+ITBRGANn+TPJYWj1ryru/UqTzjpdk1+tIxFcNSztn3Hn6kyqOUOhks3Tr1LH7ESqS4w65UgSuebsFHBWd94Y9/7a5QaGvqXcL8SaXm//8i9Q+cs0YUDFeFJ6OVN7QFhoyCZLkX4RWw6b+BLAb52JW2vycqFgL4Y6y8zgqVAVnNQgoKvlF7VroXd8PpmIoc+p5BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389482; c=relaxed/relaxed;
	bh=WGUv0YCElk5m6FcVpcUl92tpNiFmFkIQh6aEJvXkAh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aWNjZgXEBR+i2jAhFe02VpkwDsp5cF5DO/vg1EQLAxPZtJZzoLw9YPNINlINZHFREw3sJyIpOVOQigTXWIf9F8HZ0zUiIhD5eXAm/L8Mxz0oT1UNTK+hFb5WsthP44GX6VPrAkkTRZPK1araUBDCBXSIJzGmauLVAAlztc3VuK0ATedfk6e5RO6vcR5LIt/+C0nsu2I0SM9/4TUo8dgG2IylHQ6tcimpgVxxvdQCbn92KvM73Xhey66Nryk7Aom0UfDB06wyyEZZTzrPdXK6zVQ/dsKb8Wp0ce7lfw4XoKHbFMKjt8JXvSDuNsB/7qTr6pipOP8l0GMgM5Wavco1qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d5QIxI5g; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d5QIxI5g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVXV1g7dz2xFn
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:44:42 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WGUv0YCElk5m6FcVpcUl92tpNiFmFkIQh6aEJvXkAh8=;
	b=d5QIxI5g49HFLEi0R9B6qF2Wpu0pWz/IPyQFLTzpgWxcms+JwWy0cShr+KiBgt7VvjMe4AC+o
	jESlAEHYoxxWTQTcASiPAj/Mz80S0vuVmDd03uCMkztaXsvkQtUTLyTrrjYvcpIkEBB0nV4ykuz
	rLMnIX+UoGklNXjyAWOXGFM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dZVSp6ZBhzRhRM;
	Mon, 22 Dec 2025 15:41:30 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id EE57940569;
	Mon, 22 Dec 2025 15:44:36 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Dec 2025 15:44:36 +0800
Message-ID: <4e3cd17e-2df6-4875-9cfb-e8a800c29695@huawei.com>
Date: Mon, 22 Dec 2025 15:44:35 +0800
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
Subject: Re: [PATCH v4] erofs-utils: mount: add manpage and usage information
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <hudson@cyzhu.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251130033516.86065-1-hudson@cyzhu.com>
 <20251222071635.169262-1-zhaoyifan28@huawei.com>
 <dd53ed4a-1baf-4774-bc02-9e857bce8e7b@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <dd53ed4a-1baf-4774-bc02-9e857bce8e7b@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

OK, I will just submit a new patch.


Thanks,

Yifan Zhao


On 2025/12/22 15:36, Gao Xiang wrote:
> Hi Yifan,
>
> On 2025/12/22 15:16, Yifan Zhao wrote:
>> From: Chengyu Zhu <hudsonzhu@tencent.com>
>>
>> Add manpage, command-line usage help, and README for
>> mount.erofs tool.
>>
>> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
>> Link: https://lore.kernel.org/r/20251202110315.14656-1-hudson@cyzhu.com
>> [ Gao Xiang: change the section number of the manpage to 8. ]
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi Xiang,> Note that you have merged this patch. Could you consider 
>> merging this
>> patch instead for the experimental branch? The only difference is that
>> it also covers the newly added `oci.insecure` documents, see below.
>>
>> Thanks,
>> Yifan Zhao
>
> Can you just posting an incremental patch for this? since I
> have two new patches relying on this too.
>
> Thanks,
> Gao Xiang

