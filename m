Return-Path: <linux-erofs+bounces-1381-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4245C6232D
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 04:06:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8t1h3by1z2yFy;
	Mon, 17 Nov 2025 14:06:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763348792;
	cv=none; b=knOm8NKoLoqqKNRb7u/u6FXjMo3DfZwdDYqIbDXhUVJNzTwj7J2kS9axWhk9nlrn43K3UkWjJnJtZG9wykgpRaUtdqAf54FCY74aLKTIs2iQs/G4r0cfvYcjOpxVR5SRIaGGWGmbFlBWpoPKXjBZbKqpcI7YOK+zYKLdx+2TMaoJXBrXDYVK2zghNfNOHa7ydI7Qf8Seg+dLiWzVOA2BAH6FrQXRyvtFYuWqGIryWp0Za1rFlq/6ahnwvxgYDSrnGJa4vr52WlpmnP/PYmWpNScTrBaDc68YeaLS6NqwPISseVoBtioOodCI1SvOY9WFgBwB2e+nWzCUegAtY77bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763348792; c=relaxed/relaxed;
	bh=zkUkVtaYANx14A78qG4oH+hGsB28R5OzoHfZ+Xxr/M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM5LmMUUOoCSf9dr1abTV6IuflfxmgYgxQApMrbkqlPZsiV/k/JjNv7nx9YDRA+Z/5S7+fKSsFox1GfevtFAEwrZhLWVpb5c+324Xh48nilP2MDswPXysmp9C0bVu6MdCYlf6ZnnN/4jxqyj3n2W1sbFJ9Ad7gghlKVu1WkqgX5yNw/AIXbhzCAv6JICWWQOWnWH4NP6/N+595t405O7AyNJdAH6ZJ9VZrEh8XIvYKxA2p0RTLBTmf0Zvyfh+GOmdyCqj6Qo6e/evhMFR+eiNfQwnmnpCCSotHPF3YVfo77EEBqnW7s68EAthSILoB8JTqgUp1brJkrJhOiBcztDXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aHxFqvNq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aHxFqvNq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8t1f0l7xz2xS2
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 14:06:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763348783; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zkUkVtaYANx14A78qG4oH+hGsB28R5OzoHfZ+Xxr/M0=;
	b=aHxFqvNqydqblFCxBD95BBOYrBElWPLSET68wYfP793BQixKgONgQKMO6F/UA8xhlFRu8pJz7VTwLrPvuSZw2h8NAFVgIeu3fjXFLLsSVRdkfkm+izGOoZK3ksmII8lB/Jm2QujksoRQhK/BOY+B/Cf6Ale84PpngLHMC8rKA/E=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsTuQXG_1763348781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:06:22 +0800
Message-ID: <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:06:21 +0800
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
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---

...


> +
> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> +{
> +	struct file *realfile;
> +	struct inode *dedup;
> +
> +	dedup = EROFS_I(inode)->ishare;
> +	if (!dedup)
> +		return -EINVAL;
> +
> +	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
> +				     O_RDONLY, &erofs_file_fops);
> +	if (IS_ERR(realfile))
> +		return PTR_ERR(realfile);
> +
> +	file_ra_state_init(&realfile->f_ra, file->f_mapping);
> +	realfile->private_data = EROFS_I(inode);
> +	file->private_data = realfile;
> +	return 0;

Again, as Amir mentioned before, it should be converted to use (at least)
some of backing file interfaces, please see:
   file_user_path() and file_user_inode() in include/linux/fs.h

Or are you sure /proc/<pid>/maps is shown as expected?

Thanks,
Gao Xiang

