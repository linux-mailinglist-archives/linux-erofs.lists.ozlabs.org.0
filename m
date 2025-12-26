Return-Path: <linux-erofs+bounces-1614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F6CDE76A
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 08:54:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcyZR1nznz2yFQ;
	Fri, 26 Dec 2025 18:54:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766735695;
	cv=none; b=lDYdXZxcvTJTISoGVk472X+ExdNf4Oc5Uz3AdqHhjpzMOAqyzWtgJ+48h5Dq4xn8FVNW64PyJWLSTT/WeVYIWnT11rOtQjZ0A3l1RFTQHlcZpCp7S3t7Dpqy5uCVJSf4UHcjPwyMK4TVs86xDF0aN9SP2KLYnoWhK5jQPvn7aYuZO7dj8Dt6tXMWsrD1DjU1f+Oe9SWELO3mNvEFcQX00SCNJ0pEadX10O+TyyQ7kEzh5XrgU75UU3mSXlwmk5lAqNf2p7CbepUh1CbcNN41mqmNwOq8CSImYQsvhLrCQguSZzpDOvzhKmVOS1bZw5vJVrH84Ef8kCHZhodtiHlDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766735695; c=relaxed/relaxed;
	bh=lDkkUp7mGO4pNa0uamBBvac1uq7Dml7wCrsXtOCSNl8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=A1/PeWyZwXOgAhooN7az5ddJ7Em+Dzp9PtmKZxo+zY3JQXgIws5QfWD1ilKPW2hxlUQ1mk5Id9iexZ9K0y5YjsvL3kY6Qwgvl70FN2dIJn4IOLrxLOLWUDdlLPy7TWIkI8WNZHC8UFK850ZpIHSarkH/40s7rogf9Ny92aMdjLd8P6MNWWhvNi75ylMIAmQRCQsjmf8RZYOYvH0ykxSo8cxYIhbZ6b7fI010a/Qf8iwQVztetUA0HeB3v62iZCf66qBofIuNRgj87lzBPYNBsSZwKbG8t+6pyQso4HYUBFD1qlkeZXGKn2qxKmxaEVIK9037f5nPM3lCQJXhXWkd8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Zh+MrGhG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Zh+MrGhG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcyZN4vDxz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 18:54:51 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lDkkUp7mGO4pNa0uamBBvac1uq7Dml7wCrsXtOCSNl8=;
	b=Zh+MrGhGI6Q338VGihTzM1wCtHSgheMFc0io2/07APZhbmOAJpw2sfGhRR7Sml/zCnAPCsYH6
	F0AFLimCdBWC2AQWq104MwaI0VLt4ni7mVJ4UaYEGBpf3fM5nSJ+SqYsK53uLoulVbUXCWkT+4C
	hJIYCzhJ/hT7EmYIigNNlhU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dcyVd2s4XzLlXm;
	Fri, 26 Dec 2025 15:51:37 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id D1B2F40563;
	Fri, 26 Dec 2025 15:54:44 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 26 Dec 2025 15:54:44 +0800
Content-Type: multipart/alternative;
	boundary="------------B0i5MkXSrRBdO60HXfjNolTR"
