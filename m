Return-Path: <linux-erofs+bounces-2715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNygIBR+t2muRgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 04:50:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E00294792
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 04:50:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ1Mg2QXRz2xlP;
	Mon, 16 Mar 2026 14:50:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773631635;
	cv=none; b=iLkQJ5oDEYYQ4CqzV/pkAbtGLnQ2V2ySytsou6l3cn+pwaKqqhNy5Z7LPg1qviHb6xYBxYaFpDfL3vXrHd7nTaBv3VXb+yrSfNcQCZEGzCb5MIsZ3lvo9a8UKo14KDhy9VlHdiqKzTAo+8Qw6H2XlIVQcj+O3OWReu1Em3y7N4pBVJb7V/1uokf3/QcSdkujW5C1GLbtGHtNkTZpwT+RsW0G4r0FCNx68qoRQV1UoBNyMoJbpHQC5PAHuRHcTgTsMmfvbD7xP0RY7unAHnS7p0sRm5gHwSgA98I6vrwnoUjOpSHI2KwcyVgo/vnkzwXSFB5injdphCs03RRfhGkZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773631635; c=relaxed/relaxed;
	bh=eOOmcvMV8q5x73xPyR44di4FD5fhaa55C3RW4AxZGqw=;
	h=Message-ID:Content-Type:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Ygnz1yIACLp+XcsurOS3dWnL7JL88CsqneHTKqwVU79k/7Tf5hTCj7Hz+D+8L+9LxIro3oJZ0JMX/ySfCf0tMmdXMlqarn4EDsFTCN9zFB7flhwrAd6hknblIxJjRXraX/OB77DanYni1unyFVzbhUB9mQXHuJvAkTKd1xLZnNKH9lRoqqM7hXcRFrUkRohFq6A0rVnGJruMwQ25SfNbIAXiyuRM3MwyD56V78lO32OLzvLrdKjorgAUj721UoN3JGTrDsuMZHZUdeJdgwEduqYQdKxg8Ssl/KbmSxr8txCxgHjvY+YGtH3nSmG7gsWnaZFera+XVnBFrZ5mOs/lRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=GYaOQd19; dkim-atps=neutral; spf=pass (client-ip=162.62.58.211; helo=out162-62-58-211.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=GYaOQd19;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=162.62.58.211; helo=out162-62-58-211.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4fZ0rY4wrKz2xS6
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:27:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1773631623;
	bh=eOOmcvMV8q5x73xPyR44di4FD5fhaa55C3RW4AxZGqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GYaOQd19wjD18+98Q/G8Y75Ed/uakPOGDewRh6VUD9b0M+duZOkWVGDiOqN47WeyJ
	 7fSJbAl0iJzhYmE8HmBQENwk5lZIkW5BjRT63He+UoPsgh+oc4z+q/OVN0fxF2Min5
	 BLa8n2IhJM6C4HFLI+luRtDEXymvrvZXRN8honVc=
Received: from [7.249.246.159] ([124.70.231.41])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2EB9DEFE; Mon, 16 Mar 2026 11:11:43 +0800
X-QQ-mid: xmsmtpt1773630703ts7qv2pe6
Message-ID: <tencent_36163BB497CDB8AD5A2D8BD11B3DFBB80E0A@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ7hi3npMz4REqRQo9Qowqq3UaaGeKnM/fRzmaKfih/X4bJCRsrH
	 LgHSV01hyYr0j/UOPQ8XLGjEhbjPKwzM4IMkgmxoJJxWk5UlaW9nMeDF+A9nljE9QyR1CTV2jPoT
	 IG0HqQmGCS1vO/Br1byEYHIjXfH1bqO/+uXgePd6uGJXP7+ocJQ+gLHpZeh4twm1FYcfIXiynIoz
	 DZR11PApGyF2VcsI3y9rRSuE4YMC3ObpobSpbmaR201xx+I4iWimdx1uvOc9i9f4Aqj0S/aodU+4
	 gtrpqkgGE8BsuwfvJrIXP9qJtL/k+HeJtZOE4HXXej8M/HU1ZVKpUTgRUEfiIU9vAXzsElWt2sVj
	 p9dgAuqxO+WEB3AR3dticlSee8bqFWfgjmeYnIUW8yNiTyGCG6jrh38skz9tslBY8KcMK4OMjHu4
	 OjjLQa4pDJla51Y1PnDWCJU/i4gyUhPs/4Me9Vt2zeZ10Lt8VFmoMmBgXnqo3Z++se7KQefhfLvt
	 hlAcji6+4RJz9aqa0leJQrei4HUAcXWFdH46OYwRSD688oHrwYzDixwmaZWNzbv1I5XIe0V1kobZ
	 8Db8IXDbk7ACy7WjCOBQxmLSHyNBE4a8P1FCaaeUU1wX5YA/LzAxAym5c1/9fLVIYx2WYL7FaVik
	 EOKPam2V/gPBdl0nHCoJLELmGCh+K2DCJq5QLBWQdRkGSxclKAMh4GLFKu3P76FqKj9Qdml/4KI4
	 xJCnEuI2WHnAHmm689wGeWfOJJMSrK6srhuUjDJlrSH2NyTzZ/hkVIsLp3q0MZrcUyIGqfk5R6u6
	 v7Vx1G+qoU4OrngAjfQachUzQkuvVEqre/H0z/diIXxol9zDMJhSHhPxl4JxO1D47H9UTDGuSjHi
	 VIERTm+0IRLtBvnzYc6DQV41xbUR4y0hum6IbxvSFOhlUSOZtG8vK+hQhNnHZyhvCn6CxJ0tqDJp
	 qttGfs1svmvWXSS3PhHG4WzJCMpRRaQBxavVJxnhKJBWyMzME3KOwT5UNsBlO+/5fpmBydwoSoBe
	 Wc7TlZCvWOem2zsI52+VHY4MVQU39E7w4ow7kKLQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Content-Type: multipart/alternative;
 boundary="------------8vNwlNTjGYs30NuKb3s2cP3A"
X-OQ-MSGID: <f5a31318-79fb-4684-8e21-5a7746ce23f4@foxmail.com>
Date: Mon, 16 Mar 2026 11:11:43 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: validate algorithm for encoded
 extents
To: Utkal Singh <singhutkal015@gmail.com>, hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org
References: <20260315072806.17504-1-singhutkal015@gmail.com>
 <20260315142249.4333-1-singhutkal015@gmail.com>
Content-Language: en-US
From: Yifan Zhao <yifan.yfzhao@foxmail.com>
In-Reply-To: <20260315142249.4333-1-singhutkal015@gmail.com>
X-Spam-Flag: YES
X-Spam-Status: Yes, score=5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [162.62.58.211 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
	*      [162.62.58.211 listed in wl.mailspike.net]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [yifan.yfzhao(at)foxmail.com]
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
	*  1.6 FORGED_MUA_MOZILLA Forged mail pretending to be from Mozilla
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.80 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yifan.yfzhao@foxmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2715-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yifan.yfzhao@foxmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_MUA_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_SPAM(0.00)[0.981];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 04E00294792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------8vNwlNTjGYs30NuKb3s2cP3A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Utkal Singh,
Thank you for your contributions and the recent fixes.
To help us manage the review process more effectively and avoid 
confusion with duplicate emails,
could you please consolidate these random fixes into a *single patch 
series with a cover letter*in the future?
This allows us to track the entire set of changes in one thread.
Additionally, please follow these conventions for follow-ups:

 1. *Versioning:*If you modify a patch based on review feedback, please
    increment the version prefix (e.g., v2, v3) in the subject line.
 2. *Resends:*If you are simply resending a patch without changes (e.g.,
    to bump it), please add a *RESEND*prefix to the subject line instead
    of treating it as a new version.

This will greatly help in tracking which patches need to be merged.
Regarding backporting patches to the kernel, please refer to commit 
ee2709 in the erofs-utils repository for the preferred commit message 
format.
Specifically, please use square brackets [] to describe any 
modifications you made to the source kernel commit during the backport 
process.
[ Gao may follow up with additional workflow details if needed. ]
Thanks again for your help.

Yifan Zhao


On 3/15/2026 10:22 PM, Utkal Singh wrote:
> Encoded extents use fmt field as algorithm index without checking
> available_compr_algs bitmask. The non-encoded path already has this
> check but the encoded extent path in z_erofs_map_blocks_ext() was
> missing equivalent validation.
>
> Add available_compr_algs consistency check for encoded extents,
> following kernel commit 131897c65e2b.
>
> Signed-off-by: Utkal Singh<singhutkal015@gmail.com>
> ---
>   lib/zmap.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 0e7af4e..a8d1ca6 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -630,8 +630,17 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
>   			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
>   				map->m_flags |= EROFS_MAP_PARTIAL_REF;
>   			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
> -			if (fmt)
> -				map->m_algorithmformat = fmt - 1;
> +			if (fmt) {
> +				unsigned int afmt = fmt - 1;
> +
> +				if (afmt >= Z_EROFS_COMPRESSION_MAX ||
> +				    !(sbi->available_compr_algs & (1 << afmt))) {
> +					erofs_err("unknown algorithm %u for encoded extent, nid %llu",
> +						  afmt, vi->nid | 0ULL);
> +					return -EOPNOTSUPP;
> +				}
> +				map->m_algorithmformat = afmt;
> +			}
>   			else if (interlaced && !((map->m_pa | map->m_plen) & bmask))
>   				map->m_algorithmformat =
>   					Z_EROFS_COMPRESSION_INTERLACED;
--------------8vNwlNTjGYs30NuKb3s2cP3A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Hi Utkal Singh,</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">
</span></div>
    <div class="qwen-markdown-space"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Thank you for your contributions and the recent fixes.</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">
</span></div>
    <div class="qwen-markdown-space"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">To help us manage the review process more effectively and avoid confusion with duplicate emails,</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">could you please consolidate these random fixes into a </span><strong
    class="qwen-markdown-strong"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); font-weight: 600;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">single patch series with a cover letter</span></strong><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);"> in the future?</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">This allows us to track the entire set of changes in one thread.</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">
</span></div>
    <div class="qwen-markdown-space"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Additionally, please follow these conventions for follow-ups:</span></div>
    <ol class="qwen-markdown-list" start="1" dir="auto"
style="margin: 1rem 0px; padding: 0px 0px 0px 1.625em; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><li
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); unicode-bidi: plaintext;"><strong
    class="qwen-markdown-strong"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); font-weight: 600;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Versioning:</span></strong><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);"> If you modify a patch based on review feedback, please increment the version prefix (e.g., v2, v3) in the subject line.</span></li><li
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); unicode-bidi: plaintext;"><strong
    class="qwen-markdown-strong"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); font-weight: 600;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Resends:</span></strong><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);"> If you are simply resending a patch without changes (e.g., to bump it), please add a </span><strong
    class="qwen-markdown-strong"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); font-weight: 600;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">RESEND</span></strong><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);"> prefix to the subject line instead of treating it as a new version.</span></li></ol>
    <div class="qwen-markdown-space"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">This will greatly help in tracking which patches need to be merged.</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">
