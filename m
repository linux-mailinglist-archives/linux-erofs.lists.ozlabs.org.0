Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19777A37E64
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 10:26:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxHNQ41Ztz30TK
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 20:26:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739784405;
	cv=none; b=MiUJy8e7fZxbx53sJqCXL430ZvlcOt/Z5lNmmQxRIbMsBn2Ps0HAMKMm4uCezW5xQRlnKhvj6kipcAZJddzh0y4+WokhziA+sQB0GrouqTdSkRauKTmpBa7xtzCu2gD0khspJI4fD/KJPF8Do4N8WPAAx7FDCRueMAh0BWiYIqpNbfLEeiO8XQejDW6UcOV6zP6X7w+U2NmlBRKGYnyZX8V/XiTa/kIYPrRY1vwzQpg4hrjvG6fJhMlgsuhokpAJUZPdYPO0HNy0XNDXRM86+gdMxxYX+3e5JWmEhxhZ6py8pJDJKYrUzA6BfUVej2fAuuUsqvysRatz+UVh4XRp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739784405; c=relaxed/relaxed;
	bh=yChr421fU7wu4+Vnk0ShZQOwDDDdkVp+OBbAuZ/muuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=legNBwMEjUGHqAS86UgkYBJGOtACv1aPzX9v7OciKjZDauC4TsyMsAu3tYIfkF3ozh+hO0cW3sMUzTGSYoCwsYUfckH8Upni/N+0mZHExOBDLX/BawU314G24fYDD2Tu3iPd5BS8Qnex87paK2ocBc0/2hsiv/DSnw9zz+gNADl5SwqoSf/cOBnooF7J6A462dkyf6r36IgubD0umbJ3QE8HexnJoeYSCTobFyWqSZ+NJF9xzPaj0MaXaoEg1wuIJTAkBQL5p2jQb1ccXk03n5z15cXIyvj7H+PZ5Z9l8j/DO8i56bMaiH5JoWij2xWvkfjdu2eg4ZoESRs+O5AY5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7pXzRnn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7pXzRnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxHNM0fb9z302c
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 20:26:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739784397; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yChr421fU7wu4+Vnk0ShZQOwDDDdkVp+OBbAuZ/muuk=;
	b=n7pXzRnnN9tionCIidXbKuAHdJu4meYVT8KdsR6nuGppPslfePdtPudvedB7VlWADKZT2DLLQGRvfP4sNf+TerB2Izl6mLtfUpDbMU5LFpSLXiOoUgszihqZJof5kg/xFP424TMohh93rT5GUI2e2Wouo082wdXFRcBnch3yPuo=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPd2ARk_1739784395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 17:26:35 +0800
Message-ID: <c1da1e6c-0587-44cf-8107-4917a7a60d46@linux.alibaba.com>
Date: Mon, 17 Feb 2025 17:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
References: <20250217091044.2311-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250217091044.2311-1-liubo03@inspur.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/17 17:10, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   fs/erofs/data.c     | 16 ++++++++--------
>   fs/erofs/dir.c      |  2 +-
>   fs/erofs/fileio.c   |  2 +-
>   fs/erofs/fscache.c  |  2 +-
>   fs/erofs/inode.c    |  6 +++---
>   fs/erofs/internal.h | 10 ++--------
>   fs/erofs/namei.c    |  2 +-
>   fs/erofs/super.c    |  8 ++++----
>   fs/erofs/xattr.c    | 12 ++++++------
>   fs/erofs/zdata.c    |  4 ++--
>   fs/erofs/zmap.c     |  6 +++---
>   11 files changed, 32 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..386e312de8c0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -26,7 +26,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   }
>   
>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
> -		  enum erofs_kmap_type type)
> +				bool need_kmap)

leave in the same line?

Otherwise it looks good to me.

Thanks,
Gao Xiang
