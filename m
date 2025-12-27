Return-Path: <linux-erofs+bounces-1624-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C5CE5AEC
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 02:36:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff1x33y1z2xdV;
	Mon, 29 Dec 2025 12:36:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766843262;
	cv=none; b=NKW+rAoL9QNupBJ8WelAbVoahf1DUYUdVJXAIhLf0jBLq2owOaf//qayEdXo1LPEnECslRxGOyVm9iYofE4F6OMyOtX/FZ7h5hRv1yEqAwKF9Fr5GJ2zVpF7VMIaldFl3OQwnOEbQDzebHT/HDfv0lOT0fGKGaRIG25GKjDGbl7y9Dvyc8rKMJ8rMfiWBjhL2M6HA+8Sf7cp6XGzMBgB/FTxAwSf39z1RacffpTRDRORFp6QoLreJU1LP53QqbNMxocP3GZWCn6gGaqYxFC4UbjpffU/ua0YZZt9Tgsg1CfW732ektxD5kxYekmfSd1PlHHEKoGUjffx3lKMltSw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766843262; c=relaxed/relaxed;
	bh=g0C0mPTjWEcfpwwgKjPNx93WGFixzwAbYrszvDyUZcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3ggDducIFAsHT+UwoJkXRZaZEsDD+55BHyW+ESdJItADcOtQgQhJtAzqjO3HKVges8idw9duHb0ZXCMevnrCzeSNUoW+uyyl863AWZ5EqV1ZE9yg5P2n478TQINcUNqk9U61KMPHBs+4QnjwTUU3hBEfId/NjXa1CRLZrH44pJU8trZ2MO9cMPPS1gRWE27DOARL6OlvpzT8MevWmePqbfK6r0Pe4L0L3/AXjDcBQQpCkJZwCnR8HIvjaOiQu3SoNindxQkhQ3b568CNaHoTrVgVDgPLUEegkRPiEZGW2aL3IctjxMX3Wr0ZbwWM8K2+7wXGFUCadRAKJDZ638MlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EoxgBkZh; dkim-atps=neutral; spf=pass (client-ip=203.205.221.190; helo=out203-205-221-190.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=EoxgBkZh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=203.205.221.190; helo=out203-205-221-190.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 969 seconds by postgrey-1.37 at boromir; Sun, 28 Dec 2025 00:47:37 AEDT
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4ddkLx54G5z2xQK
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Dec 2025 00:47:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766843248;
	bh=g0C0mPTjWEcfpwwgKjPNx93WGFixzwAbYrszvDyUZcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EoxgBkZhrUpV/oVQjrbMOu7lWc0SKFS5kSb2aW0XQB5qVhgF8iV4PrHh1k1ESAOgW
	 UJ1FRDbptXF+D5KKnR6QpAm/IxgK+Da6LZOU1S8jJusmR2DIlLivqIj57fNG6Pyp/1
	 UhIpqRJvVAKcNWmw4+YMTPs9qb75JwYCU607TPQU=
Received: from [192.168.0.100] ([112.65.38.52])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 3F220AF8; Sat, 27 Dec 2025 21:15:50 +0800
X-QQ-mid: xmsmtpt1766841350th9jgp3od
Message-ID: <tencent_85AB41F1443BC20CF1AAE6B21E7DDDF39306@qq.com>
X-QQ-XMAILINFO: Mfa2ogpi8We7AUlp4bULIciUBTJTXHq2ZUhJ0psOtenC5IYsp4pzGnZUcCCQsh
	 7xDAMwZXPgeAYbvtVceyXdu5FiP7/smoWbpylBtsphOYXGL3TVzFRwAhn1S5HaBToR7/tdM7vqod
	 W7RT6GDVE8qCoaJ6tWoie0j+hoLFJrZHx6k5et+a0wk9UQQ8prhIRN+bEV66yyiVaiEthWXDmMpB
	 dKUouOCQ8q6lgqtuhc32QWYoQAzKjV3MdlIZEaYDgcfmY43SMue7G6jNsFn82ewh4ntZ9DZm6pod
	 xrLUx1CB7CoQYRZP9560ieGx8yjGy+4NO7YHL+npGvCJO+9W2COGCgl/G/RzqXHx2iKnbdFpKn1k
	 HOgsED1KLpR36lIAV8vGa6L6bKjtz0cgxyiNx1yQttZa371WdvEZJDCto4PHQcCtNeR+WanYgWQg
	 zQKctrgCGhYhsRnzC1IMEbA32/L8HjK2E7Q5/C/vZhnNqH4PDoe1Hb9YNbaxO82sWjEOiMHSygmy
	 fV0OmfV9NpSSjtoQDbQ1I3vPH3A3hvUj8N6bEEtxlIjLZ290viYSon32V220hfOH09IJz1gJRITZ
	 a/8AzGSawm7sJV0vUcq4xxbYYVvbYZFk2FoQj9AfHd06MPrb+JLmbO8+7ogIYSVNEA+UoB6AQhQY
	 3fx4H5ApNbHumO/naWmrjr5JXe5EkDlmqc3zBIEuBMaWZSQ+i/i19dlk9er9XpSghPEufdMooMsq
	 NvmuumJcfR/4Id6LMuiUmlsGLRFu6Sjqm0N7wgGlmjCcRg7nH9oIXiZZT40wTbdL3TI2B4hPMgyp
	 OdCGQ5kSQ2GGZsR1RpxEXuGbcQkGg43aVyeW1Qwh21jG1W3Dj7Waa9GUdMRHHRC0pnCadsK65WLi
	 tYLK8FCIBdwhdIHxcIM64VVCfjcp4zGU2d38oOjwWadnUjKpoLgiYCOwn58Qq/irV7iAzKbJgzfs
	 Eqh4n8aBrxrlhDRnxr4zj9UliE93TAqcgqOtUG0D1v1I5YmmUsyA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <31158ec1-c0f7-4d9d-8dc4-b6d897cfe048@foxmail.com>
Date: Sat, 27 Dec 2025 21:15:50 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: mount: fix ioctl-based NBD disconnect
 behavior
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251227113933.45791-1-zhaoyifan28@huawei.com>
 <20251227113933.45791-2-zhaoyifan28@huawei.com>
 <21413630-b4b9-4fdf-9daf-5081ec16aa07@linux.alibaba.com>
Content-Language: en-US
From: Yifan Zhao <yifan.yfzhao@foxmail.com>
In-Reply-To: <21413630-b4b9-4fdf-9daf-5081ec16aa07@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: YES
X-Spam-Status: Yes, score=5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.190 listed in list.dnswl.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [yifan.yfzhao(at)foxmail.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
	*  1.6 FORGED_MUA_MOZILLA Forged mail pretending to be from Mozilla
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,


I'm not entirely clear on what does the disconnect variable solves.

Disconnection could occur at any point during the execution of loop_fn,

meaning any read/write operations on the socket performed by loop_fn

might return EPIPE, and we must handle this case appropriately,

and I think merely checking whether disconnection has occurred

at fixed points in the loop is insufficient?


Thanks,

Yifan

On 12/27/2025 8:40 PM, Gao Xiang wrote:
> Hi Yifan,
>
> On 2025/12/27 19:39, Yifan Zhao wrote:
>> Currently erofsmount_startnbd() doesn't ignore SIGPIPE, causing
>> erofsmount_nbd_loopfn() to be killed abruptly without clean up during
>> disconnect. Moreover, -EPIPE from NBD socket I/O is expected while
>> disconnecting, and erofsmount_startnbd() treats it as error, leading to
>> redundant print:
>> ```
>> <E> erofs: NBD worker failed with [Error 32] Broken pipe
>> ```
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   mount/main.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/mount/main.c b/mount/main.c
>> index 5ba2e0a..965b0b8 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -621,11 +621,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
>>           off_t pos;
>>             err = erofs_nbd_get_request(ctx->sk.fd, &rq);
>> -        if (err < 0) {
>> -            if (err == -EPIPE)
>> -                err = 0;
>> +        if (err < 0)
>>               break;
>> -        }
>>             if (rq.type != EROFS_NBD_CMD_READ) {
>>               err = erofs_nbd_send_reply_header(ctx->sk.fd,
>> @@ -653,6 +650,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
>>   out:
>>       erofs_io_close(&ctx->vd);
>>       erofs_io_close(&ctx->sk);
>> +    if (err == -EPIPE)
>> +        err = 0;
>>       return (void *)(uintptr_t)err;
>>   }
>>   @@ -663,6 +662,12 @@ static int erofsmount_startnbd(int nbdfd, 
>> struct erofs_nbd_source *source)
>>       pthread_t th;
>>       int err, err2;
>>   +    /* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
>> +    if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
>> +        err = -errno;
>> +        goto out_closefd;
>> +    }
>
> Can we register a signal handler for SIGPIPE instead, and setup
> a disconnected variable for erofsmount_nbd_loopfn() to notice
> for example too (in case of unnecessary erofs_nbd_get_request()).
>
> Thanks,
> Gao Xiang
>
>> +
>>       if (source->type == EROFSNBD_SOURCE_OCI) {
>>           if (source->ocicfg.tarindex_path || 
>> source->ocicfg.zinfo_path) {
>>               err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
>
>


