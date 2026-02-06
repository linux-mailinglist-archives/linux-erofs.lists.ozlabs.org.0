Return-Path: <linux-erofs+bounces-2267-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DXWLDSUhWm3DgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2267-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 08:11:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D675AFADE1
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 08:11:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6ldB26B8z2yFc;
	Fri, 06 Feb 2026 18:11:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770361902;
	cv=none; b=I1sOGBGvuPBm0mggcQFrb1RZ3EMlyyWjAelkDMqnazJF5PZ+BXuJAE6PwX4i+woQr4NHciH6sLrB1DRpo+IGRdx+6vnBwYju2ZjUFr2SQmh39xftdGgVptPjmKeLEtvQvv0xCOJruzj1HwyAW1O+bkLWW2ilcjEYj+Ls2fv/279xxeRSpZdsnsdw2Mqakq1CDmWGnev4wbaKPWh+zD0waisfpHeeEkrqMiuwt1JboZk649FMyTTWyY4iGAlWXkjhdfRt/BYldUup1RyexTTi30FIxnhfgALBJVrUR7gtr3v+JAdgz1iD5QgycBTXYhzJwmUYK3crpvmXrAT9pseXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770361902; c=relaxed/relaxed;
	bh=73E12KM7OPacSNBdFgE+X8jRF2V44mwSSiTiiiemsUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjL+9MzIdAfbsMaKZRR+O0fBXZc6WfenmqVjKIsot2FNWxbvWanDdPpGYbofb8F5tcJFWRYdA/y9A9ysDxhFCrYr7+sFj/+0ROCFPFX2jBDT5+YNkd6rfId3VMX4ZtkCqhtE6BAJ2akR6FfqOzKfF5G6l1IieuVxKmn4Jp1J2ToheWdH98nuuOrSZalrHAH4xzU8dQ3N+rTg4iYqsfN64Q2Vr1l6D1MOYBNIglpoS+9tzcuLf5jjFKBvp4eWP1GuFUqbo1NMIQMrXQ/v3HPhY5clQ9YeAnUGmuPLTel6zzDm5sZ4u/ERFRCsN422k3rSCIXea8Dfbvg96h5BqNIsCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VfUIDzK8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VfUIDzK8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6ld63fTlz2xqk
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Feb 2026 18:11:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770361890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=73E12KM7OPacSNBdFgE+X8jRF2V44mwSSiTiiiemsUQ=;
	b=VfUIDzK81ft7hvmW9ROyxDcZOxPv5VyE8L6UY2vNqsh7SWbyQdr3DDNkRo37FgTqEP7F4Rg6gyqPa7/gVIwMvqBXaqvIkk10x1gQBYcnL3OAxnoC28X4m3NYlhoSytk5mM+nHp1MToKeKf4lmS1lAGxCQ2jLZ+UMFDKMf8dEGq4=
Received: from 30.221.130.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WydhgzM_1770361887 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 15:11:28 +0800
Message-ID: <9d70646b-ddf8-42b5-8015-fb54a6f24296@linux.alibaba.com>
Date: Fri, 6 Feb 2026 15:11:27 +0800
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
Subject: Re: [PATCH] erofs: fix UAF issue in erofs_fileio_rq_submit()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20260205223005.72727-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260205223005.72727-1-chao@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2267-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D675AFADE1
X-Rspamd-Action: no action

Hi Chao,

On 2026/2/6 06:30, Chao Yu wrote:
> [    9.269940][ T3222] Call trace:
> [    9.269948][ T3222]  ext4_file_read_iter+0xac/0x108
> [    9.269979][ T3222]  vfs_iocb_iter_read+0xac/0x198
> [    9.269993][ T3222]  erofs_fileio_rq_submit+0x12c/0x180
> [    9.270008][ T3222]  erofs_fileio_submit_bio+0x14/0x24
> [    9.270030][ T3222]  z_erofs_runqueue+0x834/0x8ac
> [    9.270054][ T3222]  z_erofs_read_folio+0x120/0x220
> [    9.270083][ T3222]  filemap_read_folio+0x60/0x120
> [    9.270102][ T3222]  filemap_fault+0xcac/0x1060
> [    9.270119][ T3222]  do_pte_missing+0x2d8/0x1554
> [    9.270131][ T3222]  handle_mm_fault+0x5ec/0x70c
> [    9.270142][ T3222]  do_page_fault+0x178/0x88c
> [    9.270167][ T3222]  do_translation_fault+0x38/0x54
> [    9.270183][ T3222]  do_mem_abort+0x54/0xac
> [    9.270208][ T3222]  el0_da+0x44/0x7c
> [    9.270227][ T3222]  el0t_64_sync_handler+0x5c/0xf4
> [    9.270253][ T3222]  el0t_64_sync+0x1bc/0x1c0
> 
> erofs may encounter above panic when enabling file-backed mount w/ directio
> mount option, the root cause is it may suffer UAF in below race condition:
> 
> - z_erofs_read_folio                          wq s_dio_done_wq
>   - z_erofs_runqueue
>    - erofs_fileio_submit_bio
>     - erofs_fileio_rq_submit
>      - vfs_iocb_iter_read
>       - ext4_file_read_iter
>        - ext4_dio_read_iter
>         - iomap_dio_rw
>         : bio was submitted and return -EIOCBQUEUED
>                                                - dio_aio_complete_work
>                                                 - dio_complete
>                                                  - dio->iocb->ki_complete (erofs_fileio_ki_complete())
>                                                   - kfree(rq)
>                                                   : it frees iocb, iocb.ki_filp can be UAF in file_accessed().
>         - file_accessed
>         : access NULL file point
> 
> Introduce a reference count in struct erofs_fileio_rq, and initialize it
> as two, both erofs_fileio_ki_complete() and erofs_fileio_rq_submit() will
> decrease reference count, the last one decreasing the reference count
> to zero will free rq.
> 
> Cc: stable@kernel.org
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks for catching this:

I will update the subject as
"erofs: fix UAF issue for file-backed mounts w/ directio"

to make it more clear about the impacts.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

