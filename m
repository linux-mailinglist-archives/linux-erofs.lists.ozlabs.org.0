Return-Path: <linux-erofs+bounces-2732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ct7KY65t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:04:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF5295F43
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:04:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ70W3VWhz2xpn;
	Mon, 16 Mar 2026 19:04:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773648267;
	cv=none; b=ZQiCePGsW4LMhdtz4aTZ+TTVQBBBzT7xLOGce+TKhGfwOjRPXihjm2dhXTTEfgKkDIuXdzjAFokbxFx3+A4STTaPJZAp6N7TIt/I8E2x+Cq+y9mAhnDw4RCS3KONR7kQ3QN6jzA5XVzeVlJ9jIzil8Uwyw+VewqqcTEOItbLoxnnosG1RCvQJ6hhZ878sFJnfnkw24jfULrpIqqLaL0XXDceTH0+rHe9u7Z/PKa8mN+2fykJzF+wRXc50v1J0iBFBMPdDDwEN9w2ytviMb3NYVzHzbBPxjKA0+CiBp0m7FwYf3M6RAXFvu+b3D1+kgTJ7SGxJd6JBES6Rja6gpplfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773648267; c=relaxed/relaxed;
	bh=QbpepUZOAIdDkprCRlikObGh27mJdCxpv3AzkBPt72E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGyFGBfrnSKq+98dsZHpinwnzX2xXM6qA1W0JCH1Ddei3U6mf96bWgFRLtFlqCCkMgyDGQ6opBJxJ+eMM/keZVObae2JZiOZfntC8u2KgmdUqVIY9sCgpXXucUQ3Db432VugMNq7Le5Tx7Rf09GChBHvS812K0uHSXFfFmf8nBPdk253ImgKbl98XdNrXWArMMfH08a/jsSz/RDJbwVNRXclYnQPiTE12h6NAYU2uUrqZQ9OHlJXvwlOCYmURMtC6CodQKKJHaqR80agwphE3opKRl/4RRJdsIpHLbS19Yr7Pbsnx963JNU05qj7f+O9DqMFOihIWsMg0wMJvFI1Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d2nQ9xR8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d2nQ9xR8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ70V3MVLz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 19:04:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773648261; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QbpepUZOAIdDkprCRlikObGh27mJdCxpv3AzkBPt72E=;
	b=d2nQ9xR8wLwGD45KPT9BZIqgvAClwC3CyYhgYHlmU12ixA74voCeXSzphPQz9THD0uJnvXO0jSc1G2Gl2JWXXnfYwT8+YJKNufMrmOFwR2HixZQAcbdsDMg5JOw43xJW1Uv9vGlFHuoPeCYPD1+guJz24bQkZkc/cwpoYZgqV+Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.1GdNh_1773648260;
Received: from 30.221.132.167(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.1GdNh_1773648260 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Mar 2026 16:04:20 +0800
Message-ID: <48a20201-eec8-4457-91cd-f80634a2267f@linux.alibaba.com>
Date: Mon, 16 Mar 2026 16:04:19 +0800
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
Subject: Re: [PATCH v3 1/2] erofs-utils: lib/tar: skip PAX entries with empty
 path
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, yifan.yfzhao@foxmail.com
References: <20260316075831.35495-1-singhutkal015@gmail.com>
 <20260316075831.35495-2-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316075831.35495-2-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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
	TAGGED_FROM(0.00)[bounces-2732-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C0AF5295F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/16 15:58, Utkal Singh wrote:
> When a PAX extended header contains 'path=' with an empty value,
> the computed length becomes zero. The subsequent trailing-slash
> removal loop accesses eh->path[j - 1] where j is zero, resulting
> in an out-of-bounds read and undefined behavior.
> 
> Skip such entries to avoid unsafe pointer arithmetic and invalid
> filename handling.

I don't see a reproduciable way here.

> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/tar.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index 26461f8..be86984 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -510,6 +510,8 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
>   
>   			if (!strncmp(kv, "path=", sizeof("path=") - 1)) {
>   				int j = p - 1 - value;
> +				if (!j)
> +					continue;
>   				free(eh->path);
>   				eh->path = strdup(value);
>   				while (eh->path[j - 1] == '/')


