Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C459697660C
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 11:50:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4CP74Q2mz2yVv
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 19:50:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726134648;
	cv=none; b=TT8TQ/d9zQ4LVwdDdKUGWxELBabVIPex57FnKJ2ey5Vw70wL9kzdV+deUwk0Z1Xg9eFkI723zUD/U4R/oqIAXBz9zI/rL0k5ZEJKDYkwmXs6OxBZhzWDkTUXUyd6b49ucqZx3m5uigJZC5iXFdiTTnsnhMYavXhANtx9Ev97uFYvztI7XS9h7EuZRYYpZwvMO9ZEbzIn59gBBXO5OCduoQo4skCVSESVlOj+gRrwtYwCFivISqjzea2jsEYXci9GzTA0J3Cwo6fJVmucsA61pK/jG0gdystMSarWET0gSFpPiIe19VERslwq32DxpklW9ftvMiSTbtntZVJZotoM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726134648; c=relaxed/relaxed;
	bh=6DbEJrJtDiqqTKEcdu95OTnj0uf8LZS3nF22MDAN8nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VU8rmzmaZqy3Sa9ppaMYgyfc6l2r/o2B14bdqLr/gb8AbMBRYa6a8Or16wTh/cJY1ZbsNEaqHnlj8OVNDhWKc2EiOwsmFDDSp6uu9RQZ5QulWzdi10Y91Z1Km4Gm3wj069reHPL6NGE3LzzlcIh4b0OwKvGCin8GRjkVXdIJdUmQaXIVhBpcCtJWaOMcmKRCEdrqXt1t/xsO4pXdGzoH6SZ/TxP7cJ9Vm5xZUMp5hrt+/MRm3S21Bqm4va/v4Zw5Wo8N3LfKL7A9bjj9vkHKuGayFxbt5wQPFNXTF1/z9P0tiLrE3rYGXOpso79ZjyMlJzgRquQTa4Tg8a1au5T9+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IZcq2kCn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IZcq2kCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4CP31mcDz2xpx
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 19:50:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726134640; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6DbEJrJtDiqqTKEcdu95OTnj0uf8LZS3nF22MDAN8nQ=;
	b=IZcq2kCnDdvct8BMCVt2NmwA6K2nDE/+SurVKdpWWXzbhqlJWudQBEXe6dLZIBTIaBKR7YmuF2OHxKDBF10OlmWmW9tOhiO9mKt4aShBaLHWPJ+MWQ4gZ4JH4c8vSjn3y4U1W9upqCXJEOhKGxfl/UobpDPGFOBu1ho5B4hoN8M=
Received: from 30.221.130.230(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEr-uOe_1726134638)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 17:50:39 +0800
Message-ID: <1a8bf68a-8712-4428-9724-5c4fae46623f@linux.alibaba.com>
Date: Thu, 12 Sep 2024 17:50:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] erofs-utils: lib: expose erofs_match_prefix()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240906095853.3167228-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240906095853.3167228-1-hongzhen@linux.alibaba.com>
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



On 2024/9/6 17:58, Hongzhen Luo wrote:
> Prepare for the feature of exporting extended attributes for
> `fsck.erofs`.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Expose erofs_match_prefix() directly instead of introducing another helper function.
> v1: https://lore.kernel.org/all/20240906083849.3090392-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/xattr.h |  3 +++
>   lib/xattr.c           | 11 ++++++-----
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 7643611..e89172e 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -61,6 +61,9 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode);
>   int erofs_set_origin_xattr(struct erofs_inode *inode);
>   int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
>   
> +bool erofs_match_prefix(const char *key, unsigned int *index,
> +			unsigned int *len);

better to add `xattr` in the function name too,

erofs_xattr_prefix_matches?

Thanks,
Gao Xiang
