Return-Path: <linux-erofs+bounces-3479-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNPJD41TEGodWQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3479-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 22 May 2026 15:01:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08675B4AF5
	for <lists+linux-erofs@lfdr.de>; Fri, 22 May 2026 15:00:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMQPh0BcFz3brt;
	Fri, 22 May 2026 23:00:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779454855;
	cv=none; b=gkY0C6P/sCOCagisXOz8zIzn8ZWlZ4N8TYbIlvzxBHxB+quNm9fvflVqcTK/E+yqpSK+byuUEcJJTlrtOAhKXrICcZWkkgFBysw+t385lXcH8Mqkl1v/Xu4Dx6jw+vZ6bp/7QpX+qtjY2WAhIP2pC5Pswv4sp37W6TOFoyt0Jk8SBunTwU1p0iVwHMf1AEawQLfxHktXdPtble3L5yHE2kauVwerCsTzVk2O7/S/st0uB74zIS1VwpHm3+BQGIBicl3Jpvd53qSST1SmiLyvw2r3lKXqWXuKAR9ecmWvf/zKQYvmH99G/TdZXhIlKzwqBibEW1366ResSgpXqgdAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779454855; c=relaxed/relaxed;
	bh=OdGOR+CUQyFp0PV7PuODPQaFA4X8MLPl0TjPH8ZUT18=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RniKQPYiXwb94KFjvN43mfw6mpYT/cPWEFvJ9AcE+siHCuUyZBvpB/YU4+XKAM5BK0FQlP0jypbuazhxPzoPxT1NS0ZHOkeRqvW1/r6suC+2zbhaGkdu40N53rMLAdwFZAshpUg2PydIV5BQxNdjRDQEfPWm5wO4f6jE/Sau/O2YQBE8aPOnauH+B1Z7nmEQTYe9zWzoyZZH5MK5fR0NYU8EKjkSBrqloUL6cvpEBZkKynu64jl1FFCPXvc/smh8ydSv1BqbOvMlNgbqhRGERGJh2UpraWln67EWFFMVSffLL8KiiIgXynCqfGSR34yBJqVB1mihP9T//qlH7YS9mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORdRuBAV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORdRuBAV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMQPb2lYpz2xSN
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 23:00:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B5744080F;
	Fri, 22 May 2026 13:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DB01F000E9;
	Fri, 22 May 2026 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454849;
	bh=OdGOR+CUQyFp0PV7PuODPQaFA4X8MLPl0TjPH8ZUT18=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=ORdRuBAVydQRpL1PrvM/X5gpv3T0dRzn8dkIcm9HgZ2yuDAduWpEiXA9TRvXfVtq1
	 sJBjornr9KIB62nKrDLCj3NuILIUkXZ4wWbbMTWw5sgaJRZMNIDNrazeMdzQ+hMj7P
	 HDbaPEd5UpLc2ode4clZ5W+zlRTmMTFr7Hd7mx0G/kPXR4cC8NR5YG2dIfYnvL87S9
	 GrIrFUuUJ12mmAdobqJA6v2IgKLsF+ysSLDicwC78vABI+AoyowwirI5NTzfn8fmLE
	 Q5SShJnhhgFZQRZI4JSdwCqCLxlSSxr6EhupHFMclkxQVqnDyCf7xx5RBqPutdZg28
	 7HEfCp3ETk3pw==
Message-ID: <4fb20b32-5651-4aff-9a4f-8db5652db476@kernel.org>
Date: Fri, 22 May 2026 21:00:44 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 oliver.yang@linux.alibaba.com,
 syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com
Subject: Re: [PATCH] erofs: fix use-after-free on sbi->sync_decompress
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260522082716.3598160-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260522082716.3598160-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3479-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,52bae5c495dbe261a0bc];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,syzkaller.appspot.com:url,alibaba.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: E08675B4AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 16:27, Gao Xiang wrote:
> z_erofs_decompress_kickoff() can race with filesystem unmount, causing
> a use-after-free on sbi->sync_decompress.
> 
> When I/O completes, z_erofs_endio() calls z_erofs_decompress_kickoff()
> to queue z_erofs_decompressqueue_work() asynchronously. Then, after all
> folios are unlocked, unmount workflow can proceed and sbi will be freed
> before accessing to sbi->sync_decompress.
> 
> Thread (unmount)        I/O completion        kworker
>                          queue_work
>                                                z_erofs_decompressqueue_work
>                                                 (all folios are unlocked)
> cleanup_mnt
>   ..
>   erofs_kill_sb
>    erofs_sb_free
>     kfree(sbi)
>                          access sbi->sync_decompress  // UAF!!
> 
> Fixes: 40452ffca3c1 ("erofs: add sysfs node to control sync decompression strategy")
> Reported-by: syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=52bae5c495dbe261a0bc
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

