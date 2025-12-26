Return-Path: <linux-erofs+bounces-1612-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601DCDE6F9
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 08:43:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcyKf1z5Jz2xg9;
	Fri, 26 Dec 2025 18:43:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766735030;
	cv=none; b=MG5nLPRYHanHsbICmcfDJf08dBsVVGKOmw0Q7FAFD4DCybPM9bOiKojwmMa/+QZ1j09MXaVWjKGa+0uFGWSxg5mhuQdXX9s1KuffxsVmTKbjFacBx97svA8sLcnFv9AmpXX/KNrLS0gOWjmb1NLVqeBFvw2KOgGvqfG3Li4rKVBLRZuCrvDGiIk6XcSYICSGZksWpoHOLA4XSWGJAWS49oSVTIEvi0SvoG0LwwRqB3Aony9w7Vqey6yywzAOO/SReo8vd5JiWGZw+b9c1UiGFyjUidHkGCS7Xsd08p5T7qgQ0dS8OwWY4+58m3oRDik33/W5p++2udeHuVmcX544eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766735030; c=relaxed/relaxed;
	bh=pmo7WlLfogyNUZjQ8fdw7qccw5GgeCXGCw4b44zsAG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FCoUrPaTGHc/QuPb2Nd3E5RM9XvqKl1eHDrz83JBm0uKUSfwmP+diqQT5iDibVsuffcW170i3cu2r1estVg0ONHeE2RqNXwTyJ6r6olif35FzQEpx/11SE3omK0SAvxfkCvbz7K4xZBnqQArFbLbuy4rdOgxb9zgy23jGAU+JfXmnRI0xZDAuZliSPEGfP3PWAdfZg4cMzLdQ8IB4+yxWFkkWvolkgoUJXenreIIhMft3mJc0x30QinAGgxkyxNMk3TKnP6M/k3tg1DMiOn0PHlgwDS5swoJ743KBKsJ6WvpqJfXJFlEqt8g96lmQIg2O5Z+8ktn9J4KrrnwS5At1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Jx7P/UOs; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Jx7P/UOs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcyKd1NKZz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 18:43:49 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pmo7WlLfogyNUZjQ8fdw7qccw5GgeCXGCw4b44zsAG8=;
	b=Jx7P/UOs1KGn81ATNxs/gj1RDLB/ecSneT3eFk7OYiDTSqYz7zLPzzSt1g5tz+Z0wVihT9Vti
	kIt9g8dI+LQODOkKnAb3EoMNVAUNs6KNtzGTlZurjNh28789Qc7sGhLNboznc3Oq94AP4PdCHFB
	26psrNhhhMuCEB0n3j0RpZo=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dcyFv0m9XzmVXB;
	Fri, 26 Dec 2025 15:40:35 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id D259640538;
	Fri, 26 Dec 2025 15:43:43 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 26 Dec 2025 15:43:43 +0800
Message-ID: <ab5d631a-ec99-4c1b-a071-e1b5168880d9@huawei.com>
Date: Fri, 26 Dec 2025 15:43:42 +0800
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
Subject: Re: [PATCH 4/5] erofs-utils: mount: gracefully exit when
 `erofsmount_nbd()` encounts an error
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-3-zhaoyifan28@huawei.com>
 <6571a348-0e96-4c79-91fc-278dbfb2a54a@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <6571a348-0e96-4c79-91fc-278dbfb2a54a@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/12/26 14:49, Gao Xiang wrote:
>
>
> On 2025/12/23 18:04, Yifan Zhao wrote:
>> If the main process of `erofsmount_nbd()` encounters an error after the
>> nbd device has been successfully set up, it fails to disconnect it
>> before exiting, resulting in the subprocess not being cleaned up and
>> keeping its connection with NBD device.
>>
>> This patch resolves the issue by disconnecting NBD device before exiting
>> on error.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> Note:
>> - I believe directly killing the child process is unsafe, as it may 
>> leave
>> in-flight NBD requests from the kernel unhandled, causing soft lockup.
>> - And I believe using nbdpath here is safe, as the child process 
>> maintains
>> the NBD device connection throughout, preventing concurrent access by 
>> other
>> actors.
>
> What if the child process is already exited earlier, and the current NBD
> device is reused for others?
>
> How about keeping the previous nbdfd for ioctl interfaces instead to
> avoid nbd device reuse.
>
OK, I will try this way.


Thanks,

Yifan

> Thanks,
> Gao Xiang
>
>>
>>   mount/main.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/mount/main.c b/mount/main.c
>> index 2a21979..d2d4815 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -1287,10 +1287,23 @@ static int erofsmount_nbd(struct 
>> erofs_nbd_source *source,
>>         if (!err) {
>>           err = mount(nbdpath, mountpoint, fstype, flags, options);
>> -        if (err < 0)
>> +        if (err < 0) {
>>               err = -errno;
>> +            if (msg.is_netlink) {
>> +                erofs_nbd_nl_disconnect(msg.nbdnum);
>> +            } else {
>> +                int nbdfd;
>> +
>> +                nbdfd = open(nbdpath, O_RDWR);
>> +                if (nbdfd > 0) {
>> +                    erofs_nbd_disconnect(nbdfd);
>> +                    close(nbdfd);
>> +                }
>> +            }
>> +            return err;
>> +        }
>>   -        if (!err && msg.is_netlink) {
>> +        if (msg.is_netlink) {
>>               id = erofs_nbd_get_identifier(msg.nbdnum);
>>                 err = IS_ERR(id) ? PTR_ERR(id) :
>

