Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F26586178
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 22:54:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lwtlk6S3vz2yjC
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 06:54:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=lyvfdfJP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=lyvfdfJP;
	dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LwtlY6zpyz2xGY
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Aug 2022 06:54:00 +1000 (AEST)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1EEED3F124
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1659300836;
	bh=oetciNaFvOyu6miLrOcIhO8I739HH4iYwVzl68thMnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lyvfdfJP21XAvyDXs2NUlGwpaVmIsDvkyFD/MGmc/IMHS4OCE9uYSi6KMjDeCY6kO
	 AAYa4RsjfpsZmJXjpLSzqj4PhLvUE1iDy6DuCnd7BwEdoQw3S97s1GKELp+U2ZUWm6
	 NIxB3qDVFADPP6TSXnfCyMuIX37Q5NCZ+zDzq/3LVRQLcCPB47xhlKoEMNksGTSaAz
	 V2SH9mqtrKCiSpM67KfgCo8I9rMcrB/hJ3o2YVAwlbBied18/xBSUp01wwl8bRfp/c
	 8pQ1N5ioj0qpCcYzkBl6Nn3fL+N6cT7fX+kmvt8n43QiwVTOtddTc73JYhMN6LC5wx
	 SV3L/Axav4U/w==
Received: by mail-lf1-f71.google.com with SMTP id j30-20020ac2551e000000b0048af37f6d46so521205lfk.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 13:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oetciNaFvOyu6miLrOcIhO8I739HH4iYwVzl68thMnc=;
        b=AD2xIHGFcguwX/IslGPm5Ztk16djSz4oSNNSQxqV9kUvLzHvuZCNj6lOiUGuTzem/Q
         zT9W8yuXhvEuEI6g5BU21XignMpzcjojQSquZ1ll2990SvarFVFLv6Wjx40lj4SVfKrZ
         ff6JwICmGLveHSYXp0cysN9/8QqLnbcUWB/wkOkeV9A5tEfG8qDgmNdieRXC6TPPBP2n
         wgbF7k09/S+ujYKx4ihI6KrtHBj9PkdS7FZHciHegVpCyITkHroLzozrNfMBLNGifoP8
         veQMc4o5iye2kp/69zJr80j7GXXG5WwQfVd88dCovPfFnffPZXt0ou6mu0WGo46bhLEd
         UtKg==
X-Gm-Message-State: AJIora8hm6W3hSttWGbTSlGGMkFfN3nLOnoTGIw5SNncJSxmqk5QPbzI
	USGiAPkPUdTG2eOUqL3hPVs9CE5ZuZqAtU0LqYwAVcteskxs28nd8UHuzPjp7n8hSLqTwyecfpz
	XM51qxhrqnrM/RTOpiO/mdFfzLx0yIR6pJgTjhREjQg==
X-Received: by 2002:a2e:a60b:0:b0:25e:3087:4fbb with SMTP id v11-20020a2ea60b000000b0025e30874fbbmr3972985ljp.460.1659300835577;
        Sun, 31 Jul 2022 13:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ubMUTmrI7LPEHhlHR7sF2lZ8y/sGM8lWRZnLX9mZvekj77KJ8bPNGSVhaasMU0yuLV25ZxJw==
X-Received: by 2002:a2e:a60b:0:b0:25e:3087:4fbb with SMTP id v11-20020a2ea60b000000b0025e30874fbbmr3972982ljp.460.1659300835269;
        Sun, 31 Jul 2022 13:53:55 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id s12-20020a05651c048c00b0025d65d4e178sm1408473ljc.120.2022.07.31.13.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:53:54 -0700 (PDT)
Message-ID: <2d3db77a-66d1-8bac-dc53-30d322e6784f@canonical.com>
Date: Sun, 31 Jul 2022 22:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/1] fs/erofs: silence erofs_probe()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
References: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2mXuT5w5SKSeBnzUvBFvtwfmYqjZGWGutPiJ+4-fi_sg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2mXuT5w5SKSeBnzUvBFvtwfmYqjZGWGutPiJ+4-fi_sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/31/22 20:41, Simon Glass wrote:
> On Sun, 31 Jul 2022 at 03:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> fs_set_blk_dev() probes all file-systems until it finds one that matches
>> the volume. We do not expect any console output for non-matching
>> file-systems.
>>
>> Convert error messages in erofs_read_superblock() to debug output.
>>
>> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   fs/erofs/super.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 4cca322b9e..095754dc28 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -65,14 +65,14 @@ int erofs_read_superblock(void)
>>
>>          ret = erofs_blk_read(data, 0, 1);
>>          if (ret < 0) {
>> -               erofs_err("cannot read erofs superblock: %d", ret);
>> +               erofs_dbg("cannot read erofs superblock: %d", ret);
>>                  return -EIO;
>>          }
>>          dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>>
>>          ret = -EINVAL;
>>          if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
>> -               erofs_err("cannot find valid erofs superblock");
>> +               erofs_dbg("cannot find valid erofs superblock");
>>                  return ret;
>>          }
> 
>> @@ -81,7 +81,7 @@ int erofs_read_superblock(void)
>>          blkszbits = dsb->blkszbits;
>>          /* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>>          if (blkszbits != LOG_BLOCK_SIZE) {
>> -               erofs_err("blksize %u isn't supported on this platform",
>> +               erofs_dbg("blksize %u isn't supported on this platform",
>>                            1 << blkszbits);
> 
> Does this message appear in normal scanning, or is it a genuine error?

The erofs driver on Linux only supports LOG_BLOCK_SIZE == 12. So if we 
see this message we don't have a valid erofs file system.

@linux-erofs:

The Linux driver requires EROFS_BLKSIZ == PAGE_SIZE == 4096.
The page size on arm64 can be 4 KiB, 16 KiB, or 64 KiB.
The page size on amd64 can be 4 KiB, 2 MiB or 4 MiB.
Requiring EROFS_BLKSIZ == PAGE_SIZE is obviously a restriction that 
should be lifted.

Best regards

Heinrich

> 
>>                  return ret;
>>          }
> 
>> --
>> 2.36.1
>>
