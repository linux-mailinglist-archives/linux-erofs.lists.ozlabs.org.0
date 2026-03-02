Return-Path: <linux-erofs+bounces-2448-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hF3JJ8bupGlpwAUAu9opvQ
	(envelope-from <linux-erofs+bounces-2448-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 02:58:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8531D2624
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 02:58:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPMXc19FBz2xc8;
	Mon, 02 Mar 2026 12:58:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772416704;
	cv=none; b=Sf88tNUmTrV8arUVF4Fj4E0Mrampj9nbCXtEV3ztlst+2SAqKyB1+x4v3rDlO+a0aQi4qkJqgC6lMAKl7tebpJwr0sVnXeeh4ljM49gt43t2dCL/2CNyX60KWEPI/jw5lY3wGK1X1HcDOjzBJc+AYNItWKBqR6JvzAJXnZsX0W5l87ZnOpwkOZqz5OypEcEHJu9dt+XNw6W3L5j3rpU1u6j3u5mvcvJLIzoTUXKdPC1VB9qzvELMVWtW9NEFpHcSn5xMp9nEDpfJZvwEvSc9lBPzPsk93Gn0MyLcvx83DBzV4CDdODNMsD/qrVVOnpkTvleqV/4ULUGSFL4nWOlVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772416704; c=relaxed/relaxed;
	bh=bNMw80gxanFYA1aAgpQYlLWrhL5M2j4L5Ld2WxG5/k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZtA69L5oboZwAn5HWNlh+2WKCqxrLyROuK1vsWjWQqjUoLAaj+3MSZjMQLpyG1Xv29RVZhrOLGtoZXlC4vjyIzuEOmZSOUlTvhfim8A1jY3hSl5FZYuF+s/QVKDTHOGGFBLMhGCUocniixo+w/aMwjJuLq9NcHj38hId83F6zJuxEgtmGwnx+YWYNfrdkNWgw0WUGWHsPTjWGZ0sbGfPjvtQooQBTvsWJeCm0Vl8pjLXqEvtabrGvP8l1QFny/6DekblzAdGFULYTs60gSmHp8UHph5fiJM25Bid5fOKUY1slwgoX/2uwHfRzgd31CWwe2N4SPCJUeJwaFtTIazbmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MlAkOcil; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MlAkOcil;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPMXY35TCz2xNC
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 12:58:19 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772416694; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bNMw80gxanFYA1aAgpQYlLWrhL5M2j4L5Ld2WxG5/k8=;
	b=MlAkOcilIA1uUYn39C1YyzD2WfZkQYHtojYyNsDsnwt3LL3Gl+o77F/RE50QVnyBu14wFxe/MnttCXRIp5oiZS/cEfFT2A1iuVi073FK1Ns6YcVy/TgWcFs1UQS/pdqNpyOG0LiQzZ6O7r+eKbh0y56L0s3cKoPCz9dkHoOee78=
Received: from 30.221.132.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-.VKUC_1772416692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 09:58:13 +0800
Message-ID: <e6dedb36-d6b9-4eee-ae36-3694971f06f7@linux.alibaba.com>
Date: Mon, 2 Mar 2026 09:58:12 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mount: fix flag-clearing bug and missing
 error check in parse_flagopts
To: Yifan Zhao <yifan.yfzhao@foxmail.com>, linux-erofs@lists.ozlabs.org,
 Robert Rose <robert.rose@mailbox.org>
References: <tencent_003DF0338EAB42F1573BC0CCFBEACE321E06@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_003DF0338EAB42F1573BC0CCFBEACE321E06@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2448-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yifan.yfzhao@foxmail.com,m:linux-erofs@lists.ozlabs.org,m:robert.rose@mailbox.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com,lists.ozlabs.org,mailbox.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,foxmail.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,mailbox.org:email]
X-Rspamd-Queue-Id: AE8531D2624
X-Rspamd-Action: no action



On 2026/3/1 20:12, Yifan Zhao wrote:
> The MS_* constants in glibc's <sys/mount.h> are defined as members of
> an anonymous enum whose underlying type is unsigned int (because the
> last member, MS_NOUSER, is initialised with '1U << 31').  Therefore
> ~MS_RDONLY, ~MS_NOSUID, etc. are unsigned int values that, when stored

