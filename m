Return-Path: <linux-erofs+bounces-2436-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQyKXcXoGmzfgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2436-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 10:50:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695B1A3C0B
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 10:50:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM6CR0z78z2yFc;
	Thu, 26 Feb 2026 20:50:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::544"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772099443;
	cv=none; b=X3WUtueFlG0JlULki5PIHCAya+SYHOd1AdP7fgxPMK131L7Hf9+c1i8CMWKMnQC2Ls/iKrvvHAtecXtVNSKYeV+oSuwioF29OzBdB47NQeRge99G7C1x2ccEEyPVcRR3GnScmdwH2SLbO8WTPNLAPPlGNaskR4sVbpPI8bE7stAvRXSiR7/W1OznwtSLiRrQmgcWgeREcG5iAyi80ozEY9yvKgN1Mas0QCTFAgOKzUGPX1dDoNQLR8r7E408tpvuLJWokszsMse5yRlv3EnoGyONgwiuyGbH6MvQ1bQJqa8PoZwNUcCpHGzEHzc3MKboKO7GVlcCb03qgb2HVZMY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772099443; c=relaxed/relaxed;
	bh=zyc0/9KrHbOOQRAYpEcbfYPHyF4A4rCUm5ICA5edDMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b1KosQSI6IwsL0ESJMqi+kkoicEXmIixEgYT3fw4LreNf/IqUcw8F8g9jb2lbaUqlp8o6aROLT8U89PHpCjhrYFL7UEBD0MQYEO3Y/m1VWJcEoNInQnr4Ffg5YJBfmZ9tpSDFO1c2qtqvkz3fgXapEik1QzGm7oDWnkH1HyS/9Zqjzbzwia9iTX0iX1f13QZfNRONX/Xt5antaSbiU4ajI6mjPubwUzYPWWrydQHtNqBwKGUgUcAoSO0uxk1NZIZkyfhVCmrsh05BDE0hk9GGI247ptkr5+kZsnrCgLiWMK7kPNpMxYvXHSIwi75MZFObAjL7pwllJCBhZgUrMUuAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B8rUS/WL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B8rUS/WL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM6CQ1pZrz2xMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 20:50:41 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-c7103601c8cso148524a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099439; x=1772704239; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyc0/9KrHbOOQRAYpEcbfYPHyF4A4rCUm5ICA5edDMA=;
        b=B8rUS/WLSPcOki9pSE+NUqllAZSbgnkhwUWnEPXDBkEZfw0/11roAGqKEK0yiSfWe3
         Q8I1vEMMYquuLKssTX31xtVHMdK4fHK5H9PP77sIPDL3/wOxmzr/WQDHmT9E2xrpGa7f
         e5uQFDuhxhSlwDWP9hAj0MN8FIiOrlEvaWSZx8ZFqxssA4v++D3fpTT4NOIGELOJHbtY
         KY3vUB3Xr1BI2VJMR2gm05fQFAT3YQqCM0eTfS2HB5UHKWlwLhpzV9z5z1IdnB6t27f7
         16qDYn/S8TBWKdGxMOnAEqnN2eWoa3udD/f97kIQO1qu/MLAl2NRTBxWoXfRtOJxMjCY
         F/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099439; x=1772704239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyc0/9KrHbOOQRAYpEcbfYPHyF4A4rCUm5ICA5edDMA=;
        b=QG00OEUV1TreCtutYZjVRFXH8mEEww0mglrA27sOWx83fhsIrNtUdbTHU3TF7iNtko
         /yoOsgP+Tb7257WJOr0BQWSE/VmXi8ST3lp4EGGISqaSZBDl/RAFNgej5fvO3avWcUEH
         C1zrftAupCrd5k3iN8sHuJ5ADHm4ATrvzgiJBfAqyGTz8lTSuveSm9xzoicN8vQUNYtV
         9dPf656FnDHlgjP/OrYKJEmk2CPs+/0uJam3nUXM4Vx+2MEKnPiabV0ynDJkM2f+fno5
         AwQfFyDg1YTTylp9peqkgnJ8+JR/V93ZdX1fXMkeyilS0ymoxTAxlVva+rInYC1oBcoQ
         IsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXcD2omvyaGM4bE+N4JbTbiOjUhH5URNkUMIxphKTkiiPpIb+kCqna3+AUCs1etD/Ip9nfB4i9TM6g+g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0YVSoYhr1qKsK4CB2Hg/FZO03/SyqvyTp8dz387PLzbipgzJM
	j3ENg7ddVzcGjGOAL6diQwB4xjE7NnHoR6h7I+v5VF0V+oSuHskNMxSuEO+IGVLj