Message-ID: <7c5a6710-5ebf-42f8-b35f-b5f2ae120a2d@huawei.com>
Date: Fri, 26 Dec 2025 15:54:43 +0800
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
Subject: Re: [PATCH 5/5] erofs-utils: mount: stop checking
 `/sys/block/nbdX/pid`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-4-zhaoyifan28@huawei.com>
 <ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------B0i5MkXSrRBdO60HXfjNolTR
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/12/26 14:51, Gao Xiang wrote:
> Hi Yifan,
>
> On 2025/12/23 18:04, Yifan Zhao wrote:
>> The `current erofsmount_nbd()` implementation verifies that the value in
>> `/sys/block/nbdX/pid`` matches the PID of the process executing
>> `erofsmount_nbd_loopfn()`, using this as an indicator that the NBD
>> device is ready. This check is incorrect, as the PID recorded in the
>> aforementioned sysfs file may belong to a kernel thread rather than a
>> userspace process (see [1]).
>
> Do you have a way to reproduce that?

This issue is consistently reproducible in my WSL2 environment (kernel 
version 6.6.87.2-microsoft-standard-WSL2),

but works correctly in other environments (e.g., openEuler 24.03 SP2). 
The finer-grained difference

between these 2 environments remains unclear.

>
>>
>> Moreover, since this verification only occurs after the child process
>> has successfully issued and returned from the NBD connect request,
>> removing it introduces no risk of NBD device hijacking by malicious
>> actors. This patch removes the erroneous check.
>
> It's not used to avoid device hijacking by malicious actors but
> detecting if the NBD device is reused by another daemon.
>
ok. I believe under the ioctl interface, there is indeed no reliable way 
to determine exactly whether the current daemon

is the one holding the NBD device open (unlike with netlink, where 
|/sys/block/nbdX/backend|can be used for such verification).

This is indeed a genuine limitation.

Thanks,

Yifan

> Thanks,
> Gao Xiang
>
>>
>> [1] 
>> https://elixir.bootlin.com/linux/latest/source/drivers/block/nbd.c#L1501
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/backends/nbd.c | 16 +++++-----------
>>   lib/liberofs_nbd.h |  2 +-
>>   mount/main.c       |  5 ++---
>>   3 files changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
>> index 46e75cd..2d941a9 100644
>> --- a/lib/backends/nbd.c
>> +++ b/lib/backends/nbd.c
>> @@ -52,7 +52,8 @@ struct nbd_reply {
>>       };
>>   } __packed;
>>   -long erofs_nbd_in_service(int nbdnum)
>> +/* Return: 0 while nbd is in service, <0 otherwise */
>> +int erofs_nbd_in_service(int nbdnum)
>>   {
>>       int fd, err;
>>       char s[32];
>> @@ -72,17 +73,10 @@ long erofs_nbd_in_service(int nbdnum)
>>           return -ENOTCONN;
>>         (void)snprintf(s, sizeof(s), "/sys/block/nbd%d/pid", nbdnum);
>> -    fd = open(s, O_RDONLY);
>> -    if (fd < 0)
>> +    if (access(s, F_OK) < 0)
>>           return -errno;
>> -    err = read(fd, s, sizeof(s));
>> -    if (err < 0) {
>> -        err = -errno;
>> -        close(fd);
>> -        return err;
>> -    }
>> -    close(fd);
>> -    return strtol(s, NULL, 10);
>> +
>> +    return 0;
>>   }
>>     int erofs_nbd_devscan(void)
>> diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
>> index 78c8af5..b719d80 100644
>> --- a/lib/liberofs_nbd.h
>> +++ b/lib/liberofs_nbd.h
>> @@ -34,7 +34,7 @@ struct erofs_nbd_request {
>>   /* 30-day timeout for NBD recovery */
>>   #define EROFS_NBD_DEAD_CONN_TIMEOUT    (3600 * 24 * 30)
>>   -long erofs_nbd_in_service(int nbdnum);
>> +int erofs_nbd_in_service(int nbdnum);
>>   int erofs_nbd_devscan(void);
>>   int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
>>   char *erofs_nbd_get_identifier(int nbdnum);
>> diff --git a/mount/main.c b/mount/main.c
>> index d2d4815..f6cba33 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -1270,6 +1270,8 @@ static int erofsmount_nbd(struct 
>> erofs_nbd_source *source,
>>         while (1) {
>>           err = erofs_nbd_in_service(msg.nbdnum);
>> +        if (!err)
>> +            break;
>>           if (err == -ENOENT || err == -ENOTCONN) {
>>               err = waitpid(child, &child_status, WNOHANG);
>>               if (err < 0)
>> @@ -1280,9 +1282,6 @@ static int erofsmount_nbd(struct 
>> erofs_nbd_source *source,
>>               usleep(50000);
>>               continue;
>>           }
>> -        if (err >= 0)
>> -            err = (err != child ? -EBUSY : 0);
>> -        break;
>>       }
>>         if (!err) {
>
--------------B0i5MkXSrRBdO60HXfjNolTR
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/12/26 14:51, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com">Hi
      Yifan,
      <br>
      <br>
      On 2025/12/23 18:04, Yifan Zhao wrote:
      <br>
      <blockquote type="cite">The `current erofsmount_nbd()`
        implementation verifies that the value in
        <br>
        `/sys/block/nbdX/pid`` matches the PID of the process executing
        <br>
        `erofsmount_nbd_loopfn()`, using this as an indicator that the
        NBD
        <br>
        device is ready. This check is incorrect, as the PID recorded in
        the
        <br>
        aforementioned sysfs file may belong to a kernel thread rather
        than a
        <br>
        userspace process (see [1]).
        <br>
      </blockquote>
      <br>
      Do you have a way to reproduce that? <br>
    </blockquote>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">This issue is consistently reproducible in my WSL2 environment (kernel version 6.6.87.2-microsoft-standard-WSL2),</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">but works correctly in other environments (e.g., openEuler 24.03 SP2). The finer-grained difference</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">between these 2 environments remains unclear.</span></p>
    <blockquote type="cite"
      cite="mid:ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com"><br>
      <blockquote type="cite">
        <br>
        Moreover, since this verification only occurs after the child
        process
        <br>
        has successfully issued and returned from the NBD connect
        request,
        <br>
        removing it introduces no risk of NBD device hijacking by
        malicious
        <br>
        actors. This patch removes the erroneous check.
        <br>
      </blockquote>
      <br>
      It's not used to avoid device hijacking by malicious actors but
      <br>
      detecting if the NBD device is reused by another daemon. <br>
      <br>
    </blockquote>
    <p>ok. <span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">I believe under the ioctl interface, there is indeed no reliable way to determine exactly </span><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">whether the current daemon</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">is the one holding the NBD device open (unlike with netlink, where </span><code
      class="qwen-markdown-codespan"
