Return-Path: <linux-erofs+bounces-381-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA43ACBEBE
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:16:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBG7v6Wtkz2yGM;
	Tue,  3 Jun 2025 13:16:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748920571;
	cv=none; b=WYtuDMvZ1d+LT+QsfBHUz8pd7Xk5X7cfLHsRdFnUJ/mhsDQfpXSHaQ8U8/0wliRs58Q8+IXQ8Nr1qpbESwOicqkrHStfI3AijdmRwMPwc9jbXWw54zDPWrzl3MZWO42VozQoyi5LTYTTMCpbfbfoVy9xxlTWTzdTr/G+EIoydH5FBJWv0UY/WCwSwm/djN36QPHnbgONLL1P+hvOPc8qxy/oREl8wNhZ7Ru89kzovngVFemRYSMRTzej4bgeEx8trDCDk10ver/MooElKTU14UfdEh+BpnAnak9Utr+D+AgbGprwBmCUa52gLaG0xBRwiYCkLkAaXgrQ2LvSNY475w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748920571; c=relaxed/relaxed;
	bh=ZY8KZhcwQZxIWOF/o1tmhJ5Jb9yGXHO3Bfvpbnmzsfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+pVDX/dYUUkfusuqBR19kDQRpkpUWtkVvbqkQtvJPxbGs43FRwQ2E1hBpaK0QvPOEqdHP9+oViN2OpJx/20nDkzv05FjJ25uCHMVw+4ODPM20BlkZeBabcBHKT3546mo8cj6LH6qdIt431HLQ6LjJJuBDnNAccrwZPejudI6SErs5NLTs8knR7Odw4wd7lW7grC0mgVwQs10wL/gqyA0lsu87EaR+kzEERvFKpjymfQK2zh/aMpY3TeGwZQo2is+5KulniKn174fZGVk36Q4s0acKk7QlpOesY5oex3IjTgeGAH2aOixe4LTxvSB9keluKHiiVBn7elKgKZIETghw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NRBzd5oD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NRBzd5oD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBG7n0jfDz2xpl
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:16:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748920559; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZY8KZhcwQZxIWOF/o1tmhJ5Jb9yGXHO3Bfvpbnmzsfo=;
	b=NRBzd5oDHKhyb7G7qng8+mZqJcIsPBCin00MdiuxTsiUAWkxbF7naD3WldkoNzHW6gVfFgPLPtvI0svqIlp6HbnqU0HJh7JkErNxwRZwgkyHAfWEiWg/hucyqEgxk1tYrhjPQ3N6hXaSUCe1VS0mp4EtNN9N3FeIGnu6H4lxvRc=
Received: from 30.221.132.35(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wch2Ke-_1748920557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:15:57 +0800
Message-ID: <8f2b9d0c-22a5-42fe-a280-b3868aa2b1d7@linux.alibaba.com>
Date: Tue, 3 Jun 2025 11:15:57 +0800
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
Subject: Re: [PATCH v3] erofs-utils: mkfs: fix image reproducibility of
 `-E(all-)fragments`
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
 <20250603030814.487212-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250603030814.487212-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/6/3 11:08, Hongbo Li wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> The timestamp of the packed inode should be fixed to the build time.
> 
> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> [hongbo: minor adjust]
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> change since v2:
>   - compare path with strcmp;
> 
> change since v1:
>   - fix time assignment (assign `i_mtime_nsec` too) [Hongbo];
> ---
>   lib/inode.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 108aa9e..46eb686 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -929,7 +929,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>   		return true;
>   	if (inode->i_nlink > USHRT_MAX)
>   		return true;
> -	if ((inode->i_mtime != inode->sbi->build_time ||
> +	if (strcmp(inode->i_srcpath, EROFS_PACKED_INODE) &&

EROFS_PACKED_INODE is a hard-coded pointer rather than
a real path name that should be compared in the string.

Otherwise, the same path name could be matched but
that is unexpected.

Thanks,
Gao Xiang

