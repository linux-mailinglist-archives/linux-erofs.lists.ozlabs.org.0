Return-Path: <linux-erofs+bounces-2648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N+/K+sdsWmOqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 08:46:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBE25E272
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 08:46:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW2rK5LYbz3dWg;
	Wed, 11 Mar 2026 18:46:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773215201;
	cv=none; b=a3uHGNFvLfSdAmWGYBUYVWrAlmbmZQKFe+aLfLKutEj2wznKKGtAftpoLs8aLOs4pPOzdD+jAsAiFrrm+BTy3YrtCKe2JCbru/iuulcQV6zenZvRiq3/QTzpqwBYddbw7T3k9S8BwXv+rSw575e2N35MDmMuE07kbJIUEXlQrVx/kLRj25JLGILNLG3PngeM2QpjX6wg+tMob9yaxCbF+VRftYCEYCc87Z8z+Tz+Xj/I/IcmUgJBsupsnkakShfoUWhCL81tntNYbB2PFrhTt/y/P87yuNE8Ltm/LwShTFS9jv9GilI0uaY1f4aCUcRg5F3diNTZeBP3SARLK3/osg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773215201; c=relaxed/relaxed;
	bh=fnKQLhya/8/ol29Ip/Cv2iq/b5XNSoCSvQJ1PLNKo/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqbG8jp+dAWMmNADoTmICArmEU38Y48MT3DJtkOeRcA3e2Ud5GyXa7flYY1JLLzaBhqXSfxIWqKCVcgxw0pt+dyJRq4bRGwt2q8ktOfIiC+HBBB0MK2aUZsGUcZS57eqzSY4i3xWXDmsuzaJJjwf6YBmc+i2GDdva9DYfkShYpCDXvK3PkJsFY7hbivqqzvE/JzYomKmObFIX+WLyYwYnCwsLtbsA0ziX9ia+1EFcCFFrhAnQxqJvTzfGvibZnfMYmYOWTpNT3UGE67WhLgWKiONS2AwNQx3wN8Wuv5NcXtHpCMqpJS56hhrXsG4UEd8dZ0FmukM2L0n+4L+IKWb1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kjzb0+J0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kjzb0+J0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW2rG6Xhyz3dWZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 18:46:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773215191; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fnKQLhya/8/ol29Ip/Cv2iq/b5XNSoCSvQJ1PLNKo/Y=;
	b=Kjzb0+J0yf7SSu5oWvdvEwZG8m+tKrOYLjQpx5MAC6sWAX15M49hIXgCQjqMho+OMj6KR14SzFld8a0y+MXhqxiExpegptbCZf+1LSPDSFxCIIohl21b5qy69qlAB1puNiYXcxmnnS8oc83u+GbmuWtK8Q8GvjGGYecmNfDV5QE=
Received: from 30.221.132.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-jFtFt_1773215189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 15:46:30 +0800
Message-ID: <e6b6effb-10fe-407e-9d81-e9d439d51533@linux.alibaba.com>
Date: Wed, 11 Mar 2026 15:46:29 +0800
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
Subject: Re: [PATCH] erofs: use GFP_NOIO in endio decompression path of erofs
To: jiucheng.xu@amlogic.com, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com
References: <20260311-origin-dev-v1-1-40524ef07ff0@amlogic.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260311-origin-dev-v1-1-40524ef07ff0@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 95DBE25E272
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amlogic.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jiucheng.xu@amlogic.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2648-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,amlogic.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action

Hi Jiucheng,

On 2026/3/11 15:22, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> The endio decompression path of erofs calls vm_map_ram(). Due to


updated subject:

erofs: add GFP_NOIO in the bio completion if needed

The bio completion path in the process context (e.g. dm-verity)
will directly call into decompression rather than trigger another
workqueue context for minimal scheduling latencies, which can
then call vm_map_ram() with GFP_KERNEL.

Due to insufficient memory, ...

> insufficient memory, this function may generate memory swapping I/O,
> which can cause submit_bio_wait to deadlock in some scenarios.
> 
> Trimmed down the call stack, as follows:
> 
> f2fs_submit_read_io
>    submit_bio                      //bio_list is initialized.
>      mmc_blk_mq_recovery
>        z_erofs_endio
>          vm_map_ram
>            __pte_alloc_kernel
>              __alloc_pages_direct_reclaim
>                shrink_folio_list
>                  __swap_writepage
>                    submit_bio_wait  //bio_list is non-NULL, hang!!!
> 
> Use memalloc_noio_{save,restore}() to wrap up this path.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

You can send a v2 to refine the subject and commit message.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 3977e42b9516861bf3d59c072b6b8aaa6898dd8a..fe8121df9ef2f2404fc6e3f0fbbd6367f9ec2c67 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1445,6 +1445,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   				       int bios)
>   {
>   	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> +	int gfp_flag;
>   
>   	/* wake up the caller thread for sync decompression */
>   	if (io->sync) {
> @@ -1477,7 +1478,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
>   		return;
>   	}
> +	gfp_flag = memalloc_noio_save();
>   	z_erofs_decompressqueue_work(&io->u.work);
> +	memalloc_noio_restore(gfp_flag);
>   }
>   
>   static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
> 
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260311-origin-dev-1c9665798204
> 
> Best regards,


