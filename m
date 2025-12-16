Return-Path: <linux-erofs+bounces-1502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB8CC1DB9
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 10:49:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVsZt3N9lz2xqj;
	Tue, 16 Dec 2025 20:49:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765878550;
	cv=none; b=WTqsdJOViKlfVFa7S8hcvFzLlHyqq9aYcbwOu7bebg+6dZSrYVry2uhroFgw7mKIm3OPzZhW3gZ6FVS6BlOHyruzKWTL5Yv2BmjxJfSBo2ApAAurjeGMRh26Fas7O7DKLGozSRBhkN+uiowspv5hgb1V0Pa67U/Xe+AgRxnWEukbXlTOTlLdokIoeaGdsKCEgo9J5+ho9ATkIEqU+Y43qFuQQxufZYjqmfkcrB4vi30h+tiR2+GR+65eblq5SY2MZmxSFLmrrkyg37bHWkvkNZcYvNf1k2T2zMejMOFZhUW9FLeK1qROpU3b6ekGyCnuYno1HKpv49UelOal9qyWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765878550; c=relaxed/relaxed;
	bh=Ue0bv693kzUKB+Ji6HXKanPFqofUh2t5sUVXOQcJDgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WP/5cWueAlv07Vh1bvE9eeqFAwa3Enqite5jDt1xDR0ZyU0SdUm4ECc2W9ryewblw79zgq5Kkg3qXy3LNrm/FHTudVGzVnEBt3rrVEkIowqnKCj+1PTS2iOB0cMpF2PssEr1Y/t59qmYRx9dDBYpHUpX5Jzr2gsMggXGyNs2FIGgbVeZiGy5uHAzhAShgKlSDQNa+1OfA1EJBBVm3fmwZwJrRGZ5kQhGzaDpP7Vtx5eRdf5IgJV36TRZ0dSKlc4RBriBad6pQELW7/zzBinkDpBYJAy9WY4DR8p7mm3PhKRFSbEANJLx1TRfDpHPswyaLxORhw2vF769rCb15uoTLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KZO0zLNQ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KZO0zLNQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVsZq1XZ1z2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 20:49:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ue0bv693kzUKB+Ji6HXKanPFqofUh2t5sUVXOQcJDgc=;
	b=KZO0zLNQZgLghuMWIAel+bUw7HixswbioB4UspGDiO1zb/pz1tjjRMrYBoWhMAa2antKFxlB+
	ASBDUSHq04f75jUy/v5k5fOXGV1PNhi3Iy0PqXbnKrhkKM9/V/yp/OSAQRqsjGEY3j3+EfCBdBo
	+gIOK2C6BF2H2pKwrpdXjYk=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dVsX72gtTz1T4GK;
	Tue, 16 Dec 2025 17:46:47 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 21B50180B50;
	Tue, 16 Dec 2025 17:48:58 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 16 Dec 2025 17:48:57 +0800
Message-ID: <7ae2b464-340e-43c7-9364-d3edde8e68ff@huawei.com>
Date: Tue, 16 Dec 2025 17:48:57 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: mount: gracefully exit when
 `erofsmount_nbd()` encounts an error
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <hudson@cyzhu.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
 <772b645f-6ca3-4447-8e6f-09e735440110@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <772b645f-6ca3-4447-8e6f-09e735440110@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/12/16 15:18, Gao Xiang wrote:
> Hi Yifan,
>
> On 2025/12/16 16:05, Yifan Zhao wrote:
>> If the main process of `erofsmount_nbd()` encounters an error after the
>> nbd device has been successfully set up, it fails to disconnect it
>> before exiting, resulting in the subprocess not being cleaned up and
>> blocked on `ioctl(nbdfd, NBD_DO_IT, 0)`.
>
> Do you have a simple test case (IOWs, how do you test this?)
> And is it possible to move the test case to erofs-utils tests?
>
How to reproduce the issue:


     mount.erofs -t erofs.nbd oci.layer=0 <some_non_erofs_image> /mnt/erofs


After the command fails, a leftover mount.erofs process (forked in 
erofsmount_nbd()) remains uncleaned.

In fact, I don't have a formal test case—I encountered this while trying 
out mount.erofs.
Since this is an end-to-end scenario rather than unit test, would you 
recommend adding a regression test for it (and other discovered 
mount.erofs issues) in our GitHub CI? (I'm happy to implement it.)
>>
>> This patch resolves the issue by invoking `erofs_nbd_disconnect()`
>> before exiting on error.
>
> See below.
>
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/liberofs_nbd.h | 2 +-
>>   mount/main.c       | 8 ++++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
>> index 260605a..93daa24 100644
>> --- a/lib/liberofs_nbd.h
>> +++ b/lib/liberofs_nbd.h
>> @@ -28,7 +28,7 @@ struct erofs_nbd_request {
>>           char   handle[8];    /* older spelling of cookie */
>>       };
>>       u64 from;
>> -        u32 len;
>> +    u32 len;
>>   } __packed;
>>     /* 30-day timeout for NBD recovery */
>> diff --git a/mount/main.c b/mount/main.c
>> index 758e8f8..a093167 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -1206,6 +1206,14 @@ static int erofsmount_nbd(struct 
>> erofs_nbd_source *source,
>>                   free(id);
>>           }
>>       }
>> +
>> +    if (err < 0) {
>> +        nbdfd = open(nbdpath, O_RDWR);
>
> I'm not sure if it's a best-practice (is it possible
> nbdpath can be reused?)
>
> Could we just kill the subprocess instead?
>
> Also ioctl is discouraged and netlink is preferred now.
>
I will try to give a graceful solution later.

Thanks,

Yifan Zhao

> Thanks,
> Gao Xiang
>
>> +        if (nbdfd > 0) {
>> +            erofs_nbd_disconnect(nbdfd);
>> +            close(nbdfd);
>> +        }
>> +    }
>>       return err;
>>   }
>