style="margin: 0px; padding: 0px 0.25rem; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); display: inline-block; font-size: 0.875rem; line-height: 1.375rem; letter-spacing: -0.04em; color: rgb(97, 92, 237); border-radius: 0.25rem; background: none 0% 0% / auto repeat scroll padding-box border-box rgb(239, 238, 255); word-break: break-word; font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace !important; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; cursor: pointer;">/sys/block/nbdX/backend</code><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"> can be used for such verification).</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">This is indeed a genuine limitation.</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Thanks,</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Yifan</span></p>
    <blockquote type="cite"
      cite="mid:ba3929d3-b8f3-4027-bfa1-5ade5ec348f2@linux.alibaba.com">Thanks,
      <br>
      Gao Xiang
      <br>
      <br>
      <blockquote type="cite">
        <br>
        [1]
        <a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/latest/source/drivers/block/nbd.c#L1501">https://elixir.bootlin.com/linux/latest/source/drivers/block/nbd.c#L1501</a>
        <br>
        <br>
        Signed-off-by: Yifan Zhao <a class="moz-txt-link-rfc2396E" href="mailto:zhaoyifan28@huawei.com">&lt;zhaoyifan28@huawei.com&gt;</a>
        <br>
        ---
        <br>
          lib/backends/nbd.c | 16 +++++-----------
        <br>
          lib/liberofs_nbd.h |  2 +-
        <br>
          mount/main.c       |  5 ++---
        <br>
          3 files changed, 8 insertions(+), 15 deletions(-)
        <br>
        <br>
        diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
        <br>
        index 46e75cd..2d941a9 100644
        <br>
        --- a/lib/backends/nbd.c
        <br>
        +++ b/lib/backends/nbd.c
        <br>
        @@ -52,7 +52,8 @@ struct nbd_reply {
        <br>
              };
        <br>
          } __packed;
        <br>
          -long erofs_nbd_in_service(int nbdnum)
        <br>
        +/* Return: 0 while nbd is in service, &lt;0 otherwise */
        <br>
        +int erofs_nbd_in_service(int nbdnum)
        <br>
          {
        <br>
              int fd, err;
        <br>
              char s[32];
        <br>
        @@ -72,17 +73,10 @@ long erofs_nbd_in_service(int nbdnum)
        <br>
                  return -ENOTCONN;
        <br>
                (void)snprintf(s, sizeof(s), "/sys/block/nbd%d/pid",
        nbdnum);
        <br>
        -    fd = open(s, O_RDONLY);
        <br>
        -    if (fd &lt; 0)
        <br>
        +    if (access(s, F_OK) &lt; 0)
        <br>
                  return -errno;
        <br>
        -    err = read(fd, s, sizeof(s));
        <br>
        -    if (err &lt; 0) {
        <br>
        -        err = -errno;
        <br>
        -        close(fd);
        <br>
        -        return err;
        <br>
        -    }
        <br>
        -    close(fd);
        <br>
        -    return strtol(s, NULL, 10);
        <br>
        +
        <br>
        +    return 0;
        <br>
          }
        <br>
            int erofs_nbd_devscan(void)
        <br>
        diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
        <br>
        index 78c8af5..b719d80 100644
        <br>
        --- a/lib/liberofs_nbd.h
        <br>
        +++ b/lib/liberofs_nbd.h
        <br>
        @@ -34,7 +34,7 @@ struct erofs_nbd_request {
        <br>
          /* 30-day timeout for NBD recovery */
        <br>
          #define EROFS_NBD_DEAD_CONN_TIMEOUT    (3600 * 24 * 30)
        <br>
          -long erofs_nbd_in_service(int nbdnum);
        <br>
        +int erofs_nbd_in_service(int nbdnum);
        <br>
          int erofs_nbd_devscan(void);
        <br>
          int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
        <br>
          char *erofs_nbd_get_identifier(int nbdnum);
        <br>
        diff --git a/mount/main.c b/mount/main.c
        <br>
        index d2d4815..f6cba33 100644
        <br>
        --- a/mount/main.c
        <br>
        +++ b/mount/main.c
        <br>
        @@ -1270,6 +1270,8 @@ static int erofsmount_nbd(struct
        erofs_nbd_source *source,
        <br>
                while (1) {
        <br>
                  err = erofs_nbd_in_service(msg.nbdnum);
        <br>
        +        if (!err)
        <br>
        +            break;
        <br>
                  if (err == -ENOENT || err == -ENOTCONN) {
        <br>
                      err = waitpid(child, &amp;child_status, WNOHANG);
        <br>
                      if (err &lt; 0)
        <br>
        @@ -1280,9 +1282,6 @@ static int erofsmount_nbd(struct
        erofs_nbd_source *source,
        <br>
                      usleep(50000);
        <br>
                      continue;
        <br>
                  }
        <br>
        -        if (err &gt;= 0)
        <br>
        -            err = (err != child ? -EBUSY : 0);
        <br>
        -        break;
        <br>
              }
        <br>
                if (!err) {
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------B0i5MkXSrRBdO60HXfjNolTR--

