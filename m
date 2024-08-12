Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5994E4CF
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 04:24:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iJosMqRH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WhyyW2hh0z2yGC
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 12:24:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iJosMqRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WhyyM3l04z2xcX
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Aug 2024 12:24:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723429460; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Un8kXF6IO1yPVyVA660uF1NYm9WM72awzCcULQKGTa4=;
	b=iJosMqRHgZlZlLJn1AnYsH2O8Hwh/nfO02VVSD0tYllD1GgSyW5jZbXxKRfKBVot3C51OG3OypDeTwjXAJWHz4TEIfm8tMVRVsqdYAMkOP3UWkO4k8sNpantkux3z5kk3suXurDydXO970p+ghJOs/GpJXP4U7Pdw2QOgMSsFrI=
Received: from 30.97.48.226(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCWZWbj_1723429458)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 10:24:19 +0800
Message-ID: <561ee8da-92b8-424f-ba28-bbd5614d77b7@linux.alibaba.com>
Date: Mon, 12 Aug 2024 10:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: add support for symlink file in
 erofs_ilookup()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/11 16:09, Hongzhen Luo wrote:
> When the `path` contains symbolic links, erofs_ilookup() does not
> function properly. This adds support for symlink files.

Can you explain what's the use cases of this patch?

It seems both erofsfuse and fsck.erofs --extract don't need this.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   lib/namei.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/namei.c b/lib/namei.c
> index 6f35ee6..dce2991 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -195,6 +195,22 @@ struct nameidata {
>   	unsigned int	ftype;
>   };
>   
> +static int link_path_walk(const char *name, struct nameidata *nd);
> +
> +static int step_into_link(struct nameidata *nd, struct erofs_inode *vi)
> +{
> +	char buf[EROFS_MAX_BLOCK_SIZE];
> +	int err;
> +
> +	if (vi->i_size > EROFS_MAX_BLOCK_SIZE)
> +		return -EINVAL;

No, symlink size is independent to EROFS_MAX_BLOCK_SIZE, currently
it's hard-code as 4096.

> +	memset(buf, 0, sizeof(buf));
> +	err = erofs_pread(vi, buf, vi->i_size, 0);
> +	if (err)
> +		return err;
> +	return link_path_walk(buf, nd);
> +}
> +
>   int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
>   {
>   	erofs_nid_t nid = nd->nid;
> @@ -233,6 +249,11 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
>   			return PTR_ERR(de);
>   
>   		if (de) {
> +			vi.nid = de->nid;
> +			ret = erofs_read_inode_from_disk(&vi);
> +			if (S_ISLNK(vi.i_mode)) {
> +				return step_into_link(nd, &vi);
> +			}

Why need brace here?

Thanks,
Gao Xiang
