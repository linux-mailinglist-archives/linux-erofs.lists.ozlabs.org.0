Return-Path: <linux-erofs+bounces-1554-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92924CD86F8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:15:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db79B6Qvmz2xlP;
	Tue, 23 Dec 2025 19:15:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766477710;
	cv=none; b=jfphbBj3saww2XUL65hvb7KExxGo2NwFqqGt7XSUvOPFaYMeEAE3rB6fupY5FrtydyxtCGAQ9k8D4mQ36yfI0rRTTsv49vMwFh7K6BEXxKCoOUIFPgnxVVYrdInoKVXayOq14nDDvxXdm4zbrI/8jdMmElo2lg2FPvXpOQly6M+A67SHUzbr3wswJOg5yfnbthufwgQDKssO/AosaIndPGpjtDnw4bhQoKE3wnePNbEIixCvYnfpPFdIHJP2Qw62OzDhl4KBqAHv2BjTuda+x8E8XgsSpzhZXXP7QY9kyHEopVtenc44tz3xw7GoT66OE7tCg+A+YVvKmeAo5WtcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766477710; c=relaxed/relaxed;
	bh=qXzXWlXtDDYuzgJZTzlBLMtvlbga2E3nmwouUdjB7FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wnt92DBehFAlplh/FoB1FRLOum0DPEgdys7E4v/6uqe9vNHlmyxFEzePQRa+B4kxnD1L5VxaWVWpJnYDWZ2Fr21YrJBkA42kf6H+IRLnn5xo37og5l97E689wSNvJOuFRvOttFnmOJN/ObN2lt5QaQSjiqhxd9NxtzzfFbnv2QfBU8A25pSRvp13PTo2/uPW5LJZ+390DCO7kbrk3QIgRZT6eN9xYzSyaFeg12psNH0Cpyau6YLtnpDKEJuMBunNRAY36wPzbZC6gjULSnKcqNhlL+0bOi5TKtx5F2aFYn+AB0EtQIxPHR6jNfjMy4w7lHf7auBQcigKSQIkDfa8Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SbqdL+H7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SbqdL+H7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7994HnHz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:15:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766477703; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qXzXWlXtDDYuzgJZTzlBLMtvlbga2E3nmwouUdjB7FU=;
	b=SbqdL+H7QW3Wx20ucLx3mGpnIGy63sCBDsiFVVY/B8D08vtE3S99hYJ0MktcytGnKQbRGg+UVPO2M8V/BmPyObAWYKejt1WUPmYmeFbmG+xxBybi95aft02Wkb42bxJ5WPuZbj8faluwRsFPy5Emd5hx70nicc2j+wHGzvmU2Vk=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX.dH6_1766477702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:15:02 +0800
Message-ID: <b2bb83da-8b76-40eb-b563-a0aa9c5436dc@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:15:01 +0800
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
Subject: Re: [PATCH v10 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---

...

> index 4b46016bcd03..269b53b3ed79 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -197,6 +197,37 @@ const struct file_operations erofs_ishare_fops = {
>   	.splice_read	= filemap_splice_read,
>   };
>   
> +/*
> + * erofs_ishare_iget - find the backing inode.
> + */
> +struct inode *erofs_ishare_iget(struct inode *inode)

Just:

struct inode *erofs_get_real_inode(struct inode *inode)

`ishare_` prefix seems useless here.

> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +	struct inode *realinode;
> +
> +	if (!erofs_is_ishare_inode(inode))
> +		return igrab(inode);
> +
> +	vi_dedup = EROFS_I(inode);
> +	spin_lock(&vi_dedup->lock);
> +	/* fall back to all backing inodes */
> +	DBG_BUGON(list_empty(&vi_dedup->backing_head));
> +	list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
> +		realinode = igrab(&vi->vfs_inode);
> +		if (realinode)
> +			break;
> +	}
> +	spin_unlock(&vi_dedup->lock);
> +
> +	DBG_BUGON(!realinode);
> +	return realinode;
> +}
> +
> +void erofs_ishare_iput(struct inode *realinode)

Just:

erofs_put_real_inode().

Thanks,
Gao Xiang