</span></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Regarding backporting patches to the kernel, please refer to commit ee2709 in the erofs-utils repository for the preferred commit message format.</div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Specifically, please use square brackets [] to describe any modifications you made to the source kernel commit during the backport process.</div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">[ Gao may follow up with additional workflow details if needed. ]</div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">
</span></div>
    <div class="qwen-markdown-space"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="qwen-markdown-paragraph"
style="margin: 1rem 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227); color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
    class="qwen-markdown-text"
style="margin: 0px; padding: 0px; box-sizing: border-box; border-width: 0px; border-style: solid; border-color: rgb(227, 227, 227);">Thanks again for your help.</span></div>
    <p>Yifan Zhao</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/15/2026 10:22 PM, Utkal Singh
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260315142249.4333-1-singhutkal015@gmail.com">
      <pre wrap="" class="moz-quote-pre">Encoded extents use fmt field as algorithm index without checking
available_compr_algs bitmask. The non-encoded path already has this
check but the encoded extent path in z_erofs_map_blocks_ext() was
missing equivalent validation.

Add available_compr_algs consistency check for encoded extents,
following kernel commit 131897c65e2b.

Signed-off-by: Utkal Singh <a class="moz-txt-link-rfc2396E" href="mailto:singhutkal015@gmail.com">&lt;singhutkal015@gmail.com&gt;</a>
---
 lib/zmap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e..a8d1ca6 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -630,8 +630,17 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 			if (map-&gt;m_plen &amp; Z_EROFS_EXTENT_PLEN_PARTIAL)
 				map-&gt;m_flags |= EROFS_MAP_PARTIAL_REF;
 			map-&gt;m_plen &amp;= Z_EROFS_EXTENT_PLEN_MASK;
-			if (fmt)
-				map-&gt;m_algorithmformat = fmt - 1;
+			if (fmt) {
+				unsigned int afmt = fmt - 1;
+
+				if (afmt &gt;= Z_EROFS_COMPRESSION_MAX ||
+				    !(sbi-&gt;available_compr_algs &amp; (1 &lt;&lt; afmt))) {
+					erofs_err("unknown algorithm %u for encoded extent, nid %llu",
+						  afmt, vi-&gt;nid | 0ULL);
+					return -EOPNOTSUPP;
+				}
+				map-&gt;m_algorithmformat = afmt;
+			}
 			else if (interlaced &amp;&amp; !((map-&gt;m_pa | map-&gt;m_plen) &amp; bmask))
 				map-&gt;m_algorithmformat =
 					Z_EROFS_COMPRESSION_INTERLACED;
</pre>
    </blockquote>
  </body>
</html>

--------------8vNwlNTjGYs30NuKb3s2cP3A--


