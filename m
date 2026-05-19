Return-Path: <linux-erofs+bounces-3449-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPuuAoMQDGoZVQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3449-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 09:25:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D5579008
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 09:25:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKR6P091Pz2xwH;
	Tue, 19 May 2026 17:25:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779175548;
	cv=none; b=TUKlhqq6k9RCZF5DvYR5PVgl1hs4SPmG4M2QCRaQDHLmQOGWh3OWAUcND8DFaQMuPPwTsyOIPiwZD3YaOd3YxmCW34LL+24kQrEx3M07syAixxxqfrRBVhrpoIlnRSGcE601Tpcky9mfWgn70jKSItnQl64E2VU71aAHzE05NdJEFq44pdmKETmdpK9fbuhchrK9y+2fpbd6bHe3fDNv8Z6Yc6dpmkrBPhrFqr33/pKQI7HGbxGLBsZcrtIIKR/tab6UJLWdfIYD0AgjkIMtqIvokC6RIN8Hh6ES3ySSoCv6MGOyD2Kmpbjci62fWVVSRzJ5x1TTZ/OShzV25ipaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779175548; c=relaxed/relaxed;
	bh=5j4OGQByxO6buY1HNm2sEBzvCPdPOOjHFKfuFwzdMNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSyAZTfFkY+ofIip+OQkfV3/taolCLcVe7wv7SA/MOY6f25oF48xxztjvzVbnIpsUSuWId2YWXH9Zt2Nllcyl72k4gpzU/crqOHAOSzxqIXkxyNh6OQxmS0RExeDpB0Y6u6fopPxzUerA6SivVXUpj/IBky8/+pTfUVoVQVRehRsIO2U3WVBLuvzE6VP4SGuIvUNXyF1uLAGfpsWz/dwJWGHjoVOWEyv1OAaxw2wtI/wECdY+wc0awcjIHsXVsZfdd8wlKEnC6Cx1nldu6PT3DsdPQdRmHpR0GnfscGJDMhA7mr0ei44eqKr+u/djk2v8B7h0lCEfgCq68EVFOrBKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=QniN0JzP; dkim-atps=neutral; spf=pass (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=QniN0JzP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKR6L2WDbz2xqv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 17:25:44 +1000 (AEST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C0BB13F667
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779175540;
	bh=5j4OGQByxO6buY1HNm2sEBzvCPdPOOjHFKfuFwzdMNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=QniN0JzP+S+nWeCTTSa8Sq4PGxVQS95Xft3gov1eXRq08pa1v7AS5rwznnT3dAc93
	 eaRCmRt0B9LYKwQoCIlQMOKi4dHcevsnhLpFXVlyhm0XJzjGKvLr+WM0Q/b85YVrpF
	 aK5T+N2NsX74LQq/mgW4LWzOOwwfW6EyeyBZDMt1n8JgpmP7IVPbE9vGoPYLzJ3+64
	 PFgldOsCvypX12erTEbBiH8EyoR7aopTXMfbELTZRIg4NMsHTRsk1JmZfZNJjLqV6V
	 mtSn2eusls98yDfCAS7DLtkIuHBL/WdAH2+/pv8mraYmOE+/iE4bfDZRYRGfhWP+yO
	 5PbEP1yCxT/+lzme9iQwzeDWLHFoiTarCqhgKx36MEIaAxzBDgtzEwVTf5XuYH+EZg
	 PeLzPhEu0ClvMws6K1+RIKeGQl6XIWTWS0trI+x8+Bc1p3w7oqHX0pvwn8+x20I99F
	 3qgs9Ni7w8Kt4aYTFen0ze8XHiDDXmxbrsKeebeUu4Ef2egMje9rBEnW+Ga4+ggbSa
	 q3kB+v8sy8pqFV5Q2sdf4rsmyUUbPdYFURFIR+sueqs4KTllqYwsmeG3Mt9T3iFS83
	 9WXBbuDaaz7uGcGxqKxeVDo1krvm7oEtSp+i6aUxlcDx9AmGdui7VpceD7dMkdWFNl
	 iaO780lCrj+bmYOrDKkE6FxM=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d789cebcfso2779994f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 00:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175540; x=1779780340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5j4OGQByxO6buY1HNm2sEBzvCPdPOOjHFKfuFwzdMNI=;
        b=Fq8Za/cZrIx2ElkKiQXm5r2tq/zwDpHEPQzF1psnZhGLDYE6PDshXurT6x6CpRc5er
         XehKImVlOHGlW5P6E1zBBQZnAvQEtTv3GVUQRyr3VJswR5hIfNwYobbU9M/OBx9qMUsk
         PQJIRLJmC13HEFL1bOF4+mCpi3w23lvHfjLvhw5N7/kNeHij7C1SMLUx0IzoeujI7ZLo
         bAjnAqgtvJOEhtEcWYIkRFLFH4Eo1fLWJ+gV+r6BmEuV8RRYaAiGWnRygX/pqOLQs1Ur
         fJjoB4sXcOtVu67G4r2HJspq2FJhGjt8FNoSzHDKdK/kw/+yxuzwrVeytTkkUNGLEbza
         nsGA==
X-Forwarded-Encrypted: i=1; AFNElJ+KFLRIeA9ezCiCUOTzLmnBUZhZUtbOsFSXOpDYRcN/ad5nH7BzlPDf5F1n1a+v/7XLUhXbsrPIGMFOwA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJ4q1HTsU4bh0cu98lPWZQCY5EUjWcdK36BiQ3gBV98zodr29C
	3YM3BhpibcP+1Y3k8OZSxzIIW2ugIwEn9RYJ5qfRhiC6SUFCV8aw6hpjaBtAJzRQAmOcC/gKMwW
	LPxXsKZYkqkufB+Cw73OV0sLTxlm2GvzbHqddP3119MFPfav0Vl3TPMJEECZvI/U00lCl1uMiIQ
	GNKq9Cew==
X-Gm-Gg: Acq92OHU7jRAiRywUp4VqQUh36G4ZIS+5DFaV75NsUTeVEJBUb4yyfy/WeoxmiY2tgW
	NUzHgwSoXVwEYIpMsHBWBqkvSLXRMlcYskDAOGcec5kC/1WllFCSZgZQtzR1GH+G3ne/eSefGEH
	/tkLuIm89LwBfC3IcmLvn19n67+Wv/f2zvmPe6waN5tDArL/6UFGLypk9J5Gxy7HGoxsWq+PhV9
	4Pm2PGVfAuAs4X+UdOUuH6ZoEma8LRN/JDe7SPdTe3M3EgpHr3fTyJnLrXXdfVee1xpqZI5grpJ
	OBCNftt9hbyLOwHHalgKRFzfCMyvw9UlMlW4xhhh/Sago76vQAmEttI3kceLK0SA9Qhk5YFpgRF
	QVqpBCrP1t/LVys30OI6yThi4xRN3n2iOh2rAE3LhCGLA1+maVpElyLHSefu6LGoKNa81bFH91h
	B8ZD5UTJZmbY8GMJ84aIWKj7L6YrCSfWEi0QSnprHxvLaduBhvrmYm9gCu5T5zFpzhDcM=
X-Received: by 2002:a05:6000:410d:b0:451:73c8:9101 with SMTP id ffacd0b85a97d-45d92797006mr26017307f8f.18.1779175540436;
        Tue, 19 May 2026 00:25:40 -0700 (PDT)
X-Received: by 2002:a05:6000:410d:b0:451:73c8:9101 with SMTP id ffacd0b85a97d-45d92797006mr26017265f8f.18.1779175540087;
        Tue, 19 May 2026 00:25:40 -0700 (PDT)
Received: from [192.168.103.101] (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm44905739f8f.32.2026.05.19.00.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:25:39 -0700 (PDT)
Message-ID: <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
Date: Tue, 19 May 2026 09:25:37 +0200
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
Subject: Re: [PATCH 0/9] fs: add change date to ls output
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518181553.GU1858239@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518181553.GU1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3449-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 995D5579008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:15, Tom Rini wrote:
> On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:
> 
>> The ls command currently only displays the size and name of files and
>> directories.
>>
>> * Add the change date to the output on FAT and ext2/3/4.
>> * Use the actual date when updating the change date in ext2/3/4
>>    file-systems.
> 
> What's the motivation for this change, and how much of a size impact
> does this have in general?
> 

For qemu_arm64_defconfig fs/fs.o shows a growth of 260 bytes in .text 
and .data sections.

Change times let users immediately spot which files were modified most 
recently (kernel images, device trees).

If a device stops booting, seeing a file’s change date helps determine 
whether a recent change could be the cause.

Best regards

Heinrich

