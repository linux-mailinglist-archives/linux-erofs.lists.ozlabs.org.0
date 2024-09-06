Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4E96EE87
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 10:49:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0VKW3WLZz306J
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:49:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725612589;
	cv=none; b=GAf/+Yoj80EBTqAMefnuqfNe53tL2Qjxw1S9hTDq3b98VIqjV4zuD5dwC4Y+hJ56zJFw4mvSn+opDtGeNL0emnhBzdIQ+LeznxbWONq4oOcJZiXz9qWR+s5zgsD70TqAeXoZCtXBRqnkgOuSCP02E137nTA4+YH9og4lFDO30pj++1xMcCU0xuiuTpIA75m5KMqm7h85LXT8JqOt1gvHqXi1qV5WsjSM0q2jrWaVEjHTVabc6/qqPG3DGpU/G6OzqukYUQEfpX3KZ3c1+wu3PNc8Prk8cqpiG0OpHw0Qgu+6DAZtF1/yvXk2AEX9Qt4HL14DuiOvCzrAv8nvSzImBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725612589; c=relaxed/relaxed;
	bh=d23KncXB7zzqCiK/DcTizkOITEs6QDz2E3J54n6eBDI=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=FepmHGngBJ5a+PYxSVrJCPZspp7dmY91BQ3TRzJFu+g1p/HxEu/hKLdvuyAtYyjQ0cMSGcNzu+wqmtvqEFOBSP5l10xm00JZlzLpwJ14UPV7V54sa1jTfBlbLtCWXJY5sdncR90l8S9dd3qh9T0y3BAP6JsA71aEKuEWkFk1o+Inp27IyVYcjv4U/lUSP/tVOVGRakXBDVCCpd6sREEcaDUG+r9XqXUnqp4dYQfeuzU7WbX6DR/1X92W8FMTpUAWL1trAzYSV837Gyc2/1NAmlB4PveX8mtBtJk7AZDi20/dk0dd2nqqemqS2r4sMRL2iSojZp9AI3+A2UV13Ot7Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FwUUbAGa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FwUUbAGa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0VKR6tMFz301n
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 18:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725612581; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d23KncXB7zzqCiK/DcTizkOITEs6QDz2E3J54n6eBDI=;
	b=FwUUbAGaHyK/mn5s8l1F+FaYEIwCcOE6Txh+bCB6kiMWwWYK99xKD73OISnL7n66IVjB+jSf10nIE3wQVxf9038VdEj2/MjYIRPVQdg0mK0bxjY8xkqh3b9VqHY9VIoyHYMIA3x485S0k3DOy9tkMSZ1Au9AYhkhHxwZY7jtbdM=
Received: from 30.221.130.77(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEOvp2s_1725612580)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:49:40 +0800
Message-ID: <b0f6bfaf-89ba-4dea-974a-69d2990aaf69@linux.alibaba.com>
Date: Fri, 6 Sep 2024 16:49:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] erofs-utils: lib: introduce
 erofs_xattr_prefix_index()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
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



On 2024/9/6 16:38, Hongzhen Luo wrote:
> Prepare for the feature of exporting extended attributes for
> `fsck.erofs`, which requires obtaining the index based on the
> name of the extended attribute.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   include/erofs/xattr.h | 2 ++
>   lib/xattr.c           | 7 +++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 7643611..7848fe7 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -61,6 +61,8 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode);
>   int erofs_set_origin_xattr(struct erofs_inode *inode);
>   int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
>   
> +int erofs_xattr_prefix_index(const char *key);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 9f31f2d..1fed7c0 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1681,3 +1681,10 @@ out:
>   		erofs_xattr_prefixes_cleanup(sbi);
>   	return ret;
>   }
> +
> +int erofs_xattr_prefix_index(const char *key)
> +{
> +	unsigned int index, len;
> +
> +	return match_prefix(key, &index, &len) ? index : -EINVAL;

Can we export match_prefix as erofs_xattr_match_prefix()
directly?

Thanks,
Gao Xiang

> +}

