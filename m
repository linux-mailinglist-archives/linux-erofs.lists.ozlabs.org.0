Return-Path: <linux-erofs+bounces-3894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pEwBFQLbVWqUuQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 08:45:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED475199A
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 08:45:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=h1uRPzQ5;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3894-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3894-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzqYp62ynz2xqn;
	Tue, 14 Jul 2026 16:45:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784011518;
	cv=none; b=bZYghxTlo3XO259yA3SSUSM2lly7y9CD/APXCJKLZh2ioMglnZrPYQC60ED7fTcuFm/KNmBtqTQ6z1Do4G0ZRhzCDiWYDp+SWGALqdkmhs7tQ/XBefaG6p0E2qWbJdQNDb7TBLd14vLNfmiOM/2bzx1uSXjZRFM4AJjcIEv/dOETui6TLaJouyOCe4UEM7NXjHknEY727Z12JZq4XUVKEFw4vST7L0Ih2RY84dLTztWbnc6QtJSxBdkvB0wg2y1blaKmWFJVVG/P7YCPqVtrTGpGcU9FSRmLqJavsGuCyssGlkkkltMDIdGehkpieD/IJO9i1NU0YBO4M0dhvEEqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784011518; c=relaxed/relaxed;
	bh=vGbmFD6y9CGGcHfpyGvrjOOFr/zJMI05639wnL9HMzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRfZiiV8q0cZZLykVtpWVrx+l/oYlBmqZ72S6j64psg/lPPTTMlwHic9/OvgAel6jdvoLCUqUxeQ2hSFFCyWVY4Dr+EN55UY1Xag2Pc7KSXtqR7OiKyTmwlHfJDkt1vgGowlmICwFWdSF22McDuBYsGJPl+HXXbaJxyUkyIjqpItLwxGpxUR9yRrJHo8DNSmS3qYYX8YjZrs9mno6S0SYpBitxNSN9zACfb9+nnBKV39PHYGy7we/1wG+tXyqnSNgFvkwrYTFSEqK1drPsNxsFiHrhwpil/V/RYEYsqdeDSYhz+IiHTUF3KVkCQYpFbtqIvaKFhMuP4ZrIbuXjrB+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h1uRPzQ5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzqYm6b13z2xPb
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 16:45:15 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784011511; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vGbmFD6y9CGGcHfpyGvrjOOFr/zJMI05639wnL9HMzM=;
	b=h1uRPzQ5boh4V0yFpDorMPhlMesfIDwmzAouBU0d53F6Le5aI0OSbte7egdInI4pYZjE/1qH/4GYCzQS4HSaBv8vicu4g3Y8gKH79KUozvytRkavcUv5XUiZkgE0KAlvfH8uBk4ZynYfG+6y7B/flNkmtNW6WCYYO1PJJtJCdyo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X73ODja_1784011509;
Received: from 30.221.132.65(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X73ODja_1784011509 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 14:45:10 +0800
Message-ID: <c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com>
Date: Tue, 14 Jul 2026 14:45:09 +0800
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
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
 <871pd748kh.fsf@redhat.com>
 <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
 <87wluz2nnc.fsf@redhat.com>
 <2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
 <ba9cf493-45c8-45e8-9e21-9731ec492030@linux.alibaba.com>
 <87pl0q2i2r.fsf@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87pl0q2i2r.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3894-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:cyphar@cyphar.com,m:brauner@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BED475199A



On 2026/7/14 14:36, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> On 2026/7/14 08:49, Aleksa Sarai wrote:
>>> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>>> thanks for the hints.
>>>>
>>>> I'll prepare a v3 if you are fine with the version below:
>>> No worries, and this seems more reasonable at a first glance.
>>>
>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>> index 86fa5c6a0c70..72c85cc53085 100644
>>>> --- a/fs/erofs/super.c
>>>> +++ b/fs/erofs/super.c
>>> ...
>>>> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>>>>    	return false;
>>>>    }
>>>>    +static int erofs_fc_parse_source(struct fs_context *fc,
>>>> +				 struct fs_parameter *param)
>>>> +{
>>>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>>>> +
>>>> +	if (fc->source || sbi->dif0.file)
>>>> +		return invalf(fc, "Multiple sources");
>>>> +
>>>> +	switch (param->type) {
>>>> +	case fs_value_is_string:
>>>> +		fc->source = param->string;
>>>> +		param->string = NULL;
>>>> +		return 0;
>>>> +	case fs_value_is_file: {
>>>> +		char *buf, *p;
>>>> +
>>>> +		sbi->dif0.file = get_file(param->file);
>>> A very minor nit, but you can actually steal the file reference here
>>> with
>>> 		sbi->dif0.file = no_free_ptr(param->file);
>>> A few other places do this. (You'll also need to change the
>>> param->file
>>> reference below.)
>>>
>>>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>>> +		if (!buf)
>>>> +			return -ENOMEM;
>>>> +		p = file_path(param->file, buf, PATH_MAX);
>>>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>>> I think that /proc/self/fd/%d would be a more useful name for
>>> debugging
>>> if file_path() fails (not that it is really possible here AFAICS). But
>>> I'm not really too fussed.
>>
>> Not quite sure if we should get in agreement with the format of this
>> one in advance (IOWs, users use source_fd and how fc->source looks like;
>> since other fses may follow the same practice if source_fd becomes common
>> later) since it's a user-visible field and I believe we shouldn't treat
>> this one as a dontcare field as some pseudo fses (since those fses don't
>> rely on `fc->source` by design but typically EROFS can rely on.)
>>
>> I hope Christian and others could share move thought on this part too
>> before I land this feature for the next cycle.
> 
> would it be better to just return the error from file_path without any
> fallback?

I hope Christian or other vfs folks can decide how to handle fc->source
string here, since in the long term, how to deal with source_fd should
be unique among different fses: just our current short-term
implementation lands into erofs directly for file-backed mounts to
fulfill composefs needs.

Thanks,
Gao Xiang

> 
> Thanks,
> Giuseppe


