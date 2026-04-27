Return-Path: <linux-erofs+bounces-3362-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OPHAKV272nfBgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3362-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Apr 2026 16:45:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC1474A2F
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Apr 2026 16:45:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g45wJ3SPvz2xcD;
	Tue, 28 Apr 2026 00:45:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777301152;
	cv=none; b=j7HnlgDuuMYNifWaZZI2JKF/CO0palPPi7OFWKJ8MndoBAGbo12n1ufJBLR92tu8o7d1VFAUI6+SaqWhjvVLVcapLvBLw/pf0XA51gxWV01BLLRAVXUopxoEFrnuYqSACM5zNtG4eneyH1MMoPRLVkXaeNe7trP5zb/PyenPbMK+K9krfHNFJBETlPP6oOghDCtmw0RJBwyLxS8JjVxhFjRPdTAVaTRcyjA38uXfJdDPGmZ8uJf9ITofCCeXxANuH+1bgZYDf0TiCHi3irEAOUoWpm4W59Yw1wPb+MqmhnbNS0g2M84L6jMD9NIGCDb8xiuSviPMYek/rXB68nqCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777301152; c=relaxed/relaxed;
	bh=q3aIvjod1hkwBWwjEQMOyxGraz9Cd8sLurUppc9iXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoyBSjw57ZgLN5TLl0tmaV0XZ5Deg7GpF0TQN/h7aBimqHblUEIiiWoL+a2pz4aUSKGvIbcTiCrZ+cxMW4uF1ARtjNhivjmyEU25KO94WKMjvQ1qru3tKyJO6kS66c+Pbxbmf9+vV+l28h7sX0hmMEYr9Nly1lUqALDKFFfGJGhIdXGIL1uQJZLc127kv59htD244RT0a5RIsNPvKafljOrfhamoYewEO7ObAMbgMOPfzogrSQFph+01eufKQshX+txmUiNfDTBMhI68rq9JKH6YGkKKM45z41LUBu8VmrYSASC8ny4S8DFlKqOoEHSYTZHsgEVt7g+fTLLqiOLm7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpRNLsd2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=oxffffaa@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpRNLsd2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=oxffffaa@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g45wG4GbBz2xWP
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Apr 2026 00:45:49 +1000 (AEST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so8430570e87.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Apr 2026 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777301145; x=1777905945; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3aIvjod1hkwBWwjEQMOyxGraz9Cd8sLurUppc9iXOo=;
        b=FpRNLsd2srg7tIDuaOFsYASdi0RVhoAg3aEticusyg/4UOgpIWW8TIYr3yWaXsbrDB
         IjMSjDoekMAX62G4MYpqvWQxkyMxst8v5XgcO5eZbcsaa50ZwVUn6nyUZgf+u9VM3VlV
         3j+bTJMrcxFtLibjlu1s4Y6qK5T8L16fmoVJX1Qd11huiWd+itEOG7ywd9k+8if35gU3
         Oa6YjJ+lV+NT+B0tWsJnc4KhVquUWskMM6R+1L2GCyZC8xSHsFxdPz0UCgAb1J9FM/ez
         3GawlqMcAYRGMWHLQsre5Xju7lhSlmUoQDgXUgkFm+/L1/W1mt/y02DedfRJXWTRw1Sp
         yw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777301145; x=1777905945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3aIvjod1hkwBWwjEQMOyxGraz9Cd8sLurUppc9iXOo=;
        b=eW7uwoPM9Ry9lyOjjEvAS+3IoA9p00NnrgBd3sfVn1S70qs3okqzRdH4erPFB1vFVv
         r7OAcriG4ftDhRw+xD3yThLBRhwZS6w3Uh1Ymr2Dvmtl8s6QdHO7PjghRZjgqJ/h2UwO
         9QR4A6WFQdhzam5vs/8RIgSM5rbGsnOs5EVApTNm4izwrt9RGhdwuj8dTszrF6yjfoSJ
         x/CLoX73QwqGfsirpKSIuwBEq9F0RD9N8HzHA6bQE+K8Qf5mVbbkWsjhlfQs+XvQKmMp
         LeNKlVPO4OMnRmKGeMFf+FDj05hxE++tBqhAPGVxdar59FEQ7wGkYxhxqcRKWtZ2m8OC
         TUEA==
X-Gm-Message-State: AOJu0Yy2Fnhm2/bqCa8H7YDWSlumOq83bqKiCqCHZ/wEdk83D7Yl8VlF
	4Kfg2e1iN15hC0cPmcoXySERdZpVU960dJIjwZFg+2nW3Z5ZntqeRl1u
X-Gm-Gg: AeBDievIgSwzGcc/1eUQrI/sGhvU5FhtvPQV7jaWmcs/TMmx4RIFyQXsbXB9TLVWeGP
	8/IxLoK2IuIeZTvXQcc7t/devjhablP6QjKMAIG3xolqu4damLaH5e6v9QsYKQTmW/+vZ7NM9OU
	MhdAkKc4Wj+tTadwDlxYapMUrt27BEniCt+HHH178ETEad6ESd3h/MIaODM9hGC1BIr3f22z6Lc
	WOLW8qtRTweIqKyX9+cJ8+qU447dLCyoqqOwGr1kOyX5N/G+fjrhBpCC+uilHahllNO5D8napy0
	8zjZMHMXstXppdjQ9S+esavIbZ132aq8/pA6ehtmxjQn+dWEWd+nfXVnn8URL5Vzk7iEvdzIOhS
	PG8gPJLKsdhlP2O1qXnjVr708GLe8xH+nnWhaZB7GsyVi727pui8Y3mi8z+hL+91m/XGhlGtU+V
	FuwnMpLZ8LWRCPwIfgYy1BGSXB1dXLLQc9d2Dwg1IDFJdO2he8
X-Received: by 2002:a05:6512:124d:b0:5a4:304:43cc with SMTP id 2adb3069b0e04-5a4172bb851mr13268087e87.9.1777301144378;
        Mon, 27 Apr 2026 07:45:44 -0700 (PDT)
Received: from [192.168.0.111] ([77.220.140.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7ad0sm8223836e87.58.2026.04.27.07.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 07:45:43 -0700 (PDT)
Message-ID: <24d53360-52c7-452c-8b8c-3c94a8cab65a@gmail.com>
Date: Mon, 27 Apr 2026 17:45:42 +0300
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
 <c09372f2-8387-4c5a-a0a5-218c4e846c89@gmail.com>
From: Arseniy Krasnov <oxffffaa@gmail.com>
In-Reply-To: <c09372f2-8387-4c5a-a0a5-218c4e846c89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 65DC1474A2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:avkrasnov@salutedevices.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3362-lists,linux-erofs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[oxffffaa@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oxffffaa@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zbv.page:url]


26.04.2026 14:42, Arseniy Krasnov wrote:
> 25.04.2026 18:29, Gao Xiang пишет:
>> Hi Arseniy,
>>
>> On 2026/4/13 15:20, Arseniy Krasnov wrote:
>>>
>>> 13.04.2026 10:08, Gao Xiang пишет:
>>>>
>>>> On 2026/4/11 23:10, Arseniy Krasnov wrote:
>>>>>
>>>>> 10.04.2026 18:41, Gao Xiang пишет:
>>>>>> Hi Arseniy,
>>>>>>
>>>>>> On 2026/4/10 21:27, Arseniy Krasnov wrote:
>>>>>>>
>>>>>>> 10.04.2026 15:20, Gao Xiang пишет:
>>>>>>>>
>>>>>>>> On 2026/4/10 19:37, Arseniy Krasnov wrote:
>>>>>>>>
>>>>>>>> (drop unrelated folks since they all subscribed erofs mailing list)
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 10.04.2026 11:31, Gao Xiang wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>>>> ...
>>>>
>>>>>>>>>> I need more informations to find some clues.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
>>>>>>>>> when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.
>>>>>>>> First, erofs-utils 1.8.10 doesn't support `-E48bit`:
>>>>>>>> only erofs-utils 1.9+ ship it as an experimental
>>>>>>>> feature, see Changelog; so I think you're using
>>>>>>>> modified erofs-utils 1.8.10:
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/ChangeLog
>>>>>>>>
>>>>>>>> ```
>>>>>>>> erofs-utils 1.9
>>>>>>>>
>>>>>>>>     * This release includes the following updates:
>>>>>>>>       - Add 48-bit layout support for larger filesystems (EXPERIMENTAL);
>>>>>>>> ```
>>>>>>>>
>>>>>>>> Second, I'm pretty sure this issue is related to
>>>>>>>> experimenal `-E48bit`, and those information is
>>>>>>>> not enough for me to find the root cause, so I
>>>>>>>> need to find a way to reproduce myself: It may
>>>>>>>> take time; you could debug yourself but I don't
>>>>>>>> think it's an easy task if you don't quite familiar
>>>>>>>> with the EROFS codebase.
>>>>>>>>
>>>>>>>> Anyway I really suggest if you need a rush solution
>>>>>>>> for production, don't use `-E48bit + zstd` like
>>>>>>>> this for now: try to use other options like
>>>>>>>> `-zzstd -C65536 -Efragments` instead since those
>>>>>>>> are common production choices.
>>>>>>> Ok thanks for this advice! One more question: currently we use this options:
>>>>>>> "zstd,22 --max-extent-bytes 65536 -E48bit". Ok we remove "zstd,22" and "E48bit",
>>>>>>> but what about "--max-extent-bytes 65536" - is it considered stable option?
>>>>>>> Or it is better to use your version: "-zzstd -C65536 -Efragments" ?
>>>>>> I'm not sure how you find this
>>>>>> "zstd,22 --max-extent-bytes 65536 -E48bit" combination.
>>>>>>
>>>>>> My suggestion based on production is that as long as
>>>>>> you don't use `-zzstd` ++ `-E48bit`, it should be fine.
>>>>>>
>>>>>> If you need smaller images, I suggest: `-zlzma,9 -C65536 -Efragments`
>>>>>> Or like Android, they all use `-zlz4hc`,
>>>>>> Or zstd, but don't add `-E48bit`.
>>>>>>
>>>>>> As for "--max-extent-bytes 65536", it can be dropped
>>>>>> since if `-E48bit` is not used, it only has negative
>>>>>> impacts.
>>>>>>
>>>>>> In short, `-E48bit` + `-zzstd` + `--max-extent-bytes`
>>>>>> enables new unaligned compression for zstd, but it's
>>>>>> a relatively new feature, I still still some time to
>>>>>> stablize it but my own time is limited and all things
>>>>>> are always prioritized.
>>>>> Ok, thanks for this advice!
>>>> FYI, I can reproduce this issue locally with `-E48bit`
>>>> on in 600s.
>>>>
>>>> I do think it's a `-E48bit` + zstd issue so
>>>> non-`-E48bit` won't be impacted and I will find time
>>>> to troubleshoot it this week.
>>> Yes, without '-E48bit' we also can't reproduce it for entire weekend on several boards. No such panics.
>> Can you check if the following informal patch resolves
>> this issue?  I've checked it locally:
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 8a0b15511931..824ffe4b871c 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1509,12 +1509,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>      DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
>>
>>      folio = page_folio(zbv.page);
>> -    /* For preallocated managed folios, add them to page cache here */
>> -    if (folio->private == Z_EROFS_PREALLOCATED_FOLIO) {
>> -        tocache = true;
>> -        goto out_tocache;
>> -    }
>> -
>>      mapping = READ_ONCE(folio->mapping);
>>      /*
>>       * File-backed folios for inplace I/Os are all locked steady,
>> @@ -1527,6 +1521,12 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>          return;
>>      }
>>
>> +    if (cmpxchg(&folio->private, Z_EROFS_PREALLOCATED_FOLIO, NULL) ==
>> +        Z_EROFS_PREALLOCATED_FOLIO) {
>> +        tocache = true;
>> +        goto out_tocache;
>> +    }
>> +
>>      folio_lock(folio);
>>      if (likely(folio->mapping == mc)) {
>>          /*
>> @@ -1546,14 +1546,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>              }
>>              return;
>>          }
>> -        /*
>> -         * Already linked with another pcluster, which only appears in
>> -         * crafted images by fuzzers for now.  But handle this anyway.
>> -         */
>> -        tocache = false;    /* use temporary short-lived pages */
>>      } else {
>> -        DBG_BUGON(1); /* referenced managed folios can't be truncated */
>> -        tocache = true;
>> +        DBG_BUGON(1);        /* referenced managed folios can't be truncated */
>>      }
>>      folio_unlock(folio);
>>      folio_put(folio);
>>
>>
>> I will form a formal patch later with comments and commit
>> message later.
>
> Hi, thanks! I'll test it!


Just tested this patch. Looks like problem is fixed in my reproducer!

Thanks!


>
>
>> Thanks,
>> Gao Xiang

