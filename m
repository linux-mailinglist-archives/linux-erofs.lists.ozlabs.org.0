Return-Path: <linux-erofs+bounces-2440-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMeuNi4SoWlwqAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2440-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:40:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50B1B2538
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:40:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMYxk0yZlz2xLv;
	Fri, 27 Feb 2026 14:40:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772163626;
	cv=none; b=FxZ1bI8ULY0eq/xTvcAEODMSOpzk1oC/z0B14RSPKJ7Q+CJTgMWK281Y0oaSR+m6HQJi2oGnuyrMeGtYMA58RTWoclt0zh2jquKsAWNV9hPEYAwrn7ikJLtatlmVSCvt1wSkTuf2u5VbgW9YizH7qQ0/DMQQvZetwIwWYIG1FEV7iWNJA9UcFtxffMn+lIUOq1lbKTuijYQy53Qy50xxXErXwbKOabPGpZZowu1J+M5ncVoQ1RqAoJ2XH+z+/32nOK7cDTD6fjaRB0aExl6W5XBemJ7cg27zUEH4qLhoXavs0uQHX8BKT/KVpGBxfUYSWMOeed6FFGfZayYskwh/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772163626; c=relaxed/relaxed;
	bh=7vY+x5LDeZAv0fhFs/K2EnaovCQGvdtKgpMSkJB6DOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS0beBwaxTV9auhBDConAajzry9RueAb44re7M5ziLhK4isd4TjsiuaqZHGGtkz7HJUIJxdP+XRnW7LZFXOfmkr4w27Mrfz82siP8YyHjRuLCXo+/tNEZP5z0PB8y0YKorQfF20syoRHn3fRSBcxCnDc7cpl3NNuT6cwkdxcb0Q1H1qCUa+uIru3tDzTJlA7dCiaYkMYqDFPTOkkw871XBormyY4rGdUHDiCnDxkoaWrGAhwOf1ZaLdkKijDmHrBrMtFhm7cxbWXoz0ChMXP1p7Y0aIgV35SOhR65odecqnOylNRZ4bX4ikze4ZO8E4zxTVgJk9my01xequibXu9uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hIaNJR/o; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hIaNJR/o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMYxg0rG0z2xKh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 14:40:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772163615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7vY+x5LDeZAv0fhFs/K2EnaovCQGvdtKgpMSkJB6DOQ=;
	b=hIaNJR/obSckjJI7I/s/furd3M66z2YIcSszSNmtvK7XvL4Ccj7RaQPUwuoOBpqACaXmnP5Pg9IB/nYCUtVdrmWHKYxFg8+uxGhGA3MQHYqRh6QSjZUby4ssn7sagPm2ROFn/LQ0CE+FT+h3WRzg0oPr9Ersq34e86V6dsY7rx8=
Received: from 30.221.131.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzsxcaw_1772163611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 11:40:12 +0800
Message-ID: <eaf480df-faf2-4482-b9c2-d868087d5a4d@linux.alibaba.com>
Date: Fri, 27 Feb 2026 11:40:10 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: converted division to shift in
 z_erofs_load_compact_lcluster
To: Ashley Lee <yester1324@gmail.com>
Cc: Yifan Zhao <yifan.yfzhao@foxmail.com>, linux-erofs@lists.ozlabs.org
References: <20260225173036.194311-1-yester1324@gmail.com>
 <tencent_E8B3BD7F4663756DD9915EF539DC95AB1805@qq.com>
 <555e6fbb-79f9-422f-9b43-bc655a106229@linux.alibaba.com>
 <CAJvxkqdnEMMBOBnXoVz7Ox6crwjWZVMm_Ve9bN7gGzFRHY-vwQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJvxkqdnEMMBOBnXoVz7Ox6crwjWZVMm_Ve9bN7gGzFRHY-vwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2440-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yester1324@gmail.com,m:yifan.yfzhao@foxmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[foxmail.com,lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CC50B1B2538
X-Rspamd-Action: no action



On 2026/2/27 07:37, Ashley Lee wrote:
> On Wed, 25 Feb 2026 at 18:40, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2026/2/26 10:32, Yifan Zhao wrote:
>>>
>>> A quick search shows that x86 kernel implementation also use `div` instruction
>>>
>>> under Linux v6.19 and GCC 15.2.1, add GCC correctly generate shift instruction
>>
>> Could we try more GCC versions and find the impacts?
>>
>> Does it a recent GCC regression?
>>
>>
>>>
>>> in my arm64 machine with GCC 14.2.0.
>>>
>>> Could you also consider evaluate this optimization in kernel?
>>
>> Yes, but I wonder if `div` is already used for these years on x86,
>> could you check this?
> 
> Hello all,
> 
> I'll attempt to perform benchmarks on as many architectures and
> compiler variants as I can. I was looking into lkp-tests to perform
> this however I was facing trouble running on my OS. Is there a
> simple way to do this?

I never customize lkp-tests, but I guess just triggering fio on
common platfroms with a given dataset (like enwik9) is enough.

Thanks,
Gao Xiang

> 
> Thank you,
> 
> Ashley


