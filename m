Return-Path: <linux-erofs+bounces-296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 271FEAADBF6
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 11:57:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsrJw5hh8z2xQD;
	Wed,  7 May 2025 19:57:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746611824;
	cv=none; b=I+ecEXcbnfjS31yXpAtxoW7RIguFXChM8GYtmL90JcxIll19yVkXVZjTxrZ40b8l7sCf/AjEh8/vhdrdZQSXjvhwr/pYQIjQmeurBy+rN0sM81TSwQ2dY/wa09XsMGlVleVe1tqvtRwDkcJ5bE3hRQjLOXDZDh6PyV0uaFoe5bPSHXMxBnQasD33WwN5CoiVC/OWyS752egUJcCgB6Z02F+XdBA3hpR3z/d051CnLdChfa1sGM5y44ADL3+jhXbvvotKb8FgSd/dgu1XkJdAwfimL9ARAjyjOw5CmH59RpFs2hPmgdcs88+gjMc3Vpnn3nPAt2riPUQ0ry/xsIu3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746611824; c=relaxed/relaxed;
	bh=vc9h5zCx8Tq7zNg1xC02laTprCNdx7HKwnVno6gZ9NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWsAKjz7Da4T4oAi35RIeOj8zay5HcFOW+hZaxZj/t6OWP/UWajaovdlshff2UdCKliDyfIXouYCOHZR1e71ICRXPpIt/ttXLLC0jdG2jp9PdgfnOCsM3s3MFOrqr9be5BJ4476E2SUgPx84s8cF08RypRAKvb1/aeKvlI9Kogx3AUawhPsNnOK1x4ZsTz0/qhEfCeav7B0lBiokYLZZh3wplhhStPv/osQxKJgoVfoHtGY4fnKip8kqTXPEAYtq3d4iN6n0YEY23ZQ6zEY4a107TOYTa8xPTRVWvJm+I5UPm6cCXrZqEqgJ+THGAAhR5nO6ZrYR2NWn5tmTPpiW9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bDMfvJS/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bDMfvJS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsrJv5Kn0z2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 19:57:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746611819; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vc9h5zCx8Tq7zNg1xC02laTprCNdx7HKwnVno6gZ9NE=;
	b=bDMfvJS/1ch2mQXE2/UpIkZ7rwdrImSTrIEiqrNn5Aw5Pq5M2qTiVVi31Th5QGJHH2mYExqmpZSo29M7eRJx3QOtkMnQM6wmMBWhJg420AUahVAa1n5ZCjWz+l2nMjzsUUxKOU4G86FrhdHPwwx+Fvi/dDYtaSbrvjELRCEjMzw=
Received: from 30.221.131.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZpED0u_1746611817 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 17:56:58 +0800
Message-ID: <56196c13-954f-4185-a17b-d52e337cb4f8@linux.alibaba.com>
Date: Wed, 7 May 2025 17:56:57 +0800
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
Subject: Re: [PATCH v4] erofs: fix file handle encoding for 64-bit NIDs
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250507094015.14007-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250507094015.14007-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 17:40, Hongbo Li wrote:
> EROFS uses NID to indicate the on-disk inode offset, which can
> exceed 32 bits. However, the default encode_fh uses the ino32,
> thus it doesn't work if the image is larger than 128GiB.
> 
> Let's introduce our own helpers to encode file handles.
> 
> It's easy to reproduce:
>    1. prepare an erofs image with nid bigger than U32_MAX
>    2. mount -t erofs foo.img /mnt/erofs
>    3. set exportfs with configuration: /mnt/erofs *(rw,sync,
>       no_root_squash)
>    4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
>    5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
>       than U32_MAX.  # you will get ESTALE error.
> 
> In the case of overlayfs, the underlying filesystem's file
> handle is encoded in ovl_fb.fid, which is similar to NFS's
> case. If the NID of file is larger than U32_MAX, the overlay
> will get -ESTALE error when calls exportfs_decode_fh.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

