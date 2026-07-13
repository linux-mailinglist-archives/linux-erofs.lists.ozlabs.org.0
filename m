Return-Path: <linux-erofs+bounces-3880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UpxGD4x7VGoImgMAu9opvQ
	(envelope-from <linux-erofs+bounces-3880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 07:45:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AD74753B
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 07:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=S5NlGMQm;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3880-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3880-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzBHX6D8Bz2xlv;
	Mon, 13 Jul 2026 15:45:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783921544;
	cv=none; b=l5t+qCe7T05TrjovvmmHPWToQwMlPTEccSTuTUQinKPplxDxwIi+e5XFUB8FIIRZpKxEoE/NTWf7bOzABR16x/6wYZXCugvXOm8+zB95BpZo1xBmql3kLuPGDwa3RIi2Www5alEy+X0Y98+BVuwSu2WyvLTADgvCkah2yEkiN0KobtYdbesGvXEAxpydhn8GMIjoMmvQmbIniA4cUSyV2PtiGKVpeRIfpEa99vZX2qJEGXzBDFTK50WaBvxxeMjUYT6TzBjUaGkPGS22HqnnnaQBjyLfwY5XcnaFCjX2ql4Rt3Lym2Kv0GZuCGNL/a8yy9WWwTkjJ73hICK+mZR3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783921544; c=relaxed/relaxed;
	bh=uFekaIWvGGMu29Ps5oGZE7SikNcDlsQ2OFFA9vRlC+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvkn6BfxlA6gYneJHuCXZ3653+mKlZ3O0pxW/6yQ3NFak1I8Hr/6X/tnCRsvfUPxHPMkrUXT6KjRvkcgfJBWY0+Wk+PA7W0Yil14ZE7Zl/vIUkF2oVCtTRBB7bCgO+wOphWDdsPV9c7UTWw2+QPf1+koripFi/5XjcK1XMW5nfwNPGhLrXY9kE9kjyQ3kx9OT8Qnlo/Flq0n9U7D9yMAp4nn5EdNtzvg4RyBGQO0i8dUzArnbPhziPQthABfwz2iHedX3eTYLaxd6NLlckqEvsHT4Ze/UJVq8cBWaKfZ/ZVLjOpbY6J0wLZXDpMI9WnNfMD5QCm0u6sTyEYr0xSl5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S5NlGMQm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzBHV0YqVz2xjN
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 15:45:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783921530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uFekaIWvGGMu29Ps5oGZE7SikNcDlsQ2OFFA9vRlC+o=;
	b=S5NlGMQmRrMmkTzJZNSc1ZzJnyeKbAQiYOgRp+1IHjIu2R/czqm+Y2xrqKNKBp0cVMVzlrzzhtM8sRxjZBSl9t2STX82PxeDEO0PBQzQ8sXTaNSsa+1Ug6rbV3wFZFZIcr82t1OzNarzMvs7SFoQ7EcfwUeLnpNWdba+1IwFBns=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6u6xjW_1783921527;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6u6xjW_1783921527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 13:45:28 +0800
Message-ID: <8829ed0e-5ebc-4832-b9bf-9efdfeb128c7@linux.alibaba.com>
Date: Mon, 13 Jul 2026 13:45:26 +0800
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
To: Aleksa Sarai <cyphar@cyphar.com>, Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cyphar@cyphar.com,m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3880-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B3AD74753B

Hi Aleksa,

On 2026/7/13 12:52, Aleksa Sarai wrote:
> On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 86fa5c6a0c70..3040d4cf9b85 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>   enum {
>>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>   	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> +	Opt_source_fd,
>>   };
>>   
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>   	fsparam_flag_no("directio",	Opt_directio),
>>   	fsparam_u64("fsoffset",		Opt_fsoffset),
>>   	fsparam_flag("inode_share",	Opt_inode_share),
>> +	fsparam_fd("source",		Opt_source_fd),
>>   	{}
>>   };
>>   
>> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   		else
>>   			set_opt(&sbi->opt, INODE_SHARE);
>>   		break;
>> +	case Opt_source_fd:
>> +		if (sbi->dif0.file)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		break;
> 
> I don't think this handling is right for a few reasons:
> 
>   1. AFAICS this shadows the default "source" handling logic (because
>      -ENOPARAM is not returned for the non-fd case), which means that
>      this regresses existing erofs users -- everyone already uses
>      "source" today. I must really be missing something if this worked
>      when you tested it.
> 
>      Additionally, fsparam_fd unfortunately permits strings (where the
>      string is the numerical value of the fd number), meaning that this
>      will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
>      You will need to check param->type at least to avoid that.
> 
>      I meant to send a patch for this earlier this year, but a nicer
>      solution would be to have a custom helper similar to fs_lookup_param
>      except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
>      FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
>      missing and people keep accidentally creating unusable interfaces as
>      a result. I mentioned this in an LPC talk last year[1].
> 
>      proc_parse_pidns_param was my minimal version that only accepts
>      FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
>      add dirfd support yet then you should use something more like that.

Yes, I tried this patch just now, it seems it regresses the default
"source" as you said.  I have to withdraw my rvb.

Just check the codebase, it seems at least the minimal change is that
it needs a way for the default "source" to fall back to
vfs_parse_fs_param_source().

My initial rough thought for source_fd support for a filesystem was
not simple as this too, but I never tried to seek time to implement
myself according to my priority list.  As you said, I think in order
to better parse both source or source_fd cases, it should be better
to have better vfs helpers to parse both cases in a clean way;
I think then that should also enable bdev-backed source fds [1].

> 
>   2. On a slightly less critical note, fc->source has special handling in
>      the VFS in a few places and AFAICS this is the first example of
>      someone adding an implementation of "source" that does not set
>      fc->source to a proper value, which deserves some additional review.
> 
>      (At at quick glance it seems this just means that some stuff in
>      procfs will show as "none" rather than fc->source debugging, but
>      again it probably needs a closer look.)
  
Yes, "none" is useless for source fd cases, it'd be better to have
a path instead.

[1] https://github.com/composefs/composefs-rs/issues/346#issuecomment-4903974902

Thanks,
Gao Xiang

> 
> [1]: https://youtu.be/NX5IzF6JXp0?t=72
> 


