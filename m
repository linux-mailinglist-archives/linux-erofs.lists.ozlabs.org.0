Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5DFA2BDE7
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 09:29:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq6bQ31L9z30VF
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 19:29:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738916993;
	cv=none; b=kl8dpTHqFaQ2rd0XJQxfH7DzHRLDpoTDtw6GJxWALgERGwaqW+GTwER24pHNg44gx2jBcWcUi71BeMihLIt6lRKgaIVQMOYoj1B2TpxPIVFipAsb4X6cDdXsDptB7z1BA6u/JmibVi4FRFjW855vUYIvlGfinp0DE6JMI2j3eSWkRiz3OkEdSsjIBqPAbevH63SVLr6H2Xqokkuai+B4yy+Gjm0D7KUpYhtn61Ktzgk5AtLgLRikA+ZZwNsGkKQjWiJOV0YPsEic8iVKjPVloHzC1KVqt5LqJqoJdgIM41OUbhSMlkWR36eo7EDiw+JsVr4IKuIAWXuYpahxn58VmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738916993; c=relaxed/relaxed;
	bh=+jh2igr9cD/8DYXSIO6GjGLquskOAstJHjX1kJ7AduE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ3mF0HWRI4mveZMBVdK51mofCmqBko7vnuSe0GNVV/V2LMBKWhlvJPCRdRww/9lGPyChLOjN5SiVZvrX8mooEBZhP0BFjKaylJc0RvkGfdzAFqNOYBUBOrEO7saoxXX4ICKPxq3XK/flUEiwIhn8K5d7xsDh1GlZVmAZQAAbOsqxhFVXmz9UXjq+m1joukeIt/NtxHkU4ETDxBKW+RW3N01mHgV4SCgUOVhlklVkn9lbOikdECLgU787MuhVeKDDM2D/HSK539Lb7e7kb6seDsHjKKUI9BaK84UX4PEcGeH6jhGDJYQ3Iry4yuOuAdDM4a0qxbB6xXgkSAUYZtHYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xEzmipLV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xEzmipLV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq6bM4kNRz30Pn
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 19:29:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738916986; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+jh2igr9cD/8DYXSIO6GjGLquskOAstJHjX1kJ7AduE=;
	b=xEzmipLVCNb+3Kxtfd9bepjKfIo6gtqdrodcR/yJYpiJZUxwleVU8fQk7mdhgMJdzbtYeXYWd9biQDRnaXiFtl97Mk92dcAH/M34rj9Vv0Kj6ns468n4hDJ4HuqvSdmiEHEM1KSst4NwjoxScOWyf9pS/NWLaVDwvH4Y6z7vwic=
Received: from 30.74.129.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOymIew_1738916985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 16:29:45 +0800
Message-ID: <f4319592-df8f-4468-b8fb-7fcbc51804c6@linux.alibaba.com>
Date: Fri, 7 Feb 2025 16:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250207080829.2405528-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250207080829.2405528-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/7 16:08, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> Changes since v1: Put the exception branch at the beginning.
> 
> v1: https://lore.kernel.org/all/20250207064135.2249529-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/zmap.c | 65 +++++++++++++++++++++----------------------------
>   1 file changed, 28 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 689437e99a5a..f65c76991e02 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -265,23 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		switch (m->type) {
> -		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> +		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
>   				goto err_bogus;
>   			continue;
> -		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {


Just `} else {` here?

>   			m->headtype = m->type;
>   			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   			return 0;
> -		default:
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
>   		}
>   	}
>   err_bogus:
> @@ -329,35 +328,31 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	DBG_BUGON(lcn == initial_lcn &&
>   		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>   
> -	switch (m->type) {
> -	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}

No, I don't think it's equivalent, please use
the previous version for this part instead.

Thanks,
Gao Xiang
