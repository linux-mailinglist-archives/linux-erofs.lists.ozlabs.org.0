Return-Path: <linux-erofs+bounces-3361-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FQrD0X67WkqpgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3361-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Apr 2026 13:43:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD34699B5
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Apr 2026 13:42:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Pvh2sTBz2yFl;
	Sun, 26 Apr 2026 21:42:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777203776;
	cv=none; b=QQbZg6XwGy4GOgrOnZrBE0+9Fj1KpHqyTAMKnFvG22bsBocCbVLQRNN264SO8umM4hEz5/5M1GifBno0fVyQYjbNPvv8O0l7b0fnI9Y7X1qCpG4j70pEm154MKb6oCFQEicsCH/5TjCC48QtgKsrVoDpEsfWoAib+StMEtCLdl0HyjHPMN1I6fHzTPnCrJSmfcQpZThxqx0RI6bZuSEdvuTUYCTeUvMQUh/GdkwZRuSGmmjEBAjYD4g2xGTC5U6wIiyEF6isDm5dFaZyVKOW5i3ulurwyxutF4BZ7ZK95nkVNPHwjtL6ECEl7JL2wqeOIVYFIH9oT8R/leUGFL+WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777203776; c=relaxed/relaxed;
	bh=kJxA9oClLHaU4OEVokkYdI+IHWTqJIbJUMk0XR0I/D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaJl08eSefTEqOQjSWPl1wX/v6qcRnnSshGcIlJ0vq0ofRgiuI12cfQxykZMl+g5EWFBZmXaQyZpUdQgE/kT0EhBoKOJxkngDjj0iYc1Z+zel3Ea6EYDY5jSG7K/VoYgn0yWHETrmekc1YULPb0AFklARrgV27/xpgs1bWkEQLRPGfmweMPGbM+majrHkrE/tFhgGbj2V+ftOUNKyi9OjjMJ6VWtFkYcYDN/QxMxeP281EnHz8q3nR4LFoPa+ua6CDkJVigINhxKKMRG/icXekhjI6XLhN8GyCRmWxYsOvutvLmM/TOwrCF7H+GQ7BBmh3VFi4JgjDZradizf+e0TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WHSZfYLf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=oxffffaa@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WHSZfYLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=oxffffaa@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Pvf4lPDz2y2B
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Apr 2026 21:42:53 +1000 (AEST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-38e800deae4so79235041fa.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 26 Apr 2026 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777203770; x=1777808570; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJxA9oClLHaU4OEVokkYdI+IHWTqJIbJUMk0XR0I/D8=;
        b=WHSZfYLflIwIQg51YWO8/MmjhHky9m7i2zZjvsEg9jISZXITAPu+Sx6B+aAbb7VkZm
         hwvdKsdfT8oOFaIXyO/oJ+lx8/Xu9q9GInxM8qQ7no2y1fMcvLvm/DCmBmoyG32iyLlI
         WTMZEFfGJk8OXdEdmwunph45AVSGFNaj4nos4aVdd7k1+VmezcTy5qKl+4OZJBS8FCdD
         h5zCmpw8I/O5yxOBrX1e8zbvOqNXFB/88zld592713QR/3N3K5nPVcI4bmveZ1fmLBV9
         zj1cpz/sq8UQUd1dAOXYxffnKymvnBURDgBXKqggI/ZvS/SpXuLnsKYISFlyAerHEVmv
         VHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777203770; x=1777808570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJxA9oClLHaU4OEVokkYdI+IHWTqJIbJUMk0XR0I/D8=;
        b=Sv8JO+rC3E071MyJeaSqMUeDH5kuAdeHYr2gvXLUk0ybkkUTiiSWxlYqEzlaTa7kdb
         IWFwiFgI+3K+VYr9TCQb/TDub03FbP6Srd/nr/tFGW/O6BffemCSM8zcn1kvmynHs8XR
         xJLgx5AP0HS1PBT9DNDbc48YptD6NqcFvUo6a1YLH+GBwUlxHKoXChovvVrrflpBw4pD
         XC2VpXHMOzLbaxeC53X59J5GvEwSvw54c0hv33/QkdOa4Ebp7OpYXatSOWxpvdjiThEc
         AkI/qoyIl12SnutiRX+cYWmw44InmgjwhDrPlnPu2q3OCLsvlfNkzpkg8v152yyRGUq9
         P1FA==
X-Gm-Message-State: AOJu0YxRMa+MTW4EASqXt4AIvovuRl/HFZe8t2EeG6QIVWVzfCBNcTHw
	mHVzNkdxhYoxi9LETaMa6ftvGGSjAWxsUYRW3UHW4L/QWdiD2y0vpltE
X-Gm-Gg: AeBDieusBUuh0e8l3H88KS1SezsI2Eu5j1bn9VIXPG8rQW+Ak4s6Du1LaaaomNj7t7P
	B3siThcKDfDg2OxFSd81PieqHjsOIxsTtnTK0kigRthOeomBWcLrn+eKBbPhelZObT1pFp5vtkc
	icsDIza/ZjRdMXuKzcuPevEwm4I4JF6IP4fU5wHSu0vaE3uyWlANZJ1wg7DBevQf69Z1zZv+QPZ
	JMqotq1OsdrN+G4GcxxhfNNIDx3PVcU3cBfvAtITEmRkYhiWcbZnWrjgdDKH65WFHTkbJpOQdfJ
	3iKG9Wa8CxwVm6t1T/ZnYUhixJ33B9zTv7C+H/kmcLqcGSbeUqYPNNTqSuE6nZdYcBZeDXZu8OI
	cQww3pR5XMHxTNdOi8GN1XDSZ0/Pkyvfbd7uBznVRE6M7pCVXFWCD3EKWbByYyXM7rjB+8zq0CA
	IenhmTFpCUE0WeXNjwo6s6XeMRj6x69lDFp5UAQA==
X-Received: by 2002:a05:651c:211f:b0:38e:ae31:f0ae with SMTP id 38308e7fff4ca-38ec745e678mr121731091fa.0.1777203769354;
        Sun, 26 Apr 2026 04:42:49 -0700 (PDT)
Received: from [192.168.0.111] ([77.220.140.242])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f65absm60034281fa.11.2026.04.26.04.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 04:42:48 -0700 (PDT)
Message-ID: <c09372f2-8387-4c5a-a0a5-218c4e846c89@gmail.com>
Date: Sun, 26 Apr 2026 14:42:47 +0300
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
Subject: Re: erofs pointer corruption and kernel crash
Content-Language: ru
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com, Gao Xiang <xiang@kernel.org>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
 <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
 <c2d7d5ff-237d-48b5-82a2-ac4618f055cc@linux.alibaba.com>
 <97ca00c7-822d-4b57-9dc0-9b396049adc9@salutedevices.com>
 <8c0bdfab-dbf2-4f1e-8e2a-ce18f166d841@linux.alibaba.com>
 <2ca3c8c6-f3ed-40ca-8f5c-1b43df479ad7@salutedevices.com>
 <36cddf44-3e08-4a19-82ed-04ca178ffab5@linux.alibaba.com>
 <15702a84-ea4f-4d12-b9e5-a37a4c3bb014@salutedevices.com>
 <f5789b4d-512b-4596-af79-cd2b80172b88@linux.alibaba.com>
From: Arseniy Krasnov <oxffffaa@gmail.com>
In-Reply-To: <f5789b4d-512b-4596-af79-cd2b80172b88@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B3BD34699B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:avkrasnov@salutedevices.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[oxffffaa@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3361-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oxffffaa@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]


25.04.2026 18:29, Gao Xiang пишет:
> Hi Arseniy,
>
> On 2026/4/13 15:20, Arseniy Krasnov wrote:
>>
>>
>> 13.04.2026 10:08, Gao Xiang пишет:
>>>
>>>
>>> On 2026/4/11 23:10, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> 10.04.2026 18:41, Gao Xiang пишет:
>>>>> Hi Arseniy,
>>>>>
>>>>> On 2026/4/10 21:27, Arseniy Krasnov wrote:
>>>>>>
>>>>>>
>>>>>> 10.04.2026 15:20, Gao Xiang пишет:
>>>>>>>
>>>>>>>
>>>>>>> On 2026/4/10 19:37, Arseniy Krasnov wrote:
>>>>>>>
>>>>>>> (drop unrelated folks since they all subscribed erofs mailing list)
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 10.04.2026 11:31, Gao Xiang wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>>
>>> ...
>>>
>>>>>>>>>
>>>>>>>>> I need more informations to find some clues.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>>>>>>>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
>>>>>>> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
>>>>>>> only erofs-utils 1.9+ ship it as an experimental
>>>>>>> feature, see Changelog; so I think you're using
>>>>>>> modified erofs-utils 1.8.10:
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
>>>>>>>
>>>>>>> ```
>>>>>>> erofs-utils 1.9
>>>>>>>
>>>>>>>     * This release includes the following updates:
>>>>>>>       - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
>>>>>>> ```
>>>>>>>
>>>>>>> Second, I'm pretty sure this issue is related to
>>>>>>> experimenal `-E48bit`, and those information is
>>>>>>> not enough for me to find the root cause, so I
>>>>>>> need to find a way to reproduce myself: It may
>>>>>>> take time; you could debug yourself but I don't
>>>>>>> think it's an easy task if you don't quite familiar
>>>>>>> with the EROFS codebase.
>>>>>>>
>>>>>>> Anyway I really suggest if you need a rush solution
>>>>>>> for production, don't use `-E48bit + zstd` like
>>>>>>> this for now: try to use other options like
>>>>>>> `-zzstd -C65536 -Efragments` instead since those
>>>>>>> are common production choices.
>>>>>>
>>>>>> Ok thanks for this advice! One more question: currently we use this options:
>>>>>> "zstd,22 --max-extent-bytes 65536 -E48bit". Ok we remove "zstd,22" and "E48bit",
>>>>>> but what about "--max-extent-bytes 65536" - is it considered stable option?
>>>>>> Or it is better to use your version: "-zzstd -C65536 -Efragments" ?
>>>>>
>>>>> I'm not sure how you find this
>>>>> "zstd,22 --max-extent-bytes 65536 -E48bit" combination.
>>>>>
>>>>> My suggestion based on production is that as long as
>>>>> you don't use `-zzstd` ++ `-E48bit`, it should be fine.
>>>>>
>>>>> If you need smaller images, I suggest: `-zlzma,9 -C65536 -Efragments`
>>>>> Or like Android, they all use `-zlz4hc`,
>>>>> Or zstd, but don't add `-E48bit`.
>>>>>
>>>>> As for "--max-extent-bytes 65536", it can be dropped
>>>>> since if `-E48bit` is not used, it only has negative
>>>>> impacts.
>>>>>
>>>>> In short, `-E48bit` + `-zzstd` + `--max-extent-bytes`
>>>>> enables new unaligned compression for zstd, but it's
>>>>> a relatively new feature, I still still some time to
>>>>> stablize it but my own time is limited and all things
>>>>> are always prioritized.
>>>>
>>>> Ok, thanks for this advice!
>>>
>>> FYI, I can reproduce this issue locally with `-E48bit`
>>> on in 600s.
>>>
>>> I do think it's a `-E48bit` + zstd issue so
>>> non-`-E48bit` won't be impacted and I will find time
>>> to troubleshoot it this week.
>>
>> Yes, without '-E48bit' we also can't reproduce it for entire weekend on several boards. No such panics.
>
> Can you check if the following informal patch resolves
> this issue?  I've checked it locally:
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8a0b15511931..824ffe4b871c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1509,12 +1509,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>      DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
>
>      folio = page_folio(zbv.page);
> -    /* For preallocated managed folios, add them to page cache here */
> -    if (folio->private == Z_EROFS_PREALLOCATED_FOLIO) {
> -        tocache = true;
> -        goto out_tocache;
> -    }
> -
>      mapping = READ_ONCE(folio->mapping);
>      /*
>       * File-backed folios for inplace I/Os are all locked steady,
> @@ -1527,6 +1521,12 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>          return;
>      }
>
> +    if (cmpxchg(&folio->private, Z_EROFS_PREALLOCATED_FOLIO, NULL) ==
> +        Z_EROFS_PREALLOCATED_FOLIO) {
> +        tocache = true;
> +        goto out_tocache;
> +    }
> +
>      folio_lock(folio);
>      if (likely(folio->mapping == mc)) {
>          /*
> @@ -1546,14 +1546,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>              }
>              return;
>          }
> -        /*
> -         * Already linked with another pcluster, which only appears in
> -         * crafted images by fuzzers for now.  But handle this anyway.
> -         */
> -        tocache = false;    /* use temporary short-lived pages */
>      } else {
> -        DBG_BUGON(1); /* referenced managed folios can't be truncated */
> -        tocache = true;
> +        DBG_BUGON(1);        /* referenced managed folios can't be truncated */
>      }
>      folio_unlock(folio);
>      folio_put(folio);
>
>
> I will form a formal patch later with comments and commit
> message later.


Hi, thanks! I'll test it!


>
> Thanks,
> Gao Xiang