The problem seems glibc refines these macros as enum.

> into a 'long flags' field, undergo zero-extension, not sign-extension.
> As a result every 'clearing' entry (rw, suid, dev, exec, async, atime,
> diratime, norelatime, loud) produced a positive long, so the
> opts[i].flags < 0 guard in erofsmount_parse_flagopts() was never true
> and the corresponding flags were set rather than cleared.
> 
> Fix by casting the operand to long before applying bitwise-NOT,
> ensuring the result is a negative long with the correct bit pattern.
> 
> Also add the missing return-value check for erofsmount_parse_flagopts()
> in the '-o' option handler.
> 
> Reported-By: rorosen <76747196+rorosen@users.noreply.github.com>

It seems the real email is:
Reported-by: Robert Rose <robert.rose@mailbox.org>

Otherwise it looks good to me, will apply:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> Closes: https://github.com/NixOS/nixpkgs/issues/494653
> Signed-off-By: Yifan Zhao <yifan.yfzhao@foxmail.com>
> ---
>   mount/main.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index b04be5d..7c557bd 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -203,15 +203,15 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
>   	} opts[] = {
>   		{"defaults", 0}, {"quiet", 0}, // NOPs
>   		{"user", 0}, {"nouser", 0}, // checked in fstab, ignored in -o
> -		{"ro", MS_RDONLY}, {"rw", ~MS_RDONLY},
> -		{"nosuid", MS_NOSUID}, {"suid", ~MS_NOSUID},
> -		{"nodev", MS_NODEV}, {"dev", ~MS_NODEV},
> -		{"noexec", MS_NOEXEC}, {"exec", ~MS_NOEXEC},
> -		{"sync", MS_SYNCHRONOUS}, {"async", ~MS_SYNCHRONOUS},
> -		{"noatime", MS_NOATIME}, {"atime", ~MS_NOATIME},
> -		{"norelatime", ~MS_RELATIME}, {"relatime", MS_RELATIME},
> -		{"nodiratime", MS_NODIRATIME}, {"diratime", ~MS_NODIRATIME},
> -		{"loud", ~MS_SILENT},
> +		{"ro", MS_RDONLY}, {"rw", ~(long)MS_RDONLY},
> +		{"nosuid", MS_NOSUID}, {"suid", ~(long)MS_NOSUID},
> +		{"nodev", MS_NODEV}, {"dev", ~(long)MS_NODEV},
> +		{"noexec", MS_NOEXEC}, {"exec", ~(long)MS_NOEXEC},
> +		{"sync", MS_SYNCHRONOUS}, {"async", ~(long)MS_SYNCHRONOUS},
> +		{"noatime", MS_NOATIME}, {"atime", ~(long)MS_NOATIME},
> +		{"norelatime", ~(long)MS_RELATIME}, {"relatime", MS_RELATIME},
> +		{"nodiratime", MS_NODIRATIME}, {"diratime", ~(long)MS_NODIRATIME},
> +		{"loud", ~(long)MS_SILENT},
>   		{"remount", MS_REMOUNT}, {"move", MS_MOVE},
>   		// mand dirsync rec iversion strictatime
>   	};
> @@ -281,6 +281,7 @@ static int erofsmount_parse_options(int argc, char **argv)
>   		{0, 0, 0, 0},
>   	};
>   	char *dot;
> +	long ret;
>   	int opt;
>   	int i;
>   
> @@ -305,9 +306,11 @@ static int erofsmount_parse_options(int argc, char **argv)
>   			break;
>   		case 'o':
>   			mountcfg.full_options = optarg;
> -			mountcfg.flags =
> -				erofsmount_parse_flagopts(optarg, mountcfg.flags,
> -							  &mountcfg.options);
> +			ret = erofsmount_parse_flagopts(optarg, mountcfg.flags,
> +								   &mountcfg.options);
> +			if (ret < 0)
> +				return (int)ret;
> +			mountcfg.flags = ret;
>   			break;
>   		case 't':
>   			dot = strchr(optarg, '.');