X-Gm-Gg: ATEYQzysHTb5Q9aowRvE1pVjlZ1QxuXn2e3wd8xfBTuCuMkGLX2Rx8lrX+MbYsBb9WZ
	rYPqyiRDOBEhmY7b1LGCRa6VS1r5+PyzBKFkIcFaZhP3TukVe9SWxXSsyJY8YzhQT+t2rKLamhT
	uhNYG6ecpC4AX7QOnHBqQS9Y6ExKySHknvK2lsjekXKhXfVBxE+fwNMuxpyX+TWgfcRAT9oqSQw
	nwqw4TO8sLRQJ/3/oSAJ9+mA0/8+v+t7ajsRcyUCurVxaTlZTN8i1mB5NE10XoZFQNdJ/n1QI28
	D0vTEqGn3oDekOLqcSvzB5AaRtn4PaNzUdR5U8dtKsZzZPqFactQknATam059GayKN6nI5ETZ1N
	jDwRmXc6A+Y1SMDZSBYwim/QCvFxEARRjzILZFih1Q2zsQEV1sFicgDGj3SzQAQeaJEJzpRJh3o
	ltIc8w3D2bXztGUOrJGr/+zuABktp4s1dTHcJzxTKIrBjqFA==
X-Received: by 2002:a17:90b:388c:b0:356:7b41:d355 with SMTP id 98e67ed59e1d1-3593dab83f5mr1669482a91.1.1772099439563;
        Thu, 26 Feb 2026 01:50:39 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm1582072a12.31.2026.02.26.01.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:50:39 -0800 (PST)
Message-ID: <dc96c4b5-d5c0-4ab9-be0b-934840b14659@gmail.com>
Date: Thu, 26 Feb 2026 17:50:37 +0800
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
Subject: Re: [PATCH] erofs: mark fileio folios uptodate based on the number of
 bytes read
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260226090947.2808686-1-shengyong1@xiaomi.com>
 <f748ff61-043f-402a-b4a5-e285a4e5db99@linux.alibaba.com>
 <a87a74aa-3241-4c16-80cb-b8cc1ae6e271@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <a87a74aa-3241-4c16-80cb-b8cc1ae6e271@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shengyong2021@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2436-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengyong2021@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: 0695B1A3C0B
X-Rspamd-Action: no action

On 2/26/26 17:36, Gao Xiang wrote:
> 
> 
> On 2026/2/26 17:28, Gao Xiang wrote:
>> Hi Yong,
>>
>> On 2026/2/26 17:09, Sheng Yong wrote:
>>> From: Sheng Yong <shengyong1@xiaomi.com>
>>>
>>> For file-backed mount, IO requests are handled by vfs_iocb_iter_read().
>>> However, it can be interrupted by SIGKILL, returning the number of
>>> bytes actually copied. Although unused folios are zero filled, they
>>> are unexpectedly marked as uptodate.
>>> This patch addresses this by setting folios uptodate based on the actual
>>> number of bytes read for the plain backing file. And for the compressed
>>> backing file, there may not have sufficient data for decompression,
>>> in such case, the bio is marked with an error directly.
>>>
>>> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
>>> Reported-by: chenguanyou <chenguanyou@xiaomi.com>
>>> Signed-off-by: Yunlei He <heyunlei@xiaomi.com>
>>> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
>>
>> Yes, it sounds possible. But can we just fail the
>> whole I/O for both cases?
>>
>> In principle, we should retry the remaining I/O once more
>> for short read, but failing the whole I/O could be one
>> short-term solution.
> 
> I wonder if we should simply:
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index abe873f01297..98cdaa1cd1a7 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -25,10 +25,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>                          container_of(iocb, struct erofs_fileio_rq, iocb);
>          struct folio_iter fi;
> 
> -       if (ret >= 0 && ret != rq->bio.bi_iter.bi_size) {
> -               bio_advance(&rq->bio, ret);
> -               zero_fill_bio(&rq->bio);
> -       }
> +       if (ret >= 0 && ret != rq->bio.bi_iter.bi_size)
> +               ret = -EIO;
> 
> instead. IOWs, filling zeros means nothing for us.

That makes sense. I'll send a v2.

thanks,
shengyong
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Gao Xiang
>>
> 


